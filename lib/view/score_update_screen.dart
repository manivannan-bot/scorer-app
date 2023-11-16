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
   int currentInning=1;
   bool loading = false;
   String currentOverData = "";
   String? target;

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
     final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //setting batting and bowling team id's
     WidgetsBinding.instance.addPostFrameCallback((_) {
       setState(() {
         batTeamId = int.parse(widget.team1id);
         bowlTeamId = int.parse(widget.team2id);
       });
     });
     debugPrint("team1 id ${widget.team1id} team 2 id ${widget.team2id}");
     //getting live score
     await ScoringProvider().getLiveScore(widget.matchId, widget.team1id).then((data) async{
       //setting match list
     setState(() {
       matchList = data.matches;
       currentInning=data.matches!.currentInnings!;
       target = data.target.toString();
       currentOverData = data.matches!.teams!.currentOverDetails.toString();
     });
     int overNumber = 0;
     int ballNumber = 0;

     if(score.overNumberInnings != 0 || score.ballNumberInnings != 0){
       debugPrint("crossed 0th over - ON ${score.overNumberInnings} BN ${score.ballNumberInnings}");
       debugPrint("getting the over number and ball number from previous score update response for next ball");
       overNumber = score.overNumberInnings;
       ballNumber = score.ballNumberInnings;
     } else {
       debugPrint("0th over of the innings - over number and ball number are 0");
       debugPrint("getting the over number and ball number from getlive score api - ON $overNumber BN $ballNumber");
       overNumber = data.matches!.teams!.overNumber ?? 0;
       ballNumber = data.matches!.teams!.ballNumber ?? 0;
     }
     //setting over number and ball number values for next ball
         if (overNumber == 0 && ballNumber == 0) {
           overNumber = 0;
           ballNumber = 1;
           debugPrint("over number and ball number are 0");
         }
     debugPrint("while setting value to provider");
       score.setOverNumber(overNumber);
       score.setBallNumber(ballNumber);
     await prefs.setInt('current_innings',data.matches!.currentInnings??1);

     refreshController.refreshCompleted();
     });
   }

   String calculateRequiredRuns(String target, String currentRuns){
     int requiredRuns = int.parse(target) - int.parse(currentRuns);
     String result = requiredRuns.toString();
     return result;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          currentInning == 2
                              ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.lightColor,
                            ),
                            child: Text(
                              'Target: $target',
                              style: fontSemiBold.copyWith(
                                fontSize: 10.sp,
                                color: AppColor.blackColour,
                              ),
                            ),
                          )
                          : Text(
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                currentInning == 2 ? const SizedBox() : Text(
                                  '${matchList!.tossWinnerName} won the Toss\nand Choose to ${matchList!.choseTo} ',
                                  textAlign: TextAlign.center,
                                  style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: AppColor.lightColor
                                  )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${matchList!.teams!.totalRuns}',
                                        style: fontMedium.copyWith(
                                            fontSize: 22.sp,
                                            color: AppColor.lightColor
                                        )),
                                    Text('/',
                                        style: fontMedium.copyWith(
                                            fontSize: 23.sp,
                                            color: AppColor.lightColor
                                        )),
                                    Text('${matchList!.teams!.totalWickets}',
                                        style: fontMedium.copyWith(
                                            fontSize: 22.sp,
                                            color: AppColor.lightColor
                                        )),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Text(
                                    'Overs: ${matchList!.teams!.currentOverDetails}/${matchList!.overs}',
                                    style: fontMedium.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.blackColour,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h,),
                                Text("Innings ${matchList!.currentInnings??'0'}",
                                  style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.lightColor,
                                ),),
                                currentInning == 2
                                    ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 1.h,),
                                    Text("${matchList!.teams!.teamName.toString()} "
                                        "need ${calculateRequiredRuns(target.toString(), matchList!.teams!.totalRuns.toString())} more"
                                        " ${int.parse(calculateRequiredRuns(target.toString(), matchList!.teams!.totalRuns.toString())) > 1 ? "runs" : "run"} to win",
                                      textAlign: TextAlign.center,
                                      style: fontRegular.copyWith(
                                        fontSize: 11.sp,
                                        color: AppColor.lightColor,
                                      ),),
                                  ],
                                ) : const SizedBox(),

                              ],
                            ),
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
            TabBar(
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
            Theme(
                data: ThemeData(
                  dividerTheme: const DividerThemeData(
                    space: 0,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                child: const Divider()),
              SizedBox(height: 2.h,),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children:  [
                      ScoringTab(widget.matchId,batTeamId.toString(),bowlTeamId.toString(), fetchData, currentOverData),
                      ScorecardScreen(widget.matchId,batTeamId.toString(),bowlTeamId.toString(),currentInning.toString(),fetchData),
                      CommentaryScreen(widget.matchId,batTeamId.toString(),bowlTeamId.toString(),fetchData),
                      InfoScreen(widget.matchId),
                    ]),
              )
            ],
          ),
        ),
      );
  }
}
