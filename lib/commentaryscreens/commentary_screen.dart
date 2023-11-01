import 'package:flutter/material.dart';
import 'package:scorer/commentaryscreens/commentary_four_six_screen.dart';
import 'package:sizer/sizer.dart';

import '../models/score_card_response_model.dart';
import '../provider/scoring_provider.dart';
import '../scorecardScreens/scorecard_one.dart';
import '../scorecardScreens/scorecard_two.dart';
import '../utils/colours.dart';
import '../utils/sizes.dart';
import 'commentary_all_screen.dart';
import 'commentary_wicket_screen.dart';
import 'commentry_overs_screen.dart';


class CommentaryScreen extends StatefulWidget {
  final String matchId;
  final String team1Id;
  final String team2Id;
  final VoidCallback fetchData;
  const CommentaryScreen(this.matchId, this.team1Id, this.team2Id, this.fetchData,{super.key});

  @override
  State<CommentaryScreen> createState() => _CommentaryScreenState();
}

class _CommentaryScreenState extends State<CommentaryScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;
  ScoreCardResponseModel? scoreCardResponseModel;

  int? currentIndex;


  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
    fetchData();
  }
  fetchData(){
    // ScoringProvider().getScoreCard(widget.matchId, widget.team1Id).then((value){
    //   setState(() {
    //     scoreCardResponseModel=value;
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 0.w),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
        color: AppColor.lightColor
        ),
        child: Column(
          children: [
            TabBar(
                labelPadding: EdgeInsets.symmetric(vertical: 0.1.h,horizontal: 4.w),
                labelColor: Colors.white,
                indicatorPadding: EdgeInsets.zero,
                // unselectedLabelColor: AppColor.textColor,
                // unselectedLabelStyle: TextStyle(
                //   backgroundColor: Colors.grey, // Background color of inactive tabs
                // ),
                indicatorColor: Colors.transparent,
                isScrollable: true,
                // dividerColor: Colors.transparent,
                // labelPadding: EdgeInsets.only
                //   (bottom: 0.5.h) + EdgeInsets.symmetric(
                //     horizontal: 4.w
                // ),
                indicatorSize: TabBarIndicatorSize.tab,
                // indicatorColor: AppColor.secondaryColor,
                controller: tabController,
                tabs: [
                  Tab(
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: currentIndex == 0 ? AppColor.primaryColor : Colors.transparent,
                        border: currentIndex == 0 ? null : Border.all(color: Colors.black12)
                      ),
                      child: Text('All',style: fontMedium.copyWith(fontSize: 13.sp,color: AppColor.blackColour),),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: currentIndex == 1 ? AppColor.primaryColor : Colors.transparent,
                          border: currentIndex == 1 ? null : Border.all(color: Colors.black12)
                      ),
                      child: Text('Overs',style: fontMedium.copyWith(fontSize: 13.sp,color: AppColor.blackColour),),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: currentIndex == 2 ? AppColor.primaryColor : Colors.transparent,
                          border: currentIndex == 2 ? null : Border.all(color: Colors.black12)
                      ),
                      child: Text('W',style: fontMedium.copyWith(fontSize: 13.sp,color: AppColor.blackColour),),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: currentIndex == 3 ? AppColor.primaryColor : Color(0xffFBFAF7),
                          border: currentIndex == 3 ? null : Border.all(color: Colors.black12)
                      ),
                      child: Text('4s & 6s',style: fontMedium.copyWith(fontSize: 13.sp,color: AppColor.blackColour),),
                    ),
                  ),
                ]
            ),
            SizedBox(height: 1.h,),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children:  [

                    CommentaryAllScreen(),
                    CommentryOvers(widget.matchId,widget.team1Id),
                    CommentaryWicketScreen(widget.matchId,widget.team1Id),
                    CommentaryFourSix(widget.matchId,widget.team1Id),


                  ]),
            ),
          ],
        ),
      ),

    );
  }
}
