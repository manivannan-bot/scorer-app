import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class IndividualPlayerCompletedMatches extends StatefulWidget {
  const IndividualPlayerCompletedMatches({super.key});

  @override
  State<IndividualPlayerCompletedMatches> createState() => _IndividualPlayerCompletedMatchesState();
}

class _IndividualPlayerCompletedMatchesState extends State<IndividualPlayerCompletedMatches> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffF8F9FA),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 1.5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 2.w,top: 1.h),
                            child: Row(
                              children: [
                                Image.asset(Images.teamaLogo,width: 10.w,),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('T'),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColor.blackColour,
                                          )),
                                      TextSpan(
                                          text: "&",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.blackColour
                                          )),
                                      TextSpan(
                                          text: "T",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.blackColour
                                          )),
                                    ])),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('0'),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColor.pri,
                                          )),
                                      TextSpan(
                                          text: "/",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.pri
                                          )),
                                      TextSpan(
                                          text: "0",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.pri
                                          )),
                                    ])),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('0.0'),
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: Color(0xff444444)
                                          )),
                                      TextSpan(
                                          text: "/",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: Color(0xff444444)
                                          )),
                                      TextSpan(
                                          text: "10",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: Color(0xff444444)
                                          )),
                                    ])),
                                SizedBox(width: 1.w,),

                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 2.w,top: 1.h),
                            child: Row(
                              children: [
                                Image.asset(Images.teamaLogo,width: 10.w,),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('T'),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColor.blackColour,
                                          )),
                                      TextSpan(
                                          text: "&",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.blackColour
                                          )),
                                      TextSpan(
                                          text: "T",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.blackColour
                                          )),
                                    ])),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('0'),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColor.pri,
                                          )),
                                      TextSpan(
                                          text: "/",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.pri
                                          )),
                                      TextSpan(
                                          text: "0",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.pri
                                          )),
                                    ])),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('0.0'),
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: Color(0xff444444)
                                          )),
                                      TextSpan(
                                          text: "/",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: Color(0xff444444)
                                          )),
                                      TextSpan(
                                          text: "10",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: Color(0xff444444)
                                          )),
                                    ])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 2.h),
                      child: Dash(
                          direction: Axis.vertical,
                          length: 8.h,
                          dashGap: 1,
                          dashLength: 5,
                          dashColor: Color(0xffEFEAEA)),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 0.2.h
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xffA1A1A1),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20))
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Completed",style: fontRegular.copyWith(
                                fontSize: 10.5.sp,
                                color: AppColor.lightColor,
                              ),)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right: 4.w,top: 1.h),
                          child: Column(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ('T&T '),
                                        style: fontMedium.copyWith(
                                          fontSize: 13.sp,
                                          color: AppColor.pri,
                                        )),
                                    TextSpan(
                                        text: "won",
                                        style: fontMedium.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColor.pri
                                        )),
                                    TextSpan(
                                        text: "\nby 9 runs",
                                        style: fontMedium.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColor.blackColour
                                        )),
                                  ])),
                              // Text("T&T won\nby 9 runs",style: fontRegular.copyWith(
                              //     fontSize: 12.sp,
                              //     color: Color(0xff666666)
                              // ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
