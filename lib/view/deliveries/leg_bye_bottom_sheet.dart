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
import '../batsman_list_bottom_sheet.dart';

class LegByeBottomSheet extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  final VoidCallback refresh;
  final String matchId, team1Id;
  const LegByeBottomSheet(this.ballType, this.scoringData, this.refresh, this.matchId, this.team1Id, {super.key});

  @override
  State<LegByeBottomSheet> createState() => _LegByeBottomSheetState();
}

class _LegByeBottomSheetState extends State<LegByeBottomSheet> {

  int? isOffSideSelected ;
  int isLBSelected = -1;
  bool loading = false;
  List<Map<String, dynamic>> chipData =[
    {
      'label': '1LB',
    },
    {
      'label': '2LB',
    },
    {
      'label': '3LB',
    },
    {
      'label': '4LB',
    },
    {
      'label': '5LB',
    },
    {
      'label': '6LB',
    },
    {
      'label': '7LB',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.h,
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
                Text("Leg Byes",style: fontMedium.copyWith(
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
            padding:  EdgeInsets.only(left: 5.w,right: 5.w),
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
                        isLBSelected=index;
                      });
                    },
                    child: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
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
                      backgroundColor: isLBSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
                      // backgroundColor:AppColor.lightColor
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  loading
                      ? const Center(child: CircularProgressIndicator(),)
                      : GestureDetector(
                      onTap:()async {
                        if(isLBSelected != -1){
                          final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                          final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                          print("striker id ${player.selectedStrikerId}");
                          print("non striker id ${player.selectedNonStrikerId}");
                          print("passing over number to score update api ${score.overNumberInnings}");
                          print("passing ball number to score update api ${score.ballNumberInnings}");
                          score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                          ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                          scoreUpdateRequestModel.ballTypeId=widget.ballType??0;
                          scoreUpdateRequestModel.matchId=widget.scoringData!.data!.batting![0].matchId;
                          scoreUpdateRequestModel.scorerId=46;
                          scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId);
                          scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId);
                          scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId);
                          scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId);
                          scoreUpdateRequestModel.overNumber=score.overNumberInnings;
                          scoreUpdateRequestModel.ballNumber=score.ballNumberInnings;
                          scoreUpdateRequestModel.runsScored=isLBSelected + 1;
                          scoreUpdateRequestModel.extras=isLBSelected + 1;
                          scoreUpdateRequestModel.extrasSlug=isLBSelected + 1;
                          scoreUpdateRequestModel.wicket=0;
                          scoreUpdateRequestModel.dismissalType=0;
                          scoreUpdateRequestModel.commentary=0;
                          scoreUpdateRequestModel.innings=score.innings;
                          scoreUpdateRequestModel.battingTeamId=widget.scoringData!.data!.batting![0].teamId??0;
                          scoreUpdateRequestModel.bowlingTeamId=widget.scoringData!.data!.bowling!.teamId??0;
                          scoreUpdateRequestModel.overBowled=score.oversBowled;
                          scoreUpdateRequestModel.totalOverBowled=0;
                          scoreUpdateRequestModel.outByPlayer=0;
                          scoreUpdateRequestModel.outPlayer=0;
                          scoreUpdateRequestModel.totalWicket=0;
                          scoreUpdateRequestModel.fieldingPositionsId=0;
                          scoreUpdateRequestModel.endInnings=false;
                          scoreUpdateRequestModel.bowlerPosition=score.bowlerPosition;
                          ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
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
                              print("after score update - lb");
                              score.setOverNumber(int.parse(value.data!.overNumber.toString()));
                              score.setBallNumber(int.parse(value.data!.ballNumber.toString()));
                              score.setBowlerChangeValue(int.parse(value.data!.bowlerChange.toString()));

                              player.setStrikerId(value.data!.strikerId.toString(), "");
                              player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
                              print("score update print end - wide");
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setInt('over_number', value.data!.overNumber??0);
                              await prefs.setInt('ball_number', value.data!.ballNumber??0);
                              await prefs.setInt('striker_id', value.data!.strikerId??0);
                              await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                              await prefs.setInt('bowler_change', value.data!.bowlerChange ?? 0);
                              await prefs.setInt('bowlerPosition', 0);
                              if(value.data!.strikerId==0 || value.data!.nonStrikerId==0){
                                String player=(value.data!.strikerId==0)?'striker_id':'non_striker_id';
                                changeBatsman(player);
                              }
                              widget.refresh();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pop(context);
                              });
                            }
                          });
                        } else {
                          Dialogs.snackBar("Select one option", context, isError: true);
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

  void changeBatsman(String player) async{
    _displaySelectBatsmanBottomSheet (player);
  }

  Future<void> _displaySelectBatsmanBottomSheet (String player) async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(
          builder: (context, setState) {
            return BatsmanListBottomSheet(widget.matchId, widget.team1Id, player, widget.refresh, (){});
          },
        )
    );
  }
}
