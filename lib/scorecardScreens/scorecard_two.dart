import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:sizer/sizer.dart';

import '../models/score_card_yet_to_bat.dart';
import '../provider/scoring_provider.dart';
import '../utils/images.dart';
import '../view/widgets/player_list_item.dart';


class ScoreCardTwo extends StatefulWidget {
  final String matchId;
  final String bowlTeamId;
  const ScoreCardTwo(this.matchId,this.bowlTeamId,{super.key});

  @override
  State<ScoreCardTwo> createState() => _ScoreCardTwoState();
}

class _ScoreCardTwoState extends State<ScoreCardTwo> {

  ScoreCardYetTobat? playersList;

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData(){
    ScoringProvider().playersYetToBat(widget.matchId, widget.bowlTeamId).then((value){
      setState(() {
        playersList=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return playersList == null
        ? const Center(child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ))
    : Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Center(child: Image.asset(Images.logoAll,width: 50.w,)),
                  SizedBox(height: 0.5.h,),
                  Text('Innings has not started yet.',style: fontMedium.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.pri,
                  ),),
                ],
              ),
              SizedBox(height: 1.h,),
              Text('Playing XI',style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(height: 2.h,),
              (playersList!.data!.isNotEmpty)?
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: playersList!.data!.length,
                  itemBuilder: (context, int index) {
                    final item = playersList!.data![index];
                    return Playing11List(item.playerName, item.battingStyle);
                  }):const Text('No players found'),
              const Divider(
                color: Color(0xffD3D3D3),
              ),
            ],
          ),
        ],
        ),
    );
  }
}

class Playing11List extends StatelessWidget {
  final String? name, style;
  const Playing11List(this.name, this.style, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 1.h),
          child: Row(
            children: [
              Image.network(
                Images.playersImage, width: 10.w,),
              SizedBox(width: 2.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Text(
                    name?.toUpperCase() ?? '-',
                    style: fontMedium.copyWith(
                        fontSize: 10.sp,
                        color: AppColor.textColor
                    ),),
                  style.toString() == "" ? const SizedBox() : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 3.5,
                        backgroundColor: AppColor.pri,
                      ),
                      SizedBox(width: 2.w,),
                      Text(
                        style?.toUpperCase() ?? '-',
                        style: fontMedium.copyWith(
                            fontSize: 8.sp,
                            color: AppColor.textMildColor
                        ),),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

