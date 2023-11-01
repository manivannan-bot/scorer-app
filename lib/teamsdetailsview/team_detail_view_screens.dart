import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/models/teams/team_info_model.dart';
import 'package:scorer/provider/teams_provider.dart';
import 'package:scorer/teamsdetailsview/team_info_screen.dart';
import 'package:scorer/teamsdetailsview/team_matches_screen.dart';
import 'package:scorer/teamsdetailsview/team_overview_screen.dart';
import 'package:scorer/teamsdetailsview/team_players_detail_view_screen.dart';
import 'package:sizer/sizer.dart';

import '../playerdetailsviews/overview_player_screen.dart';
import '../playerdetailsviews/player_stats_screen.dart';
import '../playerdetailsviews/teams_list_screen.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamDetailViewScreens extends StatefulWidget {
  final String teamId;
  const TeamDetailViewScreens(this.teamId, {super.key});

  @override
  State<TeamDetailViewScreens> createState() => _TeamDetailViewScreensState();
}

class _TeamDetailViewScreensState extends State<TeamDetailViewScreens>with SingleTickerProviderStateMixin {
  late TabController tabController;
  TeamInfoModel? teamInfoModel;

  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    fetchData();
  }
  fetchData(){
    TeamsProvider().getTeamInfo(widget.teamId).then((value){
      setState(() {
        teamInfoModel=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    if(teamInfoModel==null){
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
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(Images.teamBgImage),
              Positioned(
                top: 7.h,
                left: 5.w,
                right: 5.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,color: AppColor.lightColor,)),
                    Text('Team',
                      style: fontMedium.copyWith(fontSize: 16.sp,color: AppColor.lightColor),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              Positioned(
                bottom: 4.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(child: Image.asset(Images.teamListImage,width: 25.w,)),
                    SizedBox(height: 0.h,),
                    Text('${teamInfoModel!.data!.teams!.teamName}',
                      style: fontSemiBold.copyWith(fontSize: 16.sp,color: AppColor.lightColor),),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h,),
          TabBar(
            unselectedLabelColor: AppColor.unselectedTabColor,
            labelColor:  Color(0xffD78108),
            indicatorColor: Color(0xffD78108),
            isScrollable: true,
            controller: tabController,
            indicatorWeight: 2.0,
            indicatorPadding: EdgeInsets.zero,// Set the indicator weight
            tabs: [
              Text('Overview',style: fontRegular.copyWith(fontSize: 14.sp,),),
              Text('Matches',style: fontRegular.copyWith(fontSize: 14.sp,),),
              Text('Players',style: fontRegular.copyWith(fontSize: 14.sp,),),
              Text('Teaminfo',style: fontRegular.copyWith(fontSize: 14.sp,),),

            ],
          ),
          Divider(),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: [
                  TeamOverviewScreen(widget.teamId),
                  TeamMatchesScreen(widget.teamId),
                  TeamPlayersDetailViewScreen(widget.teamId),
                  TeamInfoScreen(teamInfoModel!.data!.teamsDetails),
                ]
            ),
          ),
        ],
      ),
    );
  }
}
