import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../models/save_batsman_request_model.dart';
import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/ok_btn.dart';
import '../widgets/out_button.dart';

class OutMethodDialog extends StatefulWidget {
  final String label;
  final int Id;
  final ScoringDetailResponseModel scoringData;
  const OutMethodDialog({required this.label,required this.Id,required this.scoringData,super.key});

  @override
  State<OutMethodDialog> createState() => _OutMethodDialogState();
}

class _OutMethodDialogState extends State<OutMethodDialog> {
  List<Players>? items = [];
  String selectedPlayerName = "";
  String? selectedTeamName ="";
  int? selectedIndex;

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
                        child: CancelBtn("cancel")),
                    SizedBox(width: 4.w,),
                    GestureDetector(onTap: ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      int overNumber= prefs.getInt('over_number')??0;
                      int ballNumber= prefs.getInt('ball_number')??0;
                      var strikerId=prefs.getInt('striker_id');
                      var nonStrikerId=prefs.getInt('non_striker_id');
                      var bowlerId=prefs.getInt('bowler_id')??0;
                      var keeperId=prefs.getInt('wicket_keeper_id')??0;


                      ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                      scoreUpdateRequestModel.ballTypeId=14;
                      scoreUpdateRequestModel.matchId=widget.scoringData.data!.batting![0].matchId;
                      scoreUpdateRequestModel.scorerId=1;
                      scoreUpdateRequestModel.strikerId=strikerId;
                      scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                      scoreUpdateRequestModel.wicketKeeperId=keeperId;
                      scoreUpdateRequestModel.bowlerId=bowlerId;
                      scoreUpdateRequestModel.overNumber=overNumber;
                      scoreUpdateRequestModel.ballNumber=ballNumber;
                      scoreUpdateRequestModel.runsScored=0;
                      scoreUpdateRequestModel.extras=0;
                      scoreUpdateRequestModel.wicket=0;
                      scoreUpdateRequestModel.dismissalType=widget.Id;
                      scoreUpdateRequestModel.commentary=0;
                      scoreUpdateRequestModel.innings=1;
                      scoreUpdateRequestModel.battingTeamId=widget.scoringData.data!.batting![0].teamId??0;
                      scoreUpdateRequestModel.bowlingTeamId=widget.scoringData.data!.bowling!.teamId??0;
                      scoreUpdateRequestModel.overBowled=0;
                      scoreUpdateRequestModel.totalOverBowled=0;
                      scoreUpdateRequestModel.outByPlayer=0;
                      scoreUpdateRequestModel.outPlayer=strikerId;
                      scoreUpdateRequestModel.totalWicket=0;
                      scoreUpdateRequestModel.fieldingPositionsId=0;
                      scoreUpdateRequestModel.endInnings=false;
                      ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('over_number', value.data!.overNumber??0);
                        await prefs.setInt('ball_number', value.data!.ballNumber??1);
                        await prefs.setInt('striker_id', value.data!.strikerId??0);
                        await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                      });

                      Navigator.pop(context);
                    },
                        child: OkBtn("ok")),
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
