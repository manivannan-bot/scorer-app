import 'package:flutter/material.dart';
import 'package:scorer/commentaryscreens/teamone_playing_list.dart';
import 'package:scorer/commentaryscreens/teamtwo_playing_list.dart';
import 'package:scorer/provider/match_provider.dart';
import 'package:sizer/sizer.dart';

import '../models/matches/match_players_model.dart';
import '../utils/colours.dart';
import '../utils/sizes.dart';


class PlayingElevenListScreen extends StatefulWidget {
  final String matchId;
  final String team1Id;
  final String team2Id;
  const PlayingElevenListScreen(this.matchId,this.team1Id,this.team2Id,{super.key});

  @override
  State<PlayingElevenListScreen> createState() => _PlayingElevenListScreenState();
}

class _PlayingElevenListScreenState extends State<PlayingElevenListScreen>with SingleTickerProviderStateMixin {
  late TabController tabController;
  MatchPlayersModel? matchPlayers1;
  MatchPlayersModel? matchPlayers2;

  void initState() {

    super.initState();
    tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

  fetchData()async{
    await MatchProvider().getMatchPlayers(widget.matchId,widget.team1Id).then((value) {
      setState(() {
        matchPlayers1=value;
      });
    });

    MatchProvider().getMatchPlayers(widget.matchId,widget.team2Id).then((value) {
      setState(() {
        matchPlayers2=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(matchPlayers1==null || matchPlayers2==null ){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 4.w),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GestureDetector(
                     onTap: (){
                       Navigator.pop(context);
                     },
                     child: Icon(Icons.arrow_back,size: 7.w,)),
                 Text("Playing XI",style: fontMedium.copyWith(
                   fontSize: 17.sp,
                   color: AppColor.blackColour,
                 ),),
                 SizedBox(width: 7.w,),
               ],
             ),
           ),
            SizedBox(height: 2.h,),
            TabBar(
              unselectedLabelColor: AppColor.unselectedTabColor,
              labelColor:  Color(0xffD78108),
              indicatorColor: Color(0xffD78108),
              isScrollable: true,
              controller: tabController,
              indicatorWeight: 4.0, // Set the indicator weight
              tabs: [
                Text('${matchPlayers1!.data!.teams!.first.team1Name}',style: fontRegular.copyWith(fontSize: 14.sp,),),
                Text('${matchPlayers1!.data!.teams!.first.team2Name}',style: fontRegular.copyWith(fontSize: 14.sp,),),
              ],
            ),
            Divider(),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: [
                    TeamOnePlayingList(matchPlayers1!.data!.playersDetails!),
                    TeamTwoPlayingList(matchPlayers2!.data!.playersDetails!),
                  ]
              ),
            ),

          ],
        ),
      ),
    );
  }
}
