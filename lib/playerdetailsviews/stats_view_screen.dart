import 'package:flutter/material.dart';
import 'package:scorer/playerdetailsviews/player_batting_details.dart';
import 'package:scorer/playerdetailsviews/player_bowling_details.dart';
import 'package:scorer/playerdetailsviews/stats_batting_details.dart';
import 'package:scorer/playerdetailsviews/stats_bowling_details.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';

class StatsViewScreen extends StatefulWidget {
  const StatsViewScreen({super.key});

  @override
  State<StatsViewScreen> createState() => _StatsViewScreenState();
}

class _StatsViewScreenState extends State<StatsViewScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;


  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 68.h,
            padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                color: AppColor.lightColor
            ),
            child: Column(
              children: [
                Center(
                  child: TabBar(
                      labelPadding: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 5.w),
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
                          padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 0.4.h),
                          child: Text('Batting',style: fontMedium.copyWith(fontSize: 12.sp,color: AppColor.blackColour),),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5.w),
                          child: Text('Bowling',style: fontMedium.copyWith(fontSize: 12.sp,color: AppColor.blackColour),),
                        ),
                      ]
                  ),
                ),
                Expanded(
                  child: TabBarView(
                      controller: tabController,
                      children:  [
                        StatsBatting(),
                        StatsBowling(),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
