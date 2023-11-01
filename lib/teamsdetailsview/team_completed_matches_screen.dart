import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:scorer/models/teams/team_matches_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamCompletedMatchesScreen extends StatefulWidget {
  final List<CompletedMatches>? completedMatches;
  const TeamCompletedMatchesScreen(this.completedMatches, {super.key});

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
          itemCount:widget.completedMatches!.length ,
          itemBuilder: (context, int index) {
            final item = widget.completedMatches![index];
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF8F9FA),
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
                                                text: ('${item.teams!.team1Name}'),
                                                style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColor.blackColour,
                                                )),
                                          ])),
                                      SizedBox(width: 3.w,),
                                      RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: ('${item.teamInnings!.first.totalScore}'),
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
                                                text: "${item.teamInnings!.first.totalWickets}",
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: AppColor.pri
                                                )),
                                          ])),
                                      SizedBox(width: 3.w,),
                                      RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: ('${item.teamInnings!.first.currOvers}'),
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
                                                text: "${item.teamInnings!.first.totalOvers}",
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
                                                text: ('${item.teams!.team2Name}'),
                                                style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColor.blackColour,
                                                )),
                                          ])),
                                      SizedBox(width: 3.w,),
                                      RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: ('${item.teamInnings![1].totalScore}'),
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
                                                text: "${item.teamInnings![1].totalWickets}",
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: AppColor.pri
                                                )),
                                          ])),
                                      SizedBox(width: 3.w,),
                                      RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: ('${item.teamInnings![1].currOvers}'),
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: const Color(0xff444444)
                                                )),
                                            TextSpan(
                                                text: "/",
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: Color(0xff444444)
                                                )),
                                            TextSpan(
                                                text: "${item.teamInnings![1].totalOvers}",
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
                                  dashColor: const Color(0xffEFEAEA)),
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
                                                text: ('${item.teams!.resultDescription}'),
                                                style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColor.pri,
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
