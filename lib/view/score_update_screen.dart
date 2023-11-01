import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scorer/models/get_live_score_model.dart';
import 'package:scorer/view/scoring_tab.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Scoring screens/home_screen.dart';
import '../commentaryscreens/commentary_screen.dart';
import '../commentaryscreens/info_screen.dart';
import '../provider/score_update_provider.dart';
import '../provider/scoring_provider.dart';
import '../scorecardScreens/scorecard_screen.dart';
import '../utils/images.dart';

class ScoreUpdateScreen extends StatefulWidget  {
  final String matchId;
  final String team1id, team2id;
  const ScoreUpdateScreen(this.matchId, this.team1id, this.team2id, {super.key});

  @override
  State<ScoreUpdateScreen> createState() => _ScoreUpdateScreenState();
}

class _ScoreUpdateScreenState extends State<ScoreUpdateScreen> with SingleTickerProviderStateMixin{
   late TabController tabController;
   Matches? matchList;
   RefreshController refreshController = RefreshController();
   int? batTeamId;
   int? bowlTeamId;
   bool loading = false;

   setDelay() async{
     if(mounted){
       setState(() {
         loading = true;
       });
     }
     await Future.delayed(const Duration(seconds: 1));
     if(mounted){
       setState(() {
         loading = false;
       });
     }
   }

   @override
  void initState() {
     matchList=null;
    super.initState();
    tabController = TabController(length: 4, vsync: this);
     fetchData();
  }

   Future<void> fetchData() async {
     WidgetsBinding.instance.addPostFrameCallback((_) {
       setState(() {
         batTeamId = int.parse(widget.team1id);
         bowlTeamId = int.parse(widget.team2id);
       });
     });
     await ScoringProvider().getLiveScore(widget.matchId, widget.team1id).then((data) async{
     setState(() {
       matchList = data.matches;
     });
     final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var overNumber = score.overNumberInnings;
     var ballNumber = score.ballNumberInnings;
     WidgetsBinding.instance.addPostFrameCallback((_) {
       score.setOverNumber(overNumber);
       score.setBallNumber(ballNumber);
       score.setOverAndBallNumberToPrefs();
     });

     print("over number $overNumber ball number $ballNumber");
     //incrementing over number and ball number
         if (overNumber == 0 && ballNumber == 0) {
           overNumber = 0;
           ballNumber = 1;
         } else if (ballNumber >= 6) {
           overNumber += 1;
           ballNumber = 1;
           score.incrementOverNumber();
           score.setBallNumber(1);
         } else if ( ballNumber == 0) {
           ballNumber = 1;
         } else if (ballNumber < 6) {
           ballNumber += 1;
           score.incrementBallNumber();
         }
         WidgetsBinding.instance.addPostFrameCallback((_) {
           score.setOverNumber(overNumber);
           score.setBallNumber(ballNumber);
         });
     await prefs.setInt('current_innings',data.matches!.currentInnings??1);
     refreshController.refreshCompleted();
     });
   }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const HomeScreen()));
        return true;
      },
      child: Scaffold(
        body: matchList == null
            ? const Center(child: CircularProgressIndicator(
            ))
        : loading
            ? const Center(child: CircularProgressIndicator(
        )) : SmartRefresher(
          enablePullDown: true,
          onRefresh: fetchData,
          controller: refreshController,
          child: Column(
            children: [
              Stack(
                children: [
                  // Background image
                  Image.asset(
                    Images.bannerBg,
                    fit: BoxFit.cover, // You can choose how the image should be scaled
                    width: double.infinity,
                     height: 30.h,
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    right: 5.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap:(){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const HomeScreen()));
                                },
                                child: Icon(Icons.arrow_back,color: AppColor.lightColor, size: 7.w,)),
                            Text(
                              'Team',
                              style: fontMedium.copyWith(
                                fontSize: 18.sp,
                                color: AppColor.lightColor
                              )
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                          ],
                        ),
                         SizedBox(height: 2.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                               Image.asset(Images.teamaLogo,width: 20.w,),
                                Text(
                                  '${matchList!.team1Name}',
                                  style: fontMedium.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColor.lightColor
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${matchList!.tossWinnerName} won the Toss\nand Choose to ${matchList!.choseTo} ',
                                  textAlign: TextAlign.center,
                                  style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: AppColor.lightColor
                                  )
                                ),
                                Text('${matchList!.teams!.totalRuns}/${matchList!.teams!.totalWickets}',
                                    style: fontMedium.copyWith(
                                    fontSize: 25.sp,
                                    color: AppColor.lightColor
                                )),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Text(
                                    'Overs: ${matchList!.teams!.currentOverDetails}/${matchList!.overs}',
                                    style: fontMedium.copyWith(
                                      fontSize: 11.sp,
                                      color: AppColor.blackColour,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h,),
                                Text("Innings ${matchList!.currentInnings??'0'}",
                                  style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.lightColor,
                                ),)
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(Images.teamaLogo,width: 20.w,),
                                 Text(
                                     '${matchList!.team2Name}',
                                  style:fontMedium.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColor.lightColor)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(bottom: 2.h,),
                child: TabBar(
                    unselectedLabelColor: AppColor.unselectedTabColor,
                    labelColor:  const Color(0xffD78108),
                    indicatorColor: const Color(0xffD78108),
                    isScrollable: true,
                    indicatorWeight: 2.0,
                     labelPadding: EdgeInsets.symmetric(vertical: 0.4.h, horizontal: 3.5.w),
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: tabController,
                    tabs: [
                      Text('Scoring',style: fontRegular.copyWith(fontSize: 12.sp,),),
                      Text('Score Card',style: fontRegular.copyWith(fontSize: 12.sp,),),
                      Text('Commentary',style: fontRegular.copyWith(fontSize: 12.sp,),),
                      Text('Info',style: fontRegular.copyWith(fontSize: 12.sp,),),
                    ]
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children:  [
                      ScoringTab(widget.matchId,batTeamId.toString(),bowlTeamId.toString(), fetchData),
                      ScorecardScreen(widget.matchId,batTeamId.toString(),fetchData),
                      CommentaryScreen(widget.matchId,batTeamId.toString(),bowlTeamId.toString(),fetchData),
                      InfoScreen(widget.matchId),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
