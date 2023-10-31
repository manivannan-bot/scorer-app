import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class CommentaryAllScreen extends StatefulWidget {
  const CommentaryAllScreen({super.key});

  @override
  State<CommentaryAllScreen> createState() => _CommentaryAllScreenState();
}

class _CommentaryAllScreenState extends State<CommentaryAllScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            Container(
              height: 12.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff454545),
                      Color(0xff8C8C8C),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: Stack(
                children: [
                  SvgPicture.asset(Images.bowlingSpellImage, fit: BoxFit.cover, width: 90.w,),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 0.7.h
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        topLeft: Radius.circular(15.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.primaryColor,
                          AppColor.secondaryColor,
                        ],
                      ),
                    ),
                    child: Text("New bowling spell",
                      style: fontRegular.copyWith(
                          color: AppColor.textColor,
                          fontSize: 11.sp
                      ),),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(child: Image.asset(Images.profileImage,width: 12.w,)),
                        SizedBox(width: 2.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                 "Prasanth ",
                                style: fontMedium.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.lightColor,
                                )),
                            Text("b Right arm fast",style: fontRegular.copyWith(
                              fontSize: 10.sp,
                              color: AppColor.lightColor,
                            ),),
                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 1.h,),
            const Divider(
              color: Color(0xffD3D3D3),
            ),
            SizedBox(height: 1.h,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.5.h),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffE9E9E9),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
                    child: Row(
                      children: [
                        Text("Over 1",style: fontMedium.copyWith(
                          fontSize: 13.sp,
                          color: AppColor.blackColour
                        ),),SizedBox(width: 1.w,),
                         Dash(
                    direction: Axis.vertical,
                    length: 3.h,
                    dashGap: 1,
                    dashLength: 5,
                    dashColor: Color(0xffD3D3D3)),
                        SizedBox(width: 2.w,),
                        Text("11 Runs",style: fontMedium.copyWith(
                            fontSize: 13.sp,
                            color: AppColor.blackColour
                        ),),
                        Spacer(),
                        Row(
                          children: [
                            Text("Dhoni CC",style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff555555)
                            ),),
                            SizedBox(width: 2.w,),
                            Text("50/3",style: fontMedium.copyWith(
                                fontSize: 13.sp,
                                color: AppColor.blackColour
                            ),),
                          ],
                        )
                      ],
                    ),
                  ),
                  DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text("Arunkumar",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff555555)
                            ),),
                            SizedBox(height: 0.4.h,),
                            RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "21 ",
                                      style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour
                                      )),
                                  TextSpan(
                                      text: "(10)",
                                      style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: Color(0xff555555)
                                      )),
                                ])),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Arunkumar",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff555555)
                            ),),
                            SizedBox(height: 0.4.h,),
                            RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "21 ",
                                      style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour
                                      )),
                                  TextSpan(
                                      text: "(10)",
                                      style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: Color(0xff555555)
                                      )),
                                ])),
                          ],
                        ),
                        Dash(
                            direction: Axis.vertical,
                            length: 5.h,
                            dashGap: 1,
                            dashLength: 5,
                            dashColor: Color(0xffD3D3D3)),
                        Column(
                          children: [
                            Text("Arunkumar",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff555555)
                            ),),
                            SizedBox(height: 0.4.h,),
                            RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "1",
                                      style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour
                                      )),
                                  TextSpan(
                                      text: "-",
                                      style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour
                                      )),
                                  TextSpan(
                                      text: "11 ",
                                      style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour
                                      )),
                                  TextSpan(
                                      text: "(1.0)",
                                      style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: Color(0xff555555)
                                      )),
                                ])),
                          ],
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            //ball count desgin
            Row(
              children: [
                Text("6.3",style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 5.w,),
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Prasanth",
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          )),
                      TextSpan(
                          text: " to ",
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          )),
                      TextSpan(
                          text: "Pandi",
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          )),

                    ])),
              ],
            ),
            SizedBox(height: 1.h,),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xffDEDEDE), // Specify the border color
                      width: 1.0, // Specify the border width
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Color(0xffFBFAF7),
                    radius: 16,
                    child: Text("1",style:fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.blackColour,
                    ),),
                  ),
                ),
                SizedBox(width: 5.w,),
                SizedBox(
                  width: 75.w,
                  child: Text("Prasanth to Arunkumar, 6 run, knocked down to long-on",style:fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.blackColour,
                  ),),
                ),
              ],
            ),
            SizedBox(height: 1.h,),
            DottedLine(
              dashColor: Color(0xffD2D2D2),
            ),
            SizedBox(height: 1.h,),
            //new batsman design
            Row(
              children: [
                Text("6.3",style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 5.w,),
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Prasanth",
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          )),
                      TextSpan(
                          text: " to ",
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          )),
                      TextSpan(
                          text: "Pandi",
                          style: fontMedium.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          )),

                    ])),
              ],
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xffDEDEDE), // Specify the border color
                      width: 1.0, // Specify the border width
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Color(0xffFBFAF7),
                    radius: 16,
                    child: Text("1",style:fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.blackColour,
                    ),),
                  ),
                ),
                SizedBox(width: 5.w,),
                SizedBox(
                  width: 75.w,
                  child: Text("Prasanth to Arunkumar, 6 run, knocked down to long-on",style:fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.blackColour,
                  ),),
                ),
              ],
            ),
            SizedBox(height: 1.h,),
            Container(
              height: 12.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff141E4A),
                      Color(0xff202F7B)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: Stack(
                children: [
                  SvgPicture.asset(Images.newBatsmanImage, fit: BoxFit.cover, width: 90.w,),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 0.7.h
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25.0),
                        topLeft: Radius.circular(15.0),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.primaryColor,
                          AppColor.secondaryColor,
                        ],
                      ),
                    ),
                    child: Text("New batsman",
                      style: fontRegular.copyWith(
                          color: AppColor.textColor,
                          fontSize: 11.sp
                      ),),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 5.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(child: Image.asset(Images.profileImage,width: 12.w,)),
                        SizedBox(width: 2.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Prasanth ",
                                style: fontMedium.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.lightColor,
                                )),
                            Text("b Right arm fast",style: fontRegular.copyWith(
                              fontSize: 10.sp,
                              color: AppColor.lightColor,
                            ),),
                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 1.h,),
            DottedLine(
              dashColor: Color(0xffD2D2D2),
            ),
            SizedBox(height: 1.h,),

            //wkt design
           Padding(
          padding:  EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 12.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xDDff114411),
                            Color(0xffFF0000),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Stack(
                      children: [
                        SvgPicture.asset(Images.wktImage, fit: BoxFit.cover, width: 90.w,),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 7.w,
                              vertical: 0.7.h
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25.0),
                              topLeft: Radius.circular(15.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColor.primaryColor,
                                AppColor.secondaryColor,
                              ],
                            ),
                          ),
                          child: Text("Wicket",
                            style: fontRegular.copyWith(
                                color: AppColor.textColor,
                                fontSize: 11.sp
                            ),),
                        ),
                        Positioned(
                          top: 5.h,
                          left: 5.w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(child: Image.asset(Images.profileImage,width: 12.w,)),
                              SizedBox(width: 2.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "Pandi ",
                                            style: fontMedium.copyWith(
                                              fontSize: 14.sp,
                                              color: AppColor.lightColor,
                                            )),
                                        TextSpan(
                                            text: "21",
                                            style: fontMedium.copyWith(
                                                fontSize: 14.sp,
                                                color: AppColor.lightColor
                                            )),
                                        TextSpan(
                                            text: "(10)",
                                            style: fontMedium.copyWith(
                                                fontSize: 14.sp,
                                                color: AppColor.lightColor
                                            )),
                                      ])),
                                  SizedBox(
                                    width: 30.w,
                                    child: Text("b Prasanth",style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.lightColor,
                                    ),),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h,),
              Row(
                children: [
                  Text("6.3",style: fontMedium.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(width: 5.w,),
                  RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Prasanth",
                            style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff666666)
                            )),
                        TextSpan(
                            text: " to ",
                            style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff666666)
                            )),
                        TextSpan(
                            text: "Pandi",
                            style: fontMedium.copyWith(
                                fontSize: 12.sp,
                                color: Color(0xff666666)
                            )),

                      ])),
                ],
              ),
              SizedBox(height: 1.h,),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffFA3E3E),
                    radius: 16,
                    child: Text("W",style:fontMedium.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.lightColor,
                    ),),
                  ),
                  SizedBox(width: 5.w,),
                  Text("Prasanth to Pandi, out Bowled",style:fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.blackColour,
                  ),),
                ],
              ),
              const Divider(
                color: Color(0xffD3D3D3),
              ),
            ],
          ),
        ),
          ],
        ),
      ),
    );
  }
}
