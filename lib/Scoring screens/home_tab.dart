import 'package:flutter/material.dart';
import 'package:scorer/Scoring%20screens/live_screen.dart';
import 'package:scorer/Scoring%20screens/upcoming_screens.dart';
import 'package:scorer/models/all_matches_model.dart';
import 'package:scorer/utils/colours.dart';
import 'package:sizer/sizer.dart';

import '../utils/styles.dart';
import 'completed_screen.dart';
import 'in_the_offing_list.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: AppColor.unselectedTabColor,
              labelColor:  const Color(0xffD78108),
              indicatorColor: const Color(0xffD78108),
              isScrollable: true,
              controller: tabController,
              indicatorWeight: 3.5, // Set the indicator weight
              tabs: [
                Text('Live',style: fontRegular.copyWith(fontSize: 12.sp,),),
                Text('Upcoming',style: fontRegular.copyWith(fontSize: 11.sp,),),
                Text('Completed',style: fontRegular.copyWith(fontSize: 11.sp,),),
                Text('In the offing',style: fontRegular.copyWith(fontSize: 11.sp,),),
              ],
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
                  children: const [
                   LiveScreen(),
                    UpcomingScreen(),
                    CompletedScreen(),
                    InTheOffingScreenList(),
                  ]
              ),
            ),
          ],
        ),
      )
    );
  }
}
