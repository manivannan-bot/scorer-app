import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:scorer/scorecardScreens/scorecard_one.dart';
import 'package:scorer/scorecardScreens/scorecard_two.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:sizer/sizer.dart';

import '../Scoring screens/home_tab.dart';


class ScorecardScreen extends StatefulWidget {
  const ScorecardScreen({super.key});

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen>with SingleTickerProviderStateMixin{
  late TabController tabController;


  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 6.w),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
              color: AppColor.blackColour,
            ),
            child: Text("CRR: 4.50",style: fontMedium.copyWith(
              fontSize: 10.sp,
              color: AppColor.lightColor,
            ),),
          ),
          SizedBox(height: 1.h,),
          TabBar(
              labelPadding: EdgeInsets.symmetric(vertical: 0.1.h,horizontal: 5.w),
              labelColor: Colors.white,
              // unselectedLabelColor: AppColor.textColor,
              // unselectedLabelStyle: TextStyle(
              //   backgroundColor: Colors.grey, // Background color of inactive tabs
              // ),
              isScrollable: true,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.primaryColor
              ),
              // dividerColor: Colors.transparent,
              // labelPadding: EdgeInsets.only
              //   (bottom: 0.5.h) + EdgeInsets.symmetric(
              //     horizontal: 4.w
              // ),
              indicatorSize: TabBarIndicatorSize.tab,
              // indicatorColor: AppColor.secondaryColor,
              controller: tabController,
              tabs: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 04.w,vertical: 0.4.h),
                  child: Text('DCC',style: fontMedium.copyWith(fontSize: 13.sp,color: AppColor.blackColour),),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text('SP Yet to bat',style: fontMedium.copyWith(fontSize: 13.sp,color: AppColor.blackColour),),
                ),
              ]
          ),
          SizedBox(height: 1.h,),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children:  [
                  ScoreCardOne(),
                  ScoreCardTwo(),
                ]),
          ),
        ],
      ),
    );
  }
}
