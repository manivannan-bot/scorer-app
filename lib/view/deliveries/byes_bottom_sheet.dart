import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../models/score_update_request_model.dart';
import '../../provider/player_selection_provider.dart';
import '../../provider/score_update_provider.dart';
import '../../provider/scoring_provider.dart';
import '../../utils/colours.dart';
import '../../utils/sizes.dart';
import '../../widgets/ok_btn.dart';
import '../batsman_list_bottom_sheet.dart';

class ByesBottomSheet extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  final String matchId, team1Id;
  final VoidCallback refresh;
  const ByesBottomSheet(this.ballType, this.scoringData, this.refresh, this.matchId, this.team1Id, {super.key});

  @override
  State<ByesBottomSheet> createState() => _ByesBottomSheetState();
}

class _ByesBottomSheetState extends State<ByesBottomSheet> {

  int? isOffSideSelected ;
  int isByesSelected = -1;
  List<Map<String, dynamic>> chipData =[
    {
      'label': '1 B',
    },
    {
      'label': '2 B',
    },
    {
      'label': '3 B',
    },
    {
      'label': '4 B',
    },
    {
      'label': '5 B',
    },
    {
      'label': '6 B',
    },
    {
      'label': '7 B',
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
                Text("Byes",style: fontMedium.copyWith(
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
                spacing: 4.w, // Horizontal spacing between items
                runSpacing: 1.h, // Vertical spacing between lines
                alignment: WrapAlignment.center, // Alignment of items
                children:chipData.map((data) {
                  final index = chipData.indexOf(data);
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        isByesSelected = index;
                      });
                      print(isByesSelected);
                    },
                    child: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 0.5.h),
                      label: Text(data['label'],
                        style: fontSemiBold.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour
                      ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(
                          color: Color(0xffDADADA),
                        ),
                      ),
                      backgroundColor: isByesSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap:()async{
                        if(isByesSelected != -1){
                          final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                          final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                          print("striker id ${player.selectedStrikerId}");
                          print("non striker id ${player.selectedNonStrikerId}");
                          print("passing over number to score update api ${score.overNumberInnings}");
                          print("passing ball number to score update api ${score.ballNumberInnings}");
                          score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          var overNumber= prefs.getInt('over_number');
                          var ballNumber= prefs.getInt('ball_number');
                          var strikerId=prefs.getInt('striker_id')??0;
                          var nonStrikerId=prefs.getInt('non_striker_id')??0;
                          var bowlerId=prefs.getInt('bowler_id')??0;
                          var oversBowled=prefs.getInt('overs_bowled')??0;
                          var keeperId=prefs.getInt('wicket_keeper_id')??0;
                          var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                          ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                          scoreUpdateRequestModel.ballTypeId=widget.ballType;
                          scoreUpdateRequestModel.matchId=widget.scoringData!.data!.batting![0].matchId;
                          scoreUpdateRequestModel.scorerId=46;
                          scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId);
                          scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId);
                          scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId);
                          scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId);
                          scoreUpdateRequestModel.overNumber=score.overNumberInnings;
                          scoreUpdateRequestModel.ballNumber=score.ballNumberInnings;

                          scoreUpdateRequestModel.runsScored=isByesSelected + 1;
                          scoreUpdateRequestModel.extras=isByesSelected + 1;
                          scoreUpdateRequestModel.extrasSlug=isByesSelected + 1;
                          scoreUpdateRequestModel.wicket=0;
                          scoreUpdateRequestModel.dismissalType=0;
                          scoreUpdateRequestModel.commentary=0;
                          scoreUpdateRequestModel.innings=1;
                          scoreUpdateRequestModel.battingTeamId=widget.scoringData?.data!.batting![0].teamId??0;
                          scoreUpdateRequestModel.bowlingTeamId=widget.scoringData?.data!.bowling!.teamId??0;
                          scoreUpdateRequestModel.overBowled=oversBowled;
                          scoreUpdateRequestModel.totalOverBowled=0;
                          scoreUpdateRequestModel.outByPlayer=0;
                          scoreUpdateRequestModel.outPlayer=0;
                          scoreUpdateRequestModel.totalWicket=0;
                          scoreUpdateRequestModel.fieldingPositionsId=0;
                          scoreUpdateRequestModel.endInnings=false;
                          scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                          ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value)async{
                            print("after score update - b");
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
                              //uncomment when working
                              changeBatsman(player);
                            }
                            widget.refresh();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                            });
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
            return BatsmanListBottomSheet(widget.matchId, widget.team1Id, player);
          },
        )
    );
  }

}
