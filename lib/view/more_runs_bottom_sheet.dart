import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Scoring screens/home_screen.dart';
import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/player_selection_provider.dart';
import '../provider/score_update_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/sizes.dart';
import '../widgets/ok_btn.dart';

class MoreRunsBottomSheet extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  final VoidCallback refresh;
  const MoreRunsBottomSheet(this.ballType, this.scoringData, this.refresh, {super.key});

  @override
  State<MoreRunsBottomSheet> createState() => _MoreRunsBottomSheetState();
}

class _MoreRunsBottomSheetState extends State<MoreRunsBottomSheet> {

  int? isOffSideSelected ;
  int? isRunsSelected ;
  bool showError =false;

  List<Map<String, dynamic>> chipData =[
    {
      'label': "1",
    },
    {
      'label': '2',
    },
    {
      'label': '3',
    },
    {
      'label': '4',
    },
    {
      'label': '5',
    },
    {
      'label': '6',
    },
    {
      'label': '7',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,size: 7.w,)),
                Text("More Runs",style: fontMedium.copyWith(
                  fontSize: 17.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          SizedBox(height: 1.h,),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 1.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Center(
              child: Wrap(
                spacing: 5.w, // Horizontal spacing between items
                runSpacing: 1.h, // Vertical spacing between lines
                alignment: WrapAlignment.center, // Alignment of items
                children:chipData.map((data) {
                  final index = chipData.indexOf(data);
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        isRunsSelected=index;
                      });
                    },
                    child: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 1.6.w,vertical: 0.8.h),
                      label: Text(data['label'],style: fontSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour
                      ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                          color: Color(0xffDADADA),
                        ),
                      ),
                      backgroundColor: isRunsSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
                      // backgroundColor:AppColor.lightColor
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 1.5.h,),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: showError,
                    child: Text(
                      'Please Select One Option',
                      style: fontMedium.copyWith(color: AppColor.redColor),
                    ),
                  ),
                  GestureDetector(onTap:()async{
                    final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                    final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                    print("striker id ${player.selectedStrikerId}");
                    print("non striker id ${player.selectedNonStrikerId}");
                    print("passing over number to score update api ${score.overNumberInnings}");
                    print("passing ball number to score update api ${score.ballNumberInnings}");
                    print("passing overs bowled to score update api ${score.oversBowled}");
                    score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                    if(isRunsSelected !=null) {
                      ScoreUpdateRequestModel scoreUpdateRequestModel = ScoreUpdateRequestModel();
                      scoreUpdateRequestModel.ballTypeId = widget.ballType;
                      scoreUpdateRequestModel.matchId =
                          widget.scoringData!.data!.batting![0].matchId;
                      scoreUpdateRequestModel.scorerId = 46;
                      scoreUpdateRequestModel.strikerId = int.parse(player.selectedStrikerId.toString());
                      scoreUpdateRequestModel.nonStrikerId = int.parse(player.selectedNonStrikerId.toString());
                      scoreUpdateRequestModel.wicketKeeperId = int.parse(player.selectedWicketKeeperId.toString());
                      scoreUpdateRequestModel.bowlerId = int.parse(player.selectedBowlerId.toString());
                      scoreUpdateRequestModel.overNumber = score.overNumberInnings;
                      scoreUpdateRequestModel.ballNumber = score.ballNumberInnings;

                      scoreUpdateRequestModel.runsScored =
                      (isRunsSelected == null) ? 0 : isRunsSelected ??
                          0 + 1;
                      scoreUpdateRequestModel.extras =
                      (isRunsSelected == null) ? 0 : isRunsSelected ??
                          0 + 1;
                      scoreUpdateRequestModel.extrasSlug=0;
                      scoreUpdateRequestModel.wicket = 0;
                      scoreUpdateRequestModel.dismissalType = 0;
                      scoreUpdateRequestModel.commentary = 0;
                      scoreUpdateRequestModel.innings = score.innings;
                      scoreUpdateRequestModel.battingTeamId =
                          widget.scoringData!.data!.batting![0].teamId ?? 0;
                      scoreUpdateRequestModel.bowlingTeamId =
                          widget.scoringData!.data!.bowling!.teamId ?? 0;
                      scoreUpdateRequestModel.overBowled=score.oversBowled ;
                      scoreUpdateRequestModel.totalOverBowled = 0;
                      scoreUpdateRequestModel.outByPlayer = 0;
                      scoreUpdateRequestModel.outPlayer = 0;
                      scoreUpdateRequestModel.totalWicket = 0;
                      scoreUpdateRequestModel.fieldingPositionsId = 0;
                      scoreUpdateRequestModel.endInnings = false;
                      scoreUpdateRequestModel.bowlerPosition=score.bowlerPosition;
                      ScoringProvider()
                          .scoreUpdate(scoreUpdateRequestModel)
                          .then((value) async {
                        if(value.data?.innings == 3){
                          Dialogs.snackBar("Match Ended", context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        } else if(value.data?.inningCompleted == true){
                          print("end of innings");
                          print("navigating to home screen");
                          Dialogs.snackBar(value.data!.inningsMessage.toString(), context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        } else {
                          print("striker and non striker id - ${value.data?.strikerId.toString()} ${value.data?.nonStrikerId.toString()}");

                          print("after score update - more runs");
                          print(value.data?.overNumber);
                          print(value.data?.ballNumber);
                          print(value.data?.bowlerChange);
                          print("score update print end - more runs");

                          print("setting over number ${value.data?.overNumber} and ball number ${value.data?.ballNumber} and bowler change ${value.data?.bowlerChange} to provider after score update");
                          score.setOverNumber(value.data?.overNumber??0);
                          score.setBallNumber(value.data?.ballNumber??0);
                          score.setBowlerChangeValue(value.data?.bowlerChange??0);
                          player.setStrikerId(value.data!.strikerId.toString(), "");
                          player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('bowlerPosition', 0);
                          widget.refresh();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);
                          });
                        }
                      });
                    }else{
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Dialogs.snackBar("Select one option", context, isError: true);
                      });
                    }

                  },child: const OkBtn("Save")),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
