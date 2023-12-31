
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:scorer/view/set_ball_pitch_area.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/score_update_request_model.dart';
import '../models/score_update_response_model.dart';
import '../provider/player_selection_provider.dart';
import '../provider/score_update_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/sizes.dart';
import '../widgets/snackbar.dart';
import '../widgets/undo_button.dart';
import 'cricket_wagon_wheel.dart';
import 'end_innings_confirmation_bottom_sheet.dart';
import 'end_match_confirmation_bottom_sheet.dart';

class ScoreBottomSheet extends StatefulWidget {
  final int run;
  final ScoringDetailResponseModel scoringData;
  final void Function(ScoreUpdateResponseModel) onSave;
  final VoidCallback refresh;
  const ScoreBottomSheet(this.run, this.scoringData, this.refresh, {super.key,required this.onSave});

  @override
  State<ScoreBottomSheet> createState() => _ScoreBottomSheetState();
}

class _ScoreBottomSheetState extends State<ScoreBottomSheet> {
  ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();


  List<Color> rowColors = [
    const Color(0xff797873),
    const Color(0xffF7B199),
    const Color(0xffF48F6D),
    const Color(0xffBC8BA0),
    const Color(0xffCAB59A),
  ];

  int selectedRow = -1;
  int selectedColumn = -1;
  int fieldPositionId=0;
   int? isFourOrSix;
   int? isBowlingArea=1;
   bool _isSwitch=false ;
   bool loading = false;
   bool rightHandBatsman = false;
   int? pitchAreaId;


  List<String> partNumbers = List.generate(8, (index) => 'Part ${index + 1}');
  String tappedPart = '';

  void onTap(int partNumberIndex) {
    setState(() {
      tappedPart = partNumbers[partNumberIndex];
    });
    debugPrint('Tapped on $tappedPart');
  }

  void callbackFunction(int value) {
    setState(() {
      fieldPositionId=value;
    });
    debugPrint("Received value from ThreeCircles: $value");
  }

  void callbackFunction1(int value) {
    setState(() {
      pitchAreaId=value;
    });
    debugPrint("Received value from pitch area: $value");
  }

  @override
  void initState() {
    super.initState();
    getSwitch();
  }

