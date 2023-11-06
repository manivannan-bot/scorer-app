import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:scorer/models/players/player_matches_model.dart';
import 'package:scorer/playerdetailsviews/player_completed_matches.dart';
import 'package:scorer/provider/player_details_provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/Individual_player_completed_list.dart';
import '../widgets/individual_player_live_matches.dart';
import '../widgets/individual_player_upcoming_matches.dart';

class PlayerMatchesViewScreen extends StatefulWidget {
  final String playerId;
  const PlayerMatchesViewScreen(this.playerId, {super.key});

  @override
  State<PlayerMatchesViewScreen> createState() => _PlayerMatchesViewScreenState();
}

class _PlayerMatchesViewScreenState extends State<PlayerMatchesViewScreen> {

  PlayerMatchesModel? playerMatchesModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData(){
    PlayerDetailsProvider().getPlayerMatches(widget.playerId).then((value) {
      setState(() {
        playerMatchesModel=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(playerMatchesModel==null){
      return const SizedBox(
        height: 50,
        width: 50,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if(playerMatchesModel!.data!.isEmpty){
      return const Center(child: Text('No data found'),);
    }
    return Container(
        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            color: AppColor.lightColor
        ),
        child: Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true, // Remove top system padding (status bar)
            removeBottom: true,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                  );
                },
                itemCount:playerMatchesModel!.data!.length ,
                itemBuilder: (context, int index) {
                  final item = playerMatchesModel!.data![index];

                  if (playerMatchesModel!.data![index].teams!.matchStatus == 1) {
                    return IndividualPlayerLiveMatches(playerMatchesModel!.data![index].teams,playerMatchesModel!.data![index].teamInnings);
                  } else if (playerMatchesModel!.data![index].teams!.matchStatus == 1) {
                    return IndividualPlayerUpcomingMatches();
                  }  else if (playerMatchesModel!.data![index].teams!.matchStatus == 2) {
                    return PlayerCompletedMatches(playerMatchesModel!.data![index].teams,playerMatchesModel!.data![index].teamInnings);
                    //return Container();
                  }
                  return Container();
                }),
          ),
        )
    );
  }
}
