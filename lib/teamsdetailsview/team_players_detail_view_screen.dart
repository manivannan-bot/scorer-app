import 'package:flutter/material.dart';
import 'package:scorer/teamsdetailsview/teams_batter_list_screen.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';

class TeamPlayersDetailViewScreen extends StatefulWidget {
  const TeamPlayersDetailViewScreen({super.key});

  @override
  State<TeamPlayersDetailViewScreen> createState() => _TeamPlayersDetailViewScreenState();
}

class _TeamPlayersDetailViewScreenState extends State<TeamPlayersDetailViewScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 70.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            color: AppColor.lightColor
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                child: TabBar(
                  unselectedLabelColor: AppColor.unselectedTabColor,
                  labelColor:  Color(0xffD78108),
                  indicatorColor: Color(0xffD78108),
                  isScrollable: true,
                  controller: tabController,
                  indicatorWeight: 2.0,
                  indicatorPadding: EdgeInsets.zero,
                  tabs: [
                    Text('Batters',style: fontRegular.copyWith(fontSize: 14.sp,),),
                    Text('Bowlers',style: fontRegular.copyWith(fontSize: 14.sp,),),
                    Text('Allrounders',style: fontRegular.copyWith(fontSize: 14.sp,),),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: [
                    TeamsBatterListScreen(),
                    Container(),Container(),

                  ]
              ),
            ),
          ],
        ),
      ),

    );
  }
}
