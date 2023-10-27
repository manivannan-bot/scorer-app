import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamCompletedMatchesScreen extends StatefulWidget {
  const TeamCompletedMatchesScreen({super.key});

  @override
  State<TeamCompletedMatchesScreen> createState() => _TeamCompletedMatchesScreenState();
}

class _TeamCompletedMatchesScreenState extends State<TeamCompletedMatchesScreen> {
  final List<Map<String,dynamic>>itemList=[
    {},{},{},{},{},{},{},{},{},
  ];
  @override
  Widget build(BuildContext context) {
    return  MediaQuery.removePadding(
      context: context,
      removeTop: true, // Remove top system padding (status bar)
      removeBottom: true,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, _) {
            return Padding(
              padding: EdgeInsets.only(bottom: 2.h),
            );
          },
          itemCount:itemList.length ,
          itemBuilder: (BuildContext, int index) {
            final item = itemList[index];
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8F9FA),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
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
                            SizedBox(
                              width: 1.w,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: 2.h),
                              child: Dash(
                                  direction: Axis.vertical,
                                  length: 6.h,
                                  dashGap: 1,
                                  dashLength: 5,
                                  dashColor: Color(0xffEFEAEA)),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Column(
                              children: [
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
          }),
    );
  }
}
