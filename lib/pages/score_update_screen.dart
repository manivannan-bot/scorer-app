import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scorer/models/get_live_score_model.dart';
import 'package:scorer/pages/scoring_tab.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/pusher_service.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


import '../commentaryscreens/commentary_screen.dart';
import '../commentaryscreens/info_screen.dart';
import '../provider/scoring_provider.dart';
import '../scorecardScreens/scorecard_screen.dart';
import '../utils/images.dart';

class ScoreUpdateScreen extends StatefulWidget  {
  final String matchId; // Add matchId as a parameter
  final String team1id;
  const ScoreUpdateScreen(this.matchId, this.team1id, {super.key});
  //const ScoreUpdateScreen(this.matchId, this.team1id, {Key? key}) : super(key: key);


  @override
  State<ScoreUpdateScreen> createState() => _ScoreUpdateScreenState();
}

class _ScoreUpdateScreenState extends State<ScoreUpdateScreen> with SingleTickerProviderStateMixin{
   late TabController tabController;
   List<Matches>? matchlist;
   RefreshController _refreshController = RefreshController();
   int? team1Id;
   int? team2Id;



   @override
  void initState() {

     matchlist=null;
    super.initState();
    tabController = TabController(length: 4, vsync: this);
     fetchData();
  }
   Future<void> fetchData() async {

     var data = await ScoringProvider().getLiveScore(widget.matchId, widget.team1id);
     setState(() {
       matchlist = data.matches;
           if(matchlist!.first.wonBy==matchlist!.first.team1Id && matchlist!.first.choseTo=='Bat' ) {
             team1Id=data.matches!.first.team1Id;
             team2Id=data.matches!.first.team2Id;
           }else{
             team1Id=data.matches!.first.team2Id;
             team2Id=data.matches!.first.team1Id;
           }

     });
     var overNumber=data.matches!.first.teams!.first.overNumber??0;
     var ballNumber=data.matches!.first.teams!.first.ballNumber??0;
     if(overNumber ==0 && ballNumber==0){
       overNumber=0;ballNumber=1;
     }else if(ballNumber==6) {
       overNumber += 1;
       ballNumber = 1;
     }else if(ballNumber==0) {
       overNumber += 1;
       ballNumber = 1;
     }else if(ballNumber<6){
       ballNumber+=1;
     }else if(ballNumber>6){
       overNumber += 1;
       ballNumber=1;
     }

     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setInt('over_number', overNumber);
     await prefs.setInt('ball_number',ballNumber);
     _refreshController.refreshCompleted();
   }

  @override
  Widget build(BuildContext context) {
    if (matchlist == null) {
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ))); // Example of a loading indicator
    }
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        onRefresh: fetchData,
        controller: _refreshController,
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  // Background image
                  Image.asset(
                    Images.bannerBg,
                    fit: BoxFit.cover, // You can choose how the image should be scaled
                    width: double.infinity,
                     height: 26.h,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back,color: AppColor.lightColor,),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Text(
                              'Team',
                              style: fontMedium.copyWith(
                                fontSize: 18.sp,
                                color: AppColor.lightColor
                              )
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                          ],
                        ),
                         SizedBox(height: 1.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                               Image.asset(Images.teamaLogo,width: 20.w,),
                                Text(
                                  '${matchlist!.first.team1Name}',
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
                                  '${matchlist!.first.tossWinnerName} won the Toss ',
                                  style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: AppColor.lightColor
                                  )
                                ),
                                Text(
                                  'and Choose to ${matchlist!.first.choseTo} ',
                                  style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: AppColor.lightColor
                                  )
                                ),
                                Text('${matchlist!.first.teams!.first.totalRuns}/${matchlist!.first.teams!.first.totalWickets}',style: fontMedium.copyWith(
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
                                    'Overs: ${matchlist!.first.teams!.first.currentOverDetails}/${matchlist!.first.overs}',
                                    style: fontMedium.copyWith(
                                      fontSize: 11.sp,
                                      color: AppColor.blackColour,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h,),
                                Text("Innings ${matchlist!.first.currentInnings??'0'}",style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.lightColor,
                                ),)
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(Images.teamaLogo,width: 20.w,),
                                 Text(
                                     '${matchlist!.first.team2Name}',
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
                    labelColor:  Color(0xffD78108),
                    indicatorColor: Color(0xffD78108),
                    isScrollable: true,
                    controller: tabController,
                    indicatorWeight: 2.0,
                     labelPadding: EdgeInsets.symmetric(vertical: 0.4.h,horizontal: 3.5.w),
                    // labelColor: Colors.orange,
                    // unselectedLabelColor: Colors.grey,
                    // isScrollable: true,
                    // dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    // controller: tabController,
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
                      ScoringTab(widget.matchId,team1Id.toString(),team2Id.toString(), fetchData),
                      ScorecardScreen(),
                      CommentaryScreen(),
                      InfoScreen(),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
