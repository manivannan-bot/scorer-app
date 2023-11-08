import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../models/save_batsman_request_model.dart';
import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/player_selection_provider.dart';
import '../provider/score_update_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/ok_btn.dart';
import '../widgets/out_button.dart';

class OutMethodDialog extends StatefulWidget {
  final String label;
  final int id;
  final ScoringDetailResponseModel scoringData;
  final VoidCallback refresh;
  const OutMethodDialog({required this.label,required this.id,required this.scoringData, required this.refresh,super.key});

  @override
  State<OutMethodDialog> createState() => _OutMethodDialogState();
}

class _OutMethodDialogState extends State<OutMethodDialog> {


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 5.w
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
         height: 43.h,
         width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //   )
          // ],
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Column(
            children: [
              ClipOval(child: Image.asset(Images.outProfileimage,width: 20.w,)),
              SizedBox(height: 1.h,),
              Text("Prasanth",style: fontMedium.copyWith(
                  fontSize: 15.sp,
                  color: AppColor.blackColour
              ),),
              SizedBox(height: 1.h,),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(Images.outBg,fit: BoxFit.cover, width: double.maxFinite, height: 12.h,)),
                  Positioned(
                    top: 2.h,
                    child: Text("Dismissal method",style: fontMedium.copyWith(
                        fontSize: 13.sp,
                        color: AppColor.blackColour
                    ),),
                  ),
                  Positioned(
                      bottom: 2.h,
                      child:  Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0.6.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.primaryColor
                        ),
                        child: Text(widget.label,style: fontMedium.copyWith(
                          fontSize: 13.sp,
                          color: AppColor.blackColour,
                        ),),
                      ))
                ],
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: const CancelBtn("cancel")),
                    SizedBox(width: 4.w,),
                    GestureDetector(onTap: ()async{
                      final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                      final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                      print("striker id ${player.selectedStrikerId}");
                      print("non striker id ${player.selectedNonStrikerId}");
                      print("passing over number to score update api ${score.overNumberInnings}");
                      print("passing ball number to score update api ${score.ballNumberInnings}");
                      print("passing overs bowled to score update api ${score.oversBowled}");
                      score.trackOvers(score.overNumberInnings, score.ballNumberInnings);
                      SharedPreferences prefs = await SharedPreferences.getInstance();
//                       var overNumber= prefs.getInt('over_number');
//                       var ballNumber= prefs.getInt('ball_number');
//                       var strikerId=prefs.getInt('striker_id');
//                       var nonStrikerId=prefs.getInt('non_striker_id');
//                       var bowlerId=prefs.getInt('bowler_id')??0;
// var oversBowled=prefs.getInt('overs_bowled')??0;
//                       var keeperId=prefs.getInt('wicket_keeper_id')??0;
                      var bowlerPosition=prefs.getInt('bowlerPosition')??0;


                      ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                      scoreUpdateRequestModel.ballTypeId=14;
                      scoreUpdateRequestModel.matchId=widget.scoringData.data!.batting![0].matchId;
                      scoreUpdateRequestModel.scorerId=46;
                      scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId.toString());
                      scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId.toString());
                      scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId.toString());
                      scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId.toString());
                      scoreUpdateRequestModel.overNumber=score.overNumberInnings;
                      scoreUpdateRequestModel.ballNumber=score.ballNumberInnings;
                      scoreUpdateRequestModel.runsScored=0;
                      scoreUpdateRequestModel.extras=0;
                      scoreUpdateRequestModel.wicket=0;
                      scoreUpdateRequestModel.extrasSlug=0;
                      scoreUpdateRequestModel.dismissalType=widget.id;
                      scoreUpdateRequestModel.commentary=0;
                      scoreUpdateRequestModel.innings=1;
                      scoreUpdateRequestModel.battingTeamId=widget.scoringData.data!.batting![0].teamId??0;
                      scoreUpdateRequestModel.bowlingTeamId=widget.scoringData.data!.bowling!.teamId??0;
                      scoreUpdateRequestModel.overBowled=score.oversBowled;
                      scoreUpdateRequestModel.totalOverBowled=0;
                      scoreUpdateRequestModel.outByPlayer=int.parse(player.selectedBowlerId.toString());
                      scoreUpdateRequestModel.outPlayer=int.parse(player.selectedStrikerId.toString());
                      scoreUpdateRequestModel.totalWicket=0;
                      scoreUpdateRequestModel.fieldingPositionsId=0;
                      scoreUpdateRequestModel.endInnings=false;
                      scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                      ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                        print("striker and non striker id - ${value.data?.strikerId.toString()} ${value.data?.nonStrikerId.toString()}");

                        print("after wicket update - ${widget.label}");
                        print(value.data?.overNumber);
                        print(value.data?.ballNumber);
                        print(value.data?.bowlerChange);
                        print("score wicket print end - ${widget.label}");

                        print("setting over number ${value.data?.overNumber} and ball number ${value.data?.ballNumber} and bowler change ${value.data?.bowlerChange} to provider after wicket update");
                        score.setOverNumber(value.data?.overNumber??0);
                        score.setBallNumber(value.data?.ballNumber??0);
                        score.setBowlerChangeValue(value.data?.bowlerChange??0);
                        player.setStrikerId(value.data!.strikerId.toString(), "");
                        player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        // await prefs.setInt('over_number', value.data!.overNumber??0);
                        // await prefs.setInt('ball_number', value.data!.ballNumber??0);
                        // await prefs.setInt('striker_id', value.data!.strikerId??0);
                        // await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                        // await prefs.setInt('bowler_change', value.data!.bowlerChange??0);
                        await prefs.setInt('bowlerPosition',0);
                        widget.refresh();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          });
                      });
                    },
                        child: const OkBtn("Ok")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
