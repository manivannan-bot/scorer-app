import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/models/teams/team_matches_model.dart';
import 'package:scorer/teamsdetailsview/team_matches_live_view.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';


class TeamLiveMatches extends StatefulWidget {
  final List<LiveMatches>? liveMatches;
  const TeamLiveMatches(this.liveMatches, {super.key});

  @override
  State<TeamLiveMatches> createState() => _TeamLiveMatchesState();
}

class _TeamLiveMatchesState extends State<TeamLiveMatches> {

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,  // Set this to true to remove top padding
      removeBottom: true,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, _) {
            return Padding(
              padding: EdgeInsets.only(bottom: 2.h),
            );
          },
          itemCount:widget.liveMatches!.length ,
          itemBuilder: (context, int index) {
            final item = widget.liveMatches![index];
            return GestureDetector(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  TeamMatchesLiveView(item.teams!.matchId.toString(),item.teams!.team1Id.toString(),item.teams!.team2Id.toString())));
            },
              child: Padding(
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
                                        SizedBox(width: 2.w,),
                                        Text("${item.teams!.team1Name}",
                                            style: fontMedium.copyWith(
                                              fontSize: 13.sp,
                                              color: AppColor.pri,
                                            )
                                        ),
                                        SizedBox(width: 2.w,),
                                        RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: "${item.teamInnings!.first.totalScore}",
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
                                        SizedBox(width: 2.w,),
                                        RichText(text: TextSpan(children: [
                                          TextSpan(
                                              text: "${item.teamInnings!.first.currOvers}",
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: const Color(0xff444444)
                                              )),
                                          TextSpan(
                                              text: "/",
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: const Color(0xff444444)
                                              )),
                                          TextSpan(
                                              text: "${item.teamInnings!.first.totalOvers}",
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: const Color(0xff444444)
                                              )),
                                        ])),
                                        SizedBox(width: 1.w,),
                                        (item.teams!.currentInnings==1)?SvgPicture.asset(Images.batIcon,width: 5.w,):Text(''),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w,top: 1.h),
                                    child: Row(
                                      children: [
                                        Image.asset(Images.teamblogo,width: 10.w,fit: BoxFit.fill,),
                                        SizedBox(width: 2.w,),
                                        Text("${item.teams!.team2Name}", style: fontMedium.copyWith(
                                          fontSize: 13.sp,
                                          color:const Color(0xff555555),
                                        ),),
                                        SizedBox(width: 2.w,),
                                        (item.teams!.currentInnings==1)?Text("Yet to bat", style: fontRegular.copyWith(
                                          fontSize: 12.sp,
                                          color:const Color(0xff666666),
                                        ),):Row(children:[
                                          RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "${item.teamInnings![1].totalScore}",
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
                                          SizedBox(width: 2.w,),
                                          RichText(text: TextSpan(children: [
                                            TextSpan(
                                                text: "${item.teamInnings![1].currOvers}",
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: const Color(0xff444444)
                                                )),
                                            TextSpan(
                                                text: "/",
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: const Color(0xff444444)
                                                )),
                                            TextSpan(
                                                text: "${item.teamInnings![1].totalOvers}",
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: const Color(0xff444444)
                                                )),
                                          ])),
                                          SizedBox(width: 1.w,),
                                          SvgPicture.asset(Images.batIcon,width: 5.w,),
                                        ]),
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
                                    padding:  EdgeInsets.only(right: 6.w),
                                    child: Container(
                                      padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                                      decoration:  BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(Images.liveIcon,width: 2.5.w,),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text("Live",style: fontRegular.copyWith(
                                            fontSize: 10.5.sp,
                                            color: const Color(0xff444444),
                                          ),)
                                        ],
                                      ),
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
              ),
            );
          }),
    );
  }
}
