import 'package:flutter/material.dart';
import 'package:scorer/Scoring%20screens/live_screen.dart';
import 'package:scorer/Scoring%20screens/upcoming_screens.dart';
import 'package:scorer/models/all_matches_model.dart';
import 'package:scorer/utils/colours.dart';
import 'package:sizer/sizer.dart';

import '../utils/styles.dart';
import 'completed_screen.dart';

class HomeTab extends StatefulWidget {


  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController tabController;
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F9FA),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: AppColor.unselectedTabColor,
              labelColor:  Color(0xffD78108),
              indicatorColor: Color(0xffD78108),
              isScrollable: true,
              controller: tabController,
              indicatorWeight: 4.0, // Set the indicator weight
              tabs: [
                Text('Live',style: fontRegular.copyWith(fontSize: 12.sp,),),
                Text('Upcoming',style: fontRegular.copyWith(fontSize: 12.sp,),),
                Text('Completed',style: fontRegular.copyWith(fontSize: 12.sp,),),
                Text('In the offing',style: fontRegular.copyWith(fontSize: 12.sp,),),
              ],
            ),
            Divider(),
            Expanded(
              child: TabBarView(
                controller: tabController,
                  children: [
                   LiveScreen(),
                    UpcomingScreen(),
                    CompletedScreen(),
                    Container(),
                  ]
              ),
            ),
          ],
        ),
      )
    );
  }
}
