import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';


class StatsBatting extends StatefulWidget {
  const StatsBatting({super.key});

  @override
  State<StatsBatting> createState() => _StatsBattingState();
}

class _StatsBattingState extends State<StatsBatting> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(height: 2.h,),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0.w,
            vertical: 0.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffF8F9FA),
          ),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Matches',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                           SizedBox(width: 15.w),
                          Text(
                            '250',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                   Container(
                     height: 5.h,
                     width: 0.3.w,
                     color: Color(0xffD3D3D3),
                   ),
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Innings',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '220',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Runs',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '250',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      width: 0.3.w,
                      color: Color(0xffD3D3D3),
                    ),
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Balls',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '220',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0..h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Highest',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '150',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      width: 0.3.w,
                      color: Color(0xffD3D3D3),
                    ),
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Average',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '22.3',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0..h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'SR',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '150',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      width: 0.3.w,
                      color: Color(0xffD3D3D3),
                    ),
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Not out',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '22',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0..h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Fours',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '150',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      width: 0.3.w,
                      color: Color(0xffD3D3D3),
                    ),
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Sixes',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '22',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            'Ducks',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '10',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      width: 0.3.w,
                      color: Color(0xffD3D3D3),
                    ),
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            '50s',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '20',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            '100s',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '10',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      width: 0.3.w,
                      color: Color(0xffD3D3D3),
                    ),
                    SizedBox(
                      width:40.w,
                      child: Row(
                        children: [
                          Text(
                            '200s',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.textGrey),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            '1',
                            style: fontRegular.copyWith(fontSize: 12.sp, color: AppColor.blackColour),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
