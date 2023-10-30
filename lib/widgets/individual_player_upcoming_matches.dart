import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class IndividualPlayerUpcomingMatches extends StatefulWidget {
  const IndividualPlayerUpcomingMatches({super.key});

  @override
  State<IndividualPlayerUpcomingMatches> createState() => _IndividualPlayerUpcomingMatchesState();
}

class _IndividualPlayerUpcomingMatchesState extends State<IndividualPlayerUpcomingMatches> {
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
                            padding:  EdgeInsets.only(left: 2.w,top: 0.h),
                            child: Row(
                              children: [
                                Image.asset(Images.teamaLogo,width: 10.w,),
                                SizedBox(width: 3.w,),
                                Text("Toss and tails",style: fontMedium.copyWith(
                                  fontSize: 13.sp,
                                  color: AppColor.blackColour,
                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 2.w,top: 1.h),
                            child: Row(
                              children: [
                                Image.asset(Images.teamblogo,width: 10.w,fit: BoxFit.fill,),
                                SizedBox(width: 3.w,),
                                Text("Dhoni CC", style: fontMedium.copyWith(
                                    fontSize: 13.sp,
                                    color:AppColor.blackColour
                                ),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    //dassh
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
                              color: AppColor.blackColour,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20))
                          ),
                          child: Row(
                            children: [
                              Text("Upcoming",style: fontRegular.copyWith(
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
                              Text("29/06/2023",style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: Color(0xff666666)
                              ),),
                              Text("11:00 AM", style: fontMedium.copyWith(
                                fontSize: 13.sp,
                                color:AppColor.pri,
                              ),),
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
