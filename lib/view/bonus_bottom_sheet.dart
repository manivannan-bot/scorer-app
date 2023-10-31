import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/score_update_request_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/sizes.dart';
import '../widgets/ok_btn.dart';

class BonusBottomSheet extends StatefulWidget {
  final int? ballType;
  final ScoringDetailResponseModel? scoringData;
  const BonusBottomSheet(this.ballType, this.scoringData, {super.key});

  @override
  State<BonusBottomSheet> createState() => _BonusBottomSheetState();
}

class _BonusBottomSheetState extends State<BonusBottomSheet> {

  int? isOffSideSelected=1 ;
  int? isWideSelected ;
  bool showError=false;
  List<Map<String, dynamic>> chipData=[
    {
      'label': "+ 1",
    },
    {
      'label': '+ 2',
    },
    {
      'label': '+ 3',
    },
    {
      'label': '+ 4',
    },
    {
      'label': '+ 5',
    },
    {
      'label': '+ 6',
    },
    {
      'label': '+ 7',
    },
  ];
  List<Map<String, dynamic>> displayedChipData = [];
  List<Map<String, dynamic>> chipData2 =[
    {
      'label': "- 1",
    },
    {
      'label': '- 2',
    },
    {
      'label': '- 3',
    },
    {
      'label': '- 4',
    },
    {
      'label': '- 5',
    },
    {
      'label': '- 6',
    },
    {
      'label': '- 7',
    },

  ];

  int ballType = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ballType = widget.ballType!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      // padding: EdgeInsets.symmetric(horizontal: 2.w),
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
                Text("Bonus/Penalty",style: fontMedium.copyWith(
                  fontSize: 17.sp,
                  color: AppColor.blackColour,
                ),),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          displayedChipData = chipData;
                          ballType=11;
                          isOffSideSelected=1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColor.blackColour),
                          color: isOffSideSelected==1?AppColor.blackColour:AppColor.lightColor,
                        ),
                        child: Icon(Icons.add,color: isOffSideSelected==1?AppColor.lightColor:AppColor.blackColour,size: 30,),
                      ),
                    ),
                    SizedBox(width: 2.w,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          displayedChipData = chipData2;
                          ballType=12;
                          isOffSideSelected=2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColor.blackColour),
                          color: isOffSideSelected==2?AppColor.blackColour:AppColor.lightColor,
                        ),
                        child: Icon(Icons.remove,color: isOffSideSelected==2?AppColor.lightColor:AppColor.blackColour,size:30,),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),
          SizedBox(height: 1.h,),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 1.h,),
          Padding(
            padding:  EdgeInsets.only(left: 5.w,right: 4.w),
            child: Wrap(
              spacing: 5.w, // Horizontal spacing between items
              runSpacing: 0.5.h, // Vertical spacing between lines
              alignment: WrapAlignment.center, // Alignment of items
              children:displayedChipData.map((data) {
                final index = displayedChipData.indexOf(data);
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      isWideSelected=index;
                    });
                  },
                  child: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.8.h),
                    label: Text(data['label'],style: fontSemiBold.copyWith(
                        fontSize: 12.sp,
                        color: AppColor.blackColour
                    ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        color: Color(0xffDADADA),
                      ),
                    ),
                    backgroundColor: isWideSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
                    // backgroundColor:AppColor.lightColor
                  ),
                );
              }).toList(),
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
                  Visibility(
                    visible: showError,
                    child: Text(
                      'Please Select One Option',
                      style: fontMedium.copyWith(color: AppColor.redColor),
                    ),
                  ),
                  GestureDetector(onTap:()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var overNumber= prefs.getInt('over_number');
                    var ballNumber= prefs.getInt('ball_number');
                    var strikerId=prefs.getInt('striker_id')??0;
                    var nonStrikerId=prefs.getInt('non_striker_id')??0;
                    var bowlerId=prefs.getInt('bowler_id')??0;
                    var oversBowled=prefs.getInt('overs_bowled')??0;
                    var keeperId=prefs.getInt('wicket_keeper_id')??0;
                    var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                    if(isWideSelected!=null){
                      ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                      scoreUpdateRequestModel.ballTypeId=widget.ballType;
                      scoreUpdateRequestModel.matchId=widget.scoringData!.data!.batting![0].matchId;
                      scoreUpdateRequestModel.scorerId=1;
                      scoreUpdateRequestModel.strikerId=strikerId;
                      scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                      scoreUpdateRequestModel.wicketKeeperId=keeperId;
                      scoreUpdateRequestModel.bowlerId=bowlerId;
                      scoreUpdateRequestModel.overNumber=overNumber;
                      scoreUpdateRequestModel.ballNumber=ballNumber;
                      scoreUpdateRequestModel.runsScored=(isWideSelected==null)?0:(isWideSelected??0)+1;
                      scoreUpdateRequestModel.extras=(isWideSelected==null)?0:(isWideSelected??0)+1;
                      scoreUpdateRequestModel.wicket=0;
                      scoreUpdateRequestModel.dismissalType=0;
                      scoreUpdateRequestModel.commentary=0;
                      scoreUpdateRequestModel.innings=1;
                      scoreUpdateRequestModel.battingTeamId=widget.scoringData!.data!.batting![0].teamId??0;
                      scoreUpdateRequestModel.bowlingTeamId=widget.scoringData!.data!.bowling!.teamId??0;
                      scoreUpdateRequestModel.overBowled=oversBowled;
                      scoreUpdateRequestModel.totalOverBowled=0;
                      scoreUpdateRequestModel.outByPlayer=0;
                      scoreUpdateRequestModel.outPlayer=0;
                      scoreUpdateRequestModel.totalWicket=0;
                      scoreUpdateRequestModel.fieldingPositionsId=0;
                      scoreUpdateRequestModel.endInnings=false;
                      scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                      ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('over_number', value.data!.overNumber??0);
                        await prefs.setInt('ball_number', value.data!.ballNumber??0);
                        await prefs.setInt('striker_id', value.data!.strikerId??0);
                        await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                        await prefs.setInt('bowler_change', value.data!.bowlerChange ?? 0);
                        await prefs.setInt('bowlerPosition',0);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                        });
                      });

                    }else{
                      setState(() {
                        showError = true;
                      });
                      if (showError) {
                        Timer(const Duration(seconds: 4), () {
                          setState(() {
                            showError = false;
                          });
                        });
                      }

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
