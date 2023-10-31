import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/playerdetailsviews/player_info_screen.dart';
import 'package:scorer/playerdetailsviews/player_matches_view_screen.dart';
import 'package:scorer/playerdetailsviews/player_stats_screen.dart';
import 'package:scorer/playerdetailsviews/teams_list_screen.dart';
import 'package:scorer/provider/player_details_provider.dart';
import 'package:sizer/sizer.dart';

import '../models/players/players_overview_model.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import 'overview_player_screen.dart';

class PlayerDetailViewScreen extends StatefulWidget {
  final String playerId;
  const PlayerDetailViewScreen(this.playerId, {super.key});

  @override
  State<PlayerDetailViewScreen> createState() => _PlayerDetailViewScreenState();
}

class _PlayerDetailViewScreenState extends State<PlayerDetailViewScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;
  PlayerOverview? playerOverview;

  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    fetchData();
  }
  fetchData(){
    PlayerDetailsProvider().getPlayerOverView(widget.playerId).then((value){
      setState(() {
        playerOverview=value;
      });
    });
  }

  Color color = Colors.white.withOpacity(0.2);
  @override
  Widget build(BuildContext context) {
    if(playerOverview==null||playerOverview!.data==null){
      return const SizedBox(
        height: 50,
        width:50,
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
            children: [
              Image.asset(Images.playerDetailBg),
              SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,color: AppColor.lightColor,)),
                    Column(
                      children: [
                        Image.asset(Images.playersImage,width: 18.w,),
                        Text('${playerOverview!.data!.playerInfo!.playerName}',
                          style: fontMedium.copyWith(fontSize: 15.sp,color: AppColor.lightColor),),
                        SizedBox(height: 0.5.h,),
                        Text('ID:${playerOverview!.data!.playerInfo!.playerId}',
                          style: fontRegular.copyWith(fontSize: 12.sp,color: AppColor.lightColor),),
                      ],
                    ),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 0.5.h,),
              Positioned(
                bottom: 1.5.h,
                left: 5.w,
                right: 5.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color,
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Batting",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.lightColor,
                              ),),
                              SizedBox(width: 1.w,),
                              SvgPicture.asset(Images.batIcon,width: 5.w,),
                            ],
                          ),
                          Text("${playerOverview!.data!.playerInfo!.battingStyle}",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.lightColor,
                          ),),
                        ],
                      ),
                      //SizedBox(width: 5.w,),
                      Spacer(),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Bowling",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.lightColor,
                              ),),
                              SizedBox(width: 1.w,),
                              SvgPicture.asset(Images.ballIcon,width: 5.w,),
                            ],
                          ),
                          Text("${playerOverview!.data!.playerInfo!.bowlingStyle}",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.lightColor,
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h,),
          TabBar(
            unselectedLabelColor: AppColor.unselectedTabColor,
            labelColor:  Color(0xffD78108),
            indicatorColor: Color(0xffD78108),
            isScrollable: true,
            controller: tabController,
            indicatorWeight: 4.0,
            indicatorPadding: EdgeInsets.zero,// Set the indicator weight
            tabs: [
              Text('Overview',style: fontRegular.copyWith(fontSize: 14.sp,),),
              Text('Matches',style: fontRegular.copyWith(fontSize: 14.sp,),),
              Text('Stats',style: fontRegular.copyWith(fontSize: 14.sp,),),
              Text('Teams',style: fontRegular.copyWith(fontSize: 14.sp,),),
              Text('Playerinfo',style: fontRegular.copyWith(fontSize: 14.sp,),),
            ],
          ),
          Divider(),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: [
                  OverviewPlayerScreen(playerOverview!.data!.battingPerformance,playerOverview!.data!.bowlingPerformance,playerOverview!.data!.recentBatting,playerOverview!.data!.recentBowling),
                  PlayerMatchesViewScreen(widget.playerId),
                  PlayerStatsScreen(widget.playerId),
                  TeamListScreen(widget.playerId),
                  PlayerInfoScreen(widget.playerId),
                ]
            ),
          ),
        ],
      ),
    );
  }
}
