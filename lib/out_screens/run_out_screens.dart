import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:sizer/sizer.dart';

import '../models/scoring_detail_response_model.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class RunOutScreen extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  const RunOutScreen({required this.ballType,required this.scoringData,super.key});

  @override
  State<RunOutScreen> createState() => _RunOutScreenState();
}

class _RunOutScreenState extends State<RunOutScreen> {
  int? isSelected=0;
  int? isStump=0;
  int? isWideSelected ;
  int? isRunSelected ;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> chipData =[
      {
        'label': "Wide",
      },
      {
        'label': 'No ball',
      },
      {
        'label': 'LB',
      },
      {
        'label': 'Byes',
      },


    ];
    List<Map<String, dynamic>> chipDatas =[
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
      }, {
        'label': '6',
      },
      {
        'label': '7',
      },

    ];
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
                  Text("Run out",style: fontMedium.copyWith(
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
                      padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select the batsman*",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.5.h,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSelected =1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal:8.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isSelected ==1)?AppColor.primaryColor:AppColor.lightColor,

                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(Images.playerImg,width: 20.w,),
                                      SizedBox(height: 1.h,),
                                      Text("${widget.scoringData!.data!.batting![0].playerName}",style: fontMedium.copyWith(
                                        fontSize: 17.sp,
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

                                    isSelected =2;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal:8.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isSelected ==2)?AppColor.primaryColor:AppColor.lightColor,

                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(Images.playerImg,width: 20.w,),
                                      SizedBox(height: 1.h,),
                                      Text("${widget.scoringData!.data!.batting![1].playerName}",style: fontMedium.copyWith(
                                        fontSize: 17.sp,
                                        color: AppColor.blackColour,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select the fielder*",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.5.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 10.w),
                            child: Container(
                              height: 7.h,
                              width: 14.w,
                              decoration: BoxDecoration(
                                border: RDottedLineBorder.all(
                                  color: Color(0xffCCCCCC),
                                  width: 1,
                                ),
                                color: Color(0xffF8F9FA),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: 2.h,bottom: 0.h),
                                    child: SvgPicture.asset(Images.plusIcon,width: 5.w,),
                                  ),
                                  SizedBox(height: 2.h,),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 1.5.h,),
                          Text("Select the fielder",style: fontRegular.copyWith(
                            fontSize: 13.sp,
                            color: AppColor.blackColour,
                          ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Which End?*",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.5.h,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isStump =1;
                                  });
                                },
                                child: Container(
                                  height: 15.h,
                                  width: 35.w,
                                  padding: EdgeInsets.symmetric(horizontal:2.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isStump ==1)?AppColor.primaryColor:AppColor.lightColor,
                                  ),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(Images.stumpLogo,width: 15.w,),
                                      SizedBox(height: 1.h,),
                                      Text("Striker end",style: fontMedium.copyWith(
                                        fontSize: 12.sp,
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
                                    isStump =2;
                                  });
                                },
                                child: Container(
                                  height: 15.h,
                                  width: 35.w,
                                  padding: EdgeInsets.symmetric(horizontal:2.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isStump ==2)?AppColor.primaryColor:AppColor.lightColor,
                                  ),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(Images.batLogo,width: 15.w,),
                                      SizedBox(height: 1.h,),
                                      Text("Non-Striker end",style: fontMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
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
                                    text: ("Delivery type"),
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
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:EdgeInsets.only(left: 6.w,right: 4.w,),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: ("Batsman Runs scored"),
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
                          ),
                          SizedBox(height: 1.5.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 1.w,right: 1.w),
                            child: Wrap(
                              spacing: 1.w, // Horizontal spacing between items
                              runSpacing: 0.5.h, // Vertical spacing between lines
                              alignment: WrapAlignment.center, // Alignment of items
                              children:chipDatas.map((data) {
                                final index = chipDatas.indexOf(data);
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isRunSelected=index;
                                    });
                                  },
                                  child: Chip(
                                    padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                                    label: Text(data['label'],style: fontRegular.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour
                                    ),),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: const BorderSide(
                                        color: Color(0xffDADADA),
                                      ),
                                    ),
                                    backgroundColor: isRunSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
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
                    CancelBtn("Cancel"),
                    SizedBox(width: 4.w,),
                    OkBtn("Ok"),
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
