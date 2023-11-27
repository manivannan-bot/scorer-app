import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class EndOfOverCard extends StatelessWidget {
  const EndOfOverCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffE9E9E9),
      ),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.8.h),
            child: Row(
              children: [
                Text("Over 1",style: fontMedium.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.blackColour
                ),),
                SizedBox(width: 3.w,),
                Dash(
                    direction: Axis.vertical,
                    length: 3.h,
                    dashGap: 1,
                    dashLength: 5,
                    dashColor: const Color(0xffD3D3D3)),
                SizedBox(width: 3.w,),
                Text("11 Runs",style: fontMedium.copyWith(
                    fontSize: 11.sp,
                    color: AppColor.blackColour
                ),),
                const Spacer(),
                Row(
                  children: [
                    Text("Dhoni CC",style: fontMedium.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff555555)
                    ),),
                    SizedBox(width: 2.w,),
                    Text("50/3",style: fontMedium.copyWith(
                        fontSize: 11.sp,
                        color: AppColor.blackColour
                    ),),
                  ],
                )
              ],
            ),
          ),
          const DottedLine(
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
                        fontSize: 11.sp,
                        color: const Color(0xff555555)
                    ),),
                    SizedBox(height: 0.4.h,),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "21",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.textColor
                              )),
                          TextSpan(
                              text: " (10)",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: const Color(0xff555555)
                              )),
                        ])),
                  ],
                ),
                Column(
                  children: [
                    Text("Dinesh",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff555555)
                    ),),
                    SizedBox(height: 0.4.h,),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "21",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.blackColour
                              )),
                          TextSpan(
                              text: " (10)",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: const Color(0xff555555)
                              )),
                        ])),
                  ],
                ),
                Dash(
                    direction: Axis.vertical,
                    length: 5.h,
                    dashGap: 1,
                    dashLength: 5,
                    dashColor: const Color(0xffD3D3D3)),
                Column(
                  children: [
                    Text("Arunkumar",style: fontRegular.copyWith(
                        fontSize: 11.sp,
                        color: const Color(0xff555555)
                    ),),
                    SizedBox(height: 0.4.h,),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "1",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.blackColour
                              )),
                          TextSpan(
                              text: "-",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.blackColour
                              )),
                          TextSpan(
                              text: "11 ",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.blackColour
                              )),
                          TextSpan(
                              text: "(1.0)",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: const Color(0xff555555)
                              )),
                        ])),
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