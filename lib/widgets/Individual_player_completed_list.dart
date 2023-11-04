import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:scorer/models/matches/umpire_matches_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class IndividualPlayerCompletedMatches extends StatefulWidget {
  final Matches item;
  const IndividualPlayerCompletedMatches(this.item, {super.key});

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
                                          text: ('${widget.item.teams!.team1Name}'),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColor.blackColour,
                                          )),
                                    ])),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('${widget.item.teamInnings!.first.totalScore}'),
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
                                          text: "${widget.item.teamInnings!.first.totalWickets}",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.pri
                                          )),
                                    ])),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('${widget.item.teamInnings!.first.currOvers}'),
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
                                          text: "${widget.item.teamInnings!.first.totalOvers}",
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
                                          text: ('${widget.item.teams!.team2Name}'),
                                          style: fontMedium.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColor.blackColour,
                                          )),

                                    ])),
                                SizedBox(width: 3.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('${widget.item.teamInnings![1].totalScore}'),
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
                                          text: "${widget.item.teamInnings![1].totalWickets}",
                                          style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.pri
                                          )),
                                    ])),
                                SizedBox(width: 1.w,),
                                RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: ('${widget.item.teamInnings![1].currOvers}'),
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
                                          text: "${widget.item.teamInnings![1].totalOvers}",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
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
                          padding:  EdgeInsets.only(top: 1.h),
                          child: Column(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ('${widget.item.teams!.wonTeam} '),
                                        style: fontMedium.copyWith(
                                          fontSize: 13.sp,
                                          color: AppColor.pri,
                                        )),
                                    TextSpan(
                                        text: ('${widget.item.teams!.resultDescription?.split(' ')[0]??''} \n'),
                                        style: fontMedium.copyWith(
                                          fontSize: 13.sp,
                                          color: AppColor.pri,
                                        )),
                                    TextSpan(
                                        text: ('${widget.item.teams!.resultDescription?.split(' ')[1]??''} ${widget.item.teams!.resultDescription?.split(' ')[2]??''} ${widget.item.teams!.resultDescription?.split(' ')[3]??''}'),
                                        style: fontMedium.copyWith(
                                          fontSize: 13.sp,
                                          color: AppColor.pri,
                                        )),

                                  ])),

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
