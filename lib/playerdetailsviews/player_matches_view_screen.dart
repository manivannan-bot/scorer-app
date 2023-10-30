import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/Individual_player_completed_list.dart';
import '../widgets/individual_player_live_matches.dart';
import '../widgets/individual_player_upcoming_matches.dart';

class PlayerMatchesViewScreen extends StatefulWidget {
  const PlayerMatchesViewScreen({super.key});

  @override
  State<PlayerMatchesViewScreen> createState() => _PlayerMatchesViewScreenState();
}

class _PlayerMatchesViewScreenState extends State<PlayerMatchesViewScreen> {
  final List<Map<String, dynamic>> itemList = [
    {
      'type': 'live',


    },
    {
      'type': 'upcoming',

    },
    {
      'type': 'completed',

    },
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
        width: double.infinity,
        decoration: BoxDecoration(
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
                itemCount:itemList.length ,
                itemBuilder: (BuildContext, int index) {
                  final item = itemList[index];
                  final type = item['type'];
                  if (type == 'live') {
                    return IndividualPlayerLiveMatches();
                  } else if (type == 'upcoming') {
                    return IndividualPlayerUpcomingMatches();
                  }  else if (type == 'completed') {
                    return IndividualPlayerCompletedMatches();
                  }
                  return Container();
                }),
          ),
        )
    );
  }
}
