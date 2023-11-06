import 'package:flutter/material.dart';
import 'package:scorer/models/teams/team_matches_model.dart';
import 'package:scorer/provider/teams_provider.dart';
import 'package:scorer/teamsdetailsview/team_completed_matches_screen.dart';
import 'package:scorer/teamsdetailsview/team_live_matches_screen.dart';
import 'package:scorer/teamsdetailsview/team_upcoming_matches.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';

class TeamMatchesScreen extends StatefulWidget {
  final String teamId;
  const TeamMatchesScreen(this.teamId, {super.key});

  @override
  State<TeamMatchesScreen> createState() => _TeamMatchesScreenState();
}

class _TeamMatchesScreenState extends State<TeamMatchesScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;
  TeamMatchesModel? teamMatchesModel;
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    fetchData();
  }
  fetchData(){
    TeamsProvider().getTeamMatches(widget.teamId).then((value){
      setState(() {
        teamMatchesModel=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(teamMatchesModel==null){
      return const SizedBox(
        height: 50,
        width: 50,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );
    }
    if(teamMatchesModel!.data==null){
      return const Center(child: Text('No data found'),);
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 70.h,
        decoration: const BoxDecoration(
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
                  labelColor:  const Color(0xffD78108),
                  indicatorColor: const Color(0xffD78108),
                  isScrollable: true,
                  controller: tabController,
                  indicatorWeight: 2.0,
                  indicatorPadding: EdgeInsets.zero,
                  tabs: [
                    Text('Live',style: fontRegular.copyWith(fontSize: 14.sp,),),
                   // Text('Upcoming',style: fontRegular.copyWith(fontSize: 14.sp,),),
                    Text('Completed',style: fontRegular.copyWith(fontSize: 14.sp,),),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: [
                    TeamLiveMatches(teamMatchesModel!.data!.liveMatches),
                    //TeamUpcomingMatches(),
                    TeamCompletedMatchesScreen(teamMatchesModel!.data!.completedMatches),

                  ]
              ),
            ),
          ],
        ),
      ),

    );
  }
}
