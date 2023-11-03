import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../models/all_matches_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import '../widgets/do_scoring_btn.dart';
import 'do_scoring.dart';


class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {


  List<Matches>? matchList=[];
  Future<List<Matches>?>? futureData;
  getData(){
    futureData = ScoringProvider().getAllMatches().then((value) {
      setState(() {
        matchList=[];
        matchList=value.matches;
      });

      return matchList;
    } );
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    if(matchList!.isEmpty){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, _) {
          return Padding(
            padding: EdgeInsets.only(bottom: 2.h),
          );
        },
        itemCount:matchList!.length ,
        itemBuilder: (context, int index) {
          final item = matchList![index];
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.lightColor,
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
                                              text: ('${item.team1Name}'),
                                              style: fontMedium.copyWith(
                                                fontSize: 13.sp,
                                                color: AppColor.blackColour,
                                              )),

                                        ])),
                                    SizedBox(width: 3.w,),
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: ('${item.teams!.first.totalRuns}'),
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
                                              text: "${item.teams!.first.totalWickets}",
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColor.pri
                                              )),
                                        ])),
                                    SizedBox(width: 3.w,),
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: ('${item.teams!.first.currentOverDetails}'),
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
                                              text: "${item.overs}",
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
                                              text: ('${item.team2Name}'),
                                              style: fontMedium.copyWith(
                                                fontSize: 13.sp,
                                                color: AppColor.blackColour,
                                              )),

                                        ])),
                                    SizedBox(width: 3.w,),
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: ('${item.teams![1].totalRuns}'),
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
                                              text: "${item.teams![1].totalWickets}",
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColor.pri
                                              )),
                                        ])),
                                    SizedBox(width: 3.w,),
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: ('${item.teams![1].currentOverDetails}'),
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
                                              text: "${item.overs}",
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
                                              text: ('${item.resultDescription??'-'} '),
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
        });
  }
}
