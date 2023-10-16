import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scorer/models/get_live_score_model.dart';
import 'package:scorer/pages/scoring_tab.dart';
import 'package:scorer/utils/pusher_service.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../provider/scoring_provider.dart';
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
       team1Id=data.matches!.first.team1Id;
       team2Id=data.matches!.first.team2Id;
     });
     var overNumber=data.matches!.first.teams!.first.overNumber??0;
     var ballNumber=data.matches!.first.teams!.first.ballNumber??0;
     if(overNumber ==0 && ballNumber==0){overNumber=0;ballNumber=1;
     }else if(ballNumber==6) {
       overNumber += 1;
       ballNumber = 1;
     }else if(ballNumber<6){
       ballNumber+=1;
     }else if(ballNumber>6){
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
          child: Center(child: CircularProgressIndicator())); // Example of a loading indicator
    }
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        onRefresh: fetchData,
        controller: _refreshController,
        child: Stack(
          children: [
            // Background image
            Image.asset(
              Images.bannerBg,
              fit: BoxFit.cover, // You can choose how the image should be scaled
              width: double.infinity,
              height: 250,
            ),
            Container(
              child: Column(
                children: [
                  Container(height: 40,width: 20,),
                  // Arrow and Text
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back,color: Colors.white,),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(width: 120,),
                      const Center(
                        child: Text(
                          'Team',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24, // Adjust the font size as needed
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Container(width: 20,),
                      Column(
                        children: [
                          Container(
                            width: 80, // Set the desired width
                            height: 80, // Set the desired height
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0, // Adjust the border width as needed
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                Images.csk_team_logo,
                                width: 100, // Match the container's width
                                height: 100, // Match the container's height
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ),
                          ),
                          Text(
                            '${matchlist!.first.team1Name}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12, // Adjust the font size as needed
                            ),
                          ),
                        ],
                      ),
                      Container(width: 20,),
                      Center(
                        child: Column(
                          children: [

                                Text(
                                  '${matchlist!.first.tossWinnerName} won the Toss ',
                                  style: TextStyle(color: Colors.white),
                                ),
                            Text(
                              'and Choose to ${matchlist!.first.choseTo} ',
                              style: TextStyle(color: Colors.white),
                            ),

                            Text('${matchlist!.first.teams!.first.totalRuns}/${matchlist!.first.teams!.first.totalWickets}',style: TextStyle(color: Colors.white,fontSize: 24),),
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                'Overs: ${matchlist!.first.teams!.first.overNumber}.${matchlist!.first.teams!.first.ballNumber}/${matchlist!.first.overs}',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            Text('1st Innings',style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                      Container(width: 20,),
                      Column(
                        children: [
                          Container(
                            width: 80, // Set the desired width
                            height: 80, // Set the desired height
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0, // Adjust the border width as needed
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                Images.mi_team_logo,
                                width: 100, // Match the container's width
                                height: 100, // Match the container's height
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ),
                          ),
                          const Text(
                            'MI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12, // Adjust the font size as needed
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              Container(height: 50,width: 200,),
                  Padding(
                    padding:  EdgeInsets.only(bottom: 2.h,),
                    child: TabBar(
                        labelPadding: EdgeInsets.symmetric(vertical: 0.4.h,horizontal: 3.5.w),
                        labelColor: Colors.orange,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,

                        dividerColor: Colors.transparent,
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
                          ScoringTab(widget.matchId,team1Id.toString(),team2Id.toString()),
                          Container(height: 50,width: 50,color: Colors.blue,),
                          Container(height: 50,width: 50,color: Colors.red,),
                          Container(height: 50,width: 50,color: Colors.blue,)
                        ]),
                  )


                ],
              ),
            ),





          ],
        ),
      ),
    );
  }
}
