import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';

class ObstructTheField extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  const ObstructTheField({required this.ballType,required this.scoringData,super.key});


  @override
  State<ObstructTheField> createState() => _ObstructTheFieldState();
}

class _ObstructTheFieldState extends State<ObstructTheField> {
  int isSelected=-1;
  int? selectedValue;
  int? selectedValues;
  bool isChecked = false;
  int? isWideSelected ;
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FA),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w)+EdgeInsets.only(top: 1.h),
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
                              fontSize: 14.sp,
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
                                      border: Border.all(color: Color(0xffDFDFDF)),
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
                                      border: Border.all(color: Color(0xffDFDFDF)),
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
                                    text: ("Runs Scored?"),
                                    style: fontMedium.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColor.blackColour,
                                    )),
                                TextSpan(
                                    text: "(Optional)",
                                    style: fontRegular.copyWith(
                                        fontSize: 12.sp,
                                        color: Color(0xff666666)
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
                                    });
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
                                    backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
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
                                    text: ("Is that Byes or Leg byes?"),
                                    style: fontMedium.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColor.blackColour,
                                    )),
                                TextSpan(
                                    text: "(Optional)",
                                    style: fontRegular.copyWith(
                                        fontSize: 12.sp,
                                        color: Color(0xff666666)
                                    )),
                              ])),
                          SizedBox(height: 1.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: selectedValue,
                                activeColor: Color(0xffE8A514),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as int?;
                                  });
                                },
                              ),
                              Text("Byes",style: fontMedium.copyWith(
                                fontSize: 16.sp,
                                color: AppColor.blackColour,
                              ),),
                              Radio(
                                value: 2,
                                groupValue: selectedValue,
                                activeColor: Color(0xffE8A514),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as int?;
                                  });
                                },
                              ),
                              Text("Leg Byes",style: fontMedium.copyWith(
                                fontSize: 16.sp,
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
                                    text: ("Is that No ball or Wide?"),
                                    style: fontMedium.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColor.blackColour,
                                    )),
                                TextSpan(
                                    text: "(Optional)",
                                    style: fontRegular.copyWith(
                                        fontSize: 12.sp,
                                        color: Color(0xff666666)
                                    )),
                              ])),
                          SizedBox(height: 1.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: selectedValues,
                                activeColor: Color(0xffE8A514),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValues = value as int?;
                                  });
                                },
                              ),
                              Text("No ball",style: fontMedium.copyWith(
                                fontSize: 16.sp,
                                color: AppColor.blackColour,
                              ),),
                              Radio(
                                value: 2,
                                groupValue: selectedValues,
                                activeColor: Color(0xffE8A514),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValues = value as int?;
                                  });
                                },
                              ),
                              Text("Wide",style: fontMedium.copyWith(
                                fontSize: 16.sp,
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
              decoration: BoxDecoration(
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
                        child: CancelBtn("Cancel")),
                    SizedBox(width: 4.w,),
                    GestureDetector(onTap:() async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      int overNumber= prefs.getInt('over_number')??0;
                      int ballNumber= prefs.getInt('ball_number')??0;
                      var strikerId=prefs.getInt('striker_id')??0;
                      var nonStrikerId=prefs.getInt('non_striker_id')??0;
                      var bowlerId=prefs.getInt('bowler_id')??0;
                      var keeperId=prefs.getInt('wicket_keeper_id')??0;

                      ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                      scoreUpdateRequestModel.ballTypeId=14;
                      scoreUpdateRequestModel.matchId=widget.scoringData!.data!.batting![0].matchId;
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
                      scoreUpdateRequestModel.dismissalType=widget.ballType;
                      scoreUpdateRequestModel.commentary=0;
                      scoreUpdateRequestModel.innings=1;
                      scoreUpdateRequestModel.battingTeamId=widget.scoringData!.data!.batting![0].teamId??0;
                      scoreUpdateRequestModel.bowlingTeamId=widget.scoringData!.data!.bowling!.teamId??0;
                      scoreUpdateRequestModel.overBowled=overNumber;
                      scoreUpdateRequestModel.totalOverBowled=0;
                      scoreUpdateRequestModel.outByPlayer=0;
                      scoreUpdateRequestModel.outPlayer=widget.scoringData!.data!.batting![isSelected].playerId;
                      scoreUpdateRequestModel.totalWicket=0;
                      scoreUpdateRequestModel.fieldingPositionsId=0;
                      scoreUpdateRequestModel.endInnings=false;
                      scoreUpdateRequestModel.bowlerPosition=0;
                      ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('over_number', value.data!.overNumber??0);
                        await prefs.setInt('ball_number', value.data!.ballNumber??1);
                        await prefs.setInt('striker_id', value.data!.strikerId??0);
                        await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                      });

                      Navigator.pop(context);
                    },
                        child: OkBtn("Ok")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
