import 'package:flutter/material.dart';
import 'package:scorer/models/teams/team_players_model.dart';
import 'package:scorer/provider/teams_provider.dart';
import 'package:scorer/teamsdetailsview/teams_batter_list_screen.dart';
import 'package:scorer/teamsdetailsview/teams_bowler_list_screen.dart';
import 'package:scorer/teamsdetailsview/teams_keeper_list_screen.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';

class TeamPlayersDetailViewScreen extends StatefulWidget {
  final String teamId;
  const TeamPlayersDetailViewScreen(this.teamId, {super.key});

  @override
  State<TeamPlayersDetailViewScreen> createState() => _TeamPlayersDetailViewScreenState();
}

class _TeamPlayersDetailViewScreenState extends State<TeamPlayersDetailViewScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;
  TeamPlayersModel? teamPlayersModel;
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    fetchData();
  }
  fetchData(){
    TeamsProvider().getTeamPlayers(widget.teamId).then((value) {
      setState(() {
        teamPlayersModel=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(teamPlayersModel==null){
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
    if(teamPlayersModel!.data==null){
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
                    TeamsBatterListScreen(teamPlayersModel!.data!.batsman),
                    TeamsBowlerListScreen(teamPlayersModel!.data!.bowler),
                    TeamsAllRounderListScreen(teamPlayersModel!.data!.allRounder),

                  ]
              ),
            ),
          ],
        ),
      ),

    );
  }
}
