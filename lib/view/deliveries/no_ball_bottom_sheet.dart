import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../Scoring screens/home_screen.dart';
import '../../models/score_update_request_model.dart';
import '../../provider/player_selection_provider.dart';
import '../../provider/score_update_provider.dart';
import '../../provider/scoring_provider.dart';
import '../../utils/colours.dart';
import '../../utils/sizes.dart';
import '../../widgets/ok_btn.dart';

class NoBallBottomSheet extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  final VoidCallback refresh;
  const NoBallBottomSheet(this.ballType, this.scoringData, this.refresh, {super.key});

  @override
  State<NoBallBottomSheet> createState() => _NoBallBottomSheetState();
}

class _NoBallBottomSheetState extends State<NoBallBottomSheet> {

  int? noBallTypeId = 0 ;
  int? isNBSelected ;
  bool loading = false;
  List<Map<String, dynamic>> chipData =[
    {
      'label': 'NB',
    },
    {
      'label': '1 + NB',
    },
    {
      'label': '2 + NB',
    },
    {
      'label': '3 + NB',
    },
    {
      'label': '4 + NB',
    },
    {
      'label': '5 + NB',
    },
    {
      'label': '6 + NB',
    },
    {
      'label': '7 + NB',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
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
                Text("No ball",style: fontMedium.copyWith(
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
          Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Wrap(
                spacing: 2.5.w, // Horizontal spacing between items
                runSpacing: 0.5.h, // Vertical spacing between lines
                alignment: WrapAlignment.center, // Alignment of items
                children:chipData.map((data) {
                  final index = chipData.indexOf(data);
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        isNBSelected=index;
                      });
                    },
                    child: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 0.5.h),
                      label: Text(data['label'],style: fontMedium.copyWith(
                          fontSize: 11.sp,
                          color: AppColor.blackColour
                      ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(
                          color: Color(0xffDADADA),
                        ),
                      ),
                      backgroundColor: isNBSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
                      // backgroundColor:AppColor.lightColor
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 1.5.h,),
          const DottedLine(
            dashColor: Color(0xffD2D2D2),
          ),
          SizedBox(height: 1.5.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text("Type of No ball?",style: fontMedium.copyWith(
              fontSize: 14.sp,
              color: AppColor.blackColour,
            ),),
          ),
          SizedBox(height: 2.h,),
          //offside leg side
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      noBallTypeId=0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xffDADADA),
                      ),
                      color: noBallTypeId==0 ? AppColor.primaryColor : const Color(0xffF8F9FA),
                    ),
                    child: Center(
                      child: Text("Crease",style: fontMedium.copyWith(
                        fontSize: 11.sp,
                        color: AppColor.blackColour,
                      ),),
                    ),
                  ),
                ),
                SizedBox(width: 4.w,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      noBallTypeId=1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                    decoration: BoxDecoration(
                        color: noBallTypeId==1?AppColor.primaryColor:const Color(0xffF8F9FA),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xffDADADA),
                        )
                    ),
                    child: Text("Waist",style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: AppColor.blackColour,
                    ),),
                  ),
                ),
                SizedBox(width: 4.w,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      noBallTypeId=2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                    decoration: BoxDecoration(
                        color: noBallTypeId==2?AppColor.primaryColor:const Color(0xffF8F9FA),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xffDADADA),
                        )
                    ),
                    child: Text("Shoulder",style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: AppColor.blackColour,
                    ),),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  loading
                  ? const Center(child: CircularProgressIndicator(),)
                  : GestureDetector(onTap:()async{
                    final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                    final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                    print("striker id ${player.selectedStrikerId}");
                    print("non striker id ${player.selectedNonStrikerId}");
                    print("passing over number to score update api ${score.overNumberInnings}");
                    print("passing ball number to score update api ${score.ballNumberInnings}");
                    score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                    if(isNBSelected!=null) {
                      ScoreUpdateRequestModel scoreUpdateRequestModel = ScoreUpdateRequestModel();
                      scoreUpdateRequestModel.ballTypeId = widget.ballType ?? 0;
                      scoreUpdateRequestModel.matchId =
                          widget.scoringData!.data!.batting![0].matchId;
                      scoreUpdateRequestModel.scorerId = 46;
                      scoreUpdateRequestModel.strikerId = int.parse(player.selectedStrikerId);
                      scoreUpdateRequestModel.nonStrikerId = int.parse(player.selectedNonStrikerId);
                      scoreUpdateRequestModel.wicketKeeperId = int.parse(player.selectedWicketKeeperId);
                      scoreUpdateRequestModel.bowlerId = int.parse(player.selectedBowlerId);
                      scoreUpdateRequestModel.overNumber = score.overNumberInnings;
                      scoreUpdateRequestModel.ballNumber = score.ballNumberInnings;
                      scoreUpdateRequestModel.runsScored =
                          1 + (isNBSelected ?? 0);
                      scoreUpdateRequestModel.extras = 1 + (isNBSelected ?? 0);
                      scoreUpdateRequestModel.extrasSlug = isNBSelected;
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
                      scoreUpdateRequestModel.noBallsType = noBallTypeId;
                      ScoringProvider()
                          .scoreUpdate(scoreUpdateRequestModel)
                          .then((value) async {
                        if(value.data == null){
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
                          Dialogs.snackBar("Match Ended", context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        } else if(value.data?.inningCompleted == true){
                          if(mounted){
                            setState(() {
                              loading = false;
                            });
                          }
                          debugPrint("end of innings");
                          debugPrint("navigating to home screen");
                          Dialogs.snackBar(value.data!.inningsMessage.toString(), context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        } else {
                          print("after score update - no ball");
                          score.setOverNumber(int.parse(value.data!.overNumber.toString()));
                          score.setBallNumber(int.parse(value.data!.ballNumber.toString()));
                          score.setBowlerChangeValue(int.parse(value.data!.bowlerChange.toString()));

                          player.setStrikerId(value.data!.strikerId.toString(), "");
                          player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
                          print("score update print end - wide");
                          widget.refresh();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pop(context);
                          });
                        }
                      });
                    }
                    else{
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
