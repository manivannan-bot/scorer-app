import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Scoring screens/home_screen.dart';
import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/player_selection_provider.dart';
import '../provider/score_update_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';
import '../widgets/snackbar.dart';

class ObstructTheField extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  final VoidCallback refresh;
  const ObstructTheField({required this.ballType,required this.scoringData, required this.refresh,super.key});


  @override
  State<ObstructTheField> createState() => _ObstructTheFieldState();
}

class _ObstructTheFieldState extends State<ObstructTheField> {
  int isSelected=-1;
  int? selectedValue;
  int? selectedValues;
  bool isChecked = false;
  int? isWideSelected ;
  int runsScored = 0;
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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w)+EdgeInsets.only(top: statusBarHeight + 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,size: 7.w,)),
                Text("Obstruct the field",style: fontMedium.copyWith(
                  fontSize: 17.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: ListView(
                children: [
                  SizedBox(height: 2.h,),
                  Container(
                    // padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.lightColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 0.h),
                          child: Text("Select the batsman*",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                        ),
                        SizedBox(height: 1.5.h,),
                        Padding(
                          padding:EdgeInsets.only(left: 6.w,right: 4.w,top: 0.h,bottom: 2.5.h),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSelected =0;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal:4.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isSelected ==0)?AppColor.primaryColor:AppColor.lightColor,

                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(Images.playerImg,width: 20.w,),
                                      SizedBox(height: 1.h,),
                                      Text("${widget.scoringData!.data!.batting![0].playerName}",style: fontMedium.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor.blackColour,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSelected =1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal:4.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isSelected ==1)?AppColor.primaryColor:AppColor.lightColor,

                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(Images.playerImg,width: 20.w,),
                                      SizedBox(height: 1.h,),
                                      Text("${widget.scoringData!.data!.batting![1].playerName}",style: fontMedium.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor.blackColour,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 6.w,right: 2.5.w,top: 2.h,bottom: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.lightColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Runs Scored?",
                                  style: fontMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  )),
                              TextSpan(
                                  text: " (Optional)",
                                  style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: const Color(0xff666666)
                                  )),
                            ])),
                        SizedBox(height: 1.5.h,),
                        Padding(
                          padding:  EdgeInsets.only(left: 0.w,right: 0.w),
                          child: Wrap(
                            spacing: 2.w, // Horizontal spacing between items
                            runSpacing: 1.h, // Vertical spacing between lines
                            alignment: WrapAlignment.center, // Alignment of items
                            children:chipData.map((data) {
                              final index = chipData.indexOf(data);
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isWideSelected=index;
                                    runsScored = index+1;
                                  });
                                  print(runsScored);
                                },
                                child: Chip(
                                  padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 0.8.h),
                                  label: Text(data['label'],style: fontRegular.copyWith(
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
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                     padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.lightColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Is that Byes or Leg byes?",
                                  style: fontMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  )),
                              TextSpan(
                                  text: " (Optional)",
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: const Color(0xff666666)
                                  )),
                            ])),
                        SizedBox(height: 1.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: selectedValue,
                              activeColor: const Color(0xffE8A514),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as int?;
                                });
                              },
                            ),
                            Text("Byes",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.blackColour,
                            ),),
                            Radio(
                              value: 2,
                              groupValue: selectedValue,
                              activeColor: const Color(0xffE8A514),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as int?;
                                });
                              },
                            ),
                            Text("Leg Byes",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.blackColour,
                            ),),
                          ],
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.lightColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Is that No ball or Wide?",
                                  style: fontMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  )),
                              TextSpan(
                                  text: " (Optional)",
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: const Color(0xff666666)
                                  )),
                            ])),
                        SizedBox(height: 1.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: selectedValues,
                              activeColor: const Color(0xffE8A514),
                              onChanged: (value) {
                                setState(() {
                                  selectedValues = value as int?;
                                });
                              },
                            ),
                            Text("No ball",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.blackColour,
                            ),),
                            Radio(
                              value: 2,
                              groupValue: selectedValues,
                              activeColor: const Color(0xffE8A514),
                              onChanged: (value) {
                                setState(() {
                                  selectedValues = value as int?;
                                });
                              },
                            ),
                            Text("Wide",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: AppColor.blackColour,
                            ),),
                          ],
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),

                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                color: AppColor.lightColor
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(onTap:(){
                    Navigator.pop(context);
                  },
                      child: const CancelBtn("Cancel")),
                  SizedBox(width: 4.w,),
                  GestureDetector(onTap:() async{
                    final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                    final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                    print("striker id ${player.selectedStrikerId}");
                    print("non striker id ${player.selectedNonStrikerId}");
                    print("passing over number to score update api ${score.overNumberInnings}");
                    print("passing ball number to score update api ${score.ballNumberInnings}");
                    print("passing overs bowled to score update api ${score.oversBowled}");
                    score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                    ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                    scoreUpdateRequestModel.ballTypeId=14;
                    scoreUpdateRequestModel.matchId=widget.scoringData!.data!.batting![0].matchId;
                    scoreUpdateRequestModel.scorerId=46;
                    scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId.toString());
                    scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId.toString());
                    scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId.toString());
                    scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId.toString());
                    scoreUpdateRequestModel.overNumber=score.overNumberInnings;
                    scoreUpdateRequestModel.ballNumber=score.ballNumberInnings;
                    scoreUpdateRequestModel.runsScored=0;
                    scoreUpdateRequestModel.extras=0;
                    scoreUpdateRequestModel.extrasSlug=0;
                    scoreUpdateRequestModel.wicket=0;
                    scoreUpdateRequestModel.dismissalType=widget.ballType;
                    scoreUpdateRequestModel.commentary=0;
                    scoreUpdateRequestModel.innings=score.innings;
                    scoreUpdateRequestModel.battingTeamId=widget.scoringData!.data!.batting![0].teamId??0;
                    scoreUpdateRequestModel.bowlingTeamId=widget.scoringData!.data!.bowling!.teamId??0;
                    scoreUpdateRequestModel.overBowled=score.oversBowled;
                    scoreUpdateRequestModel.totalOverBowled=0;
                    scoreUpdateRequestModel.outByPlayer=0;
                    scoreUpdateRequestModel.outPlayer=widget.scoringData!.data!.batting![isSelected].playerId;
                    scoreUpdateRequestModel.totalWicket=0;
                    scoreUpdateRequestModel.fieldingPositionsId=0;
                    scoreUpdateRequestModel.endInnings=false;
                    scoreUpdateRequestModel.bowlerPosition=score.bowlerPosition;
                    ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
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

                        print("after score update - obstruct field");
                        print(value.data?.overNumber);
                        print(value.data?.ballNumber);
                        print(value.data?.bowlerChange);
                        print("score update print end - obstruct field");

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
                  },
                      child: const OkBtn("Ok")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