  void getSwitch()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
   isFourOrSix= pref.getInt('fourOrSix');
    // isBowlingArea=pref.getInt('bowlingArea');
   if(isFourOrSix==1) {
     setState(() {
       _isSwitch = true;
     });
   }else{
     setState(() {
       _isSwitch = false;
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.scoringData.data!.batting!.isEmpty){
      return const Center(child: Text('Please Select Batsman'));
    }
    if(widget.scoringData.data!.bowling ==null){
      return const Center(child: Text('Please Select Bowler'));
    }
    return Container(
      height: 90.h,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30))),
      child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 7.w,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff000000),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Shot and Pitching Area",
                    style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.textColor,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                ],
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Wagon Wheel',
                          style: fontMedium.copyWith(
                              fontSize: 14.sp
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '4s & 6s',
                          style: fontRegular.copyWith(
                            fontSize: 12.sp,
                              color: AppColor.iconColour),
                        ),
                        Switch(value: _isSwitch, onChanged: (bool value) async{
                          SharedPreferences pref=await SharedPreferences.getInstance();
                          isFourOrSix=pref.getInt('fourOrSix');
                          if(isFourOrSix==1){
                            await pref.setInt('fourOrSix',0);
                          }else{
                            await pref.setInt('fourOrSix',1);
                          }
                          setState(() {
                            _isSwitch=value;
                          });

                        }),
                      ],
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w), // Spacing inside the card
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F9FA),
                        borderRadius:
                        BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Center(
                                      child: Text('Batsman Name',
                                          style: fontRegular.copyWith(
                                              fontSize: 12.sp))),
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                      child: Text(
                                        'Runs',
                                        style: fontRegular.copyWith(
                                            fontSize: 12.sp),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.scoringData.data!.batting!.length,
                            itemBuilder: (context, index) {
                              final batsman = widget.scoringData.data!.batting![index];

                              if (batsman.striker == 1) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Center(
                                          child: Text('${batsman.playerName ?? '-'}',
                                            style: fontRegular.copyWith(
                                                fontSize: 11.sp,
                                            color: AppColor.textMildColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Center(
                                          child: Text('${batsman.runsScored ?? '0'}',
                                            style: fontRegular.copyWith(fontSize: 11.sp,
                                                color: AppColor.textMildColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                // If the batsman's striker value is not 1, return an empty container.
                                return const SizedBox();
                              }
                            },
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Column(
                          //       children: [
                          //         Container(
                          //           child: Center(
                          //               child: Text('${widget.scoringData.data!.batting![0].playerName??'-'}',
                          //                   style: fontMedium.copyWith(fontSize: 18))),
                          //         ),
                          //       ],
                          //     ),
                          //     Column(
                          //       children: [
                          //         Container(
                          //           child: Center(
                          //               child: Text('${widget.scoringData.data!.batting![0].runsScored??'0'}',
                          //                   style: fontMedium.copyWith(fontSize: 18))),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Skip match',
                          style: fontMedium.copyWith(color: AppColor.brown),
                        ),
                        const Spacer(),
                        Text(
                          'Skip ball',
                          style: fontMedium.copyWith(color: AppColor.brown),
                        )
                      ],
                    ),
                    ((widget.run==4 || widget.run==6)|| isFourOrSix!=0 )?Center(
                      child: SizedBox(
                        height: 50.h,
                        width:double.maxFinite,
                        child:ThreeCircles(onOkButtonPressed:callbackFunction,),
                      ),
                    ):const SizedBox(),
                    const UndoButton(),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Ball pitching area",
                      style: fontMedium.copyWith(
                        fontSize: 13.sp,
                        color: AppColor.textColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w), // Spacing inside the card
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F9FA), // Grey background color
                        borderRadius:
                        BorderRadius.circular(10.0), // Rounded corners
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Center(
                                      child: Text('Bowler Name',
                                          style: fontRegular.copyWith(fontSize: 12.sp,
                                          color: AppColor.textColor))),
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                      child: Text(
                                        'Info',
                                        style: fontRegular.copyWith(fontSize: 12.sp,
                                            color: AppColor.textColor),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Center(
                                      child: Text('${widget.scoringData.data!.bowling!.playerName??'-'}',
                                          style: fontRegular.copyWith(fontSize: 11.sp,
                                          color: AppColor.textMildColor))),
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                      child: Text('${widget.scoringData.data!.bowling!.oversBowled}-${widget.scoringData.data!.bowling!.wickets}-${widget.scoringData.data!.bowling!.runsConceded}-${widget.scoringData.data!.bowling!.economy}',
                                          style: fontRegular.copyWith(fontSize: 11.sp,
                                              color: AppColor.textMildColor))),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Skip match',
                          style: fontMedium.copyWith(color: AppColor.brown),
                        ),
                        const Spacer(),
                        Text(
                          'Skip ball',
                          style: fontMedium.copyWith(color: AppColor.brown),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    //setting ball pitching area
                    (isBowlingArea==1)?
                        SetBallPitchArea(rightHandBatsman, callbackFunction1)
                        :const SizedBox(),
                    SizedBox(height: 3.h),
                    const UndoButton(),
                    SizedBox(height: 2.h,),
                  ],
                ),
              ),
            ),
            Theme(
                data: ThemeData(
                  dividerTheme: const DividerThemeData(
                    space: 0,
                    thickness: 0.5,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
                child: const Divider()),
            SizedBox(height: 1.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const CancelBtn("Cancel")),
                SizedBox(width: 4.w,),
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: loading
                      ? const SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () async{
                      if(mounted){
                        setState(() {
                          loading = true;
                        });
                      }
                      final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                      final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                      debugPrint("striker id ${player.selectedStrikerId}");
                      debugPrint("non striker id ${player.selectedNonStrikerId}");
                      debugPrint("passing over number to score update api ${score.overNumberInnings}");
                      debugPrint("passing ball number to score update api ${score.ballNumberInnings}");
                      debugPrint("passing overs bowled to score update api ${score.oversBowled}");
                      score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                      scoreUpdateRequestModel.ballTypeId=widget.run;
                      scoreUpdateRequestModel.matchId=widget.scoringData.data!.batting![0].matchId;
                      scoreUpdateRequestModel.scorerId=46;
                      scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId.toString());
                      scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId.toString());
                      scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId.toString());
                      scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId.toString());
                      scoreUpdateRequestModel.overNumber=score.overNumberInnings;
                      scoreUpdateRequestModel.ballNumber=score.ballNumberInnings;
                      scoreUpdateRequestModel.runsScored=widget.run;
                      scoreUpdateRequestModel.extras=0;
                      scoreUpdateRequestModel.extrasSlug=0;
                      scoreUpdateRequestModel.wicket=0;
                      scoreUpdateRequestModel.dismissalType=0;
                      scoreUpdateRequestModel.commentary=0;
                      scoreUpdateRequestModel.innings=score.innings;
                      scoreUpdateRequestModel.battingTeamId=widget.scoringData.data!.batting![0].teamId??0;
                      scoreUpdateRequestModel.bowlingTeamId=widget.scoringData.data!.bowling!.teamId??0;
                      scoreUpdateRequestModel.overBowled=score.oversBowled;
                      scoreUpdateRequestModel.totalOverBowled=0;
                      scoreUpdateRequestModel.outByPlayer=0;
                      scoreUpdateRequestModel.outPlayer=0;
                      scoreUpdateRequestModel.totalWicket=0;
                      scoreUpdateRequestModel.fieldingPositionsId = fieldPositionId;
                      scoreUpdateRequestModel.endInnings=false;
                      scoreUpdateRequestModel.bowlerPosition= score.bowlerPosition;
                      ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                        if(value.data == null){
                            Dialogs.snackBar("Something went wrong. Please try again.", context, isError: true);
                          if(mounted){
                            setState(() {
                              loading = false;
                            });
                          }
                        }
                        else if(value.data?.innings == 3){
                          if(mounted){
                            setState(() {
                              loading = false;
                            });
                          }
                          widget.refresh();
                          showEndMatchConfirmationBottomSheet();
                        } else if(value.data?.inningCompleted == true){
                          if(mounted){
                            setState(() {
                              loading = false;
                            });
                          }
                          widget.refresh();
                          showEndInningsConfirmationBottomSheet();
                          debugPrint("end of innings");
                          debugPrint("navigating to home screen");
                        } else {
                          widget.onSave(value);
                          debugPrint("striker and non striker id - ${value.data?.strikerId.toString()} ${value.data?.nonStrikerId.toString()}");

                          debugPrint("after score update - ${widget.run}");
                          debugPrint(value.data?.overNumber.toString());
                          debugPrint(value.data?.ballNumber.toString());
                          debugPrint(value.data?.bowlerChange.toString());
                          debugPrint("score update print end - ${widget.run}");

                          debugPrint("setting over number ${value.data?.overNumber} and ball number ${value.data?.ballNumber} and bowler change ${value.data?.bowlerChange} to provider after score update");
                          score.setOverNumber(value.data?.overNumber??0);
                          score.setBallNumber(value.data?.ballNumber??0);
                          score.setBowlerChangeValue(value.data?.bowlerChange??0);
                          player.setStrikerId(value.data!.strikerId.toString(), "");
                          player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('bowlerPosition', 0);
                          widget.refresh();
                          if(mounted){
                            setState(() {
                              loading = false;
                            });
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      child: Text(
                        'Save',
                        style: fontMedium.copyWith(
                            color: AppColor.lightColor,
                            fontSize: 12.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h,),
          ]),
    );
  }

  showEndMatchConfirmationBottomSheet(){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context)=> const EndMatchConfirmationBottomSheet()
    );
  }

  showEndInningsConfirmationBottomSheet(){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context)=> const EndInningsConfirmationBottomSheet()
    );
  }
}

