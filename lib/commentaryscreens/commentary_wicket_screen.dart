import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/commentaryscreens/sample_screen.dart';
import 'package:scorer/models/commentary/commentary_wicket_model.dart';
import 'package:scorer/provider/match_provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class CommentaryWicketScreen extends StatefulWidget {
  final String matchId;
  final String teamId;
  const CommentaryWicketScreen(this.matchId, this.teamId, {super.key});

  @override
  State<CommentaryWicketScreen> createState() => _CommentaryWicketScreenState();
}

class _CommentaryWicketScreenState extends State<CommentaryWicketScreen> {
  final List<Map<String, dynamic>> itemList = [
    {},
    {},
    {},
  ];
  CommentaryWicketModel? commentaryWicketModel;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData(){
        MatchProvider().getCommentaryWickets(widget.matchId, widget.teamId).then((value){
          setState(() {
            commentaryWicketModel=value;
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    if(commentaryWicketModel==null){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeTop: true, // Set to true to remove top padding
            removeBottom: true, // Set to true to remove bottom padding
            removeLeft: true, // Set to true to remove left padding
            removeRight: true,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                  );
                },
                itemCount: commentaryWicketModel!.data!.length,
                itemBuilder: (context, int index) {
                  final item = commentaryWicketModel!.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Over",
                              style: fontMedium.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.blackColour,
                              )),
                          TextSpan(
                              text: " ${item.overNumber}",
                              style: fontMedium.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.blackColour,
                              )),
                        ])),
                        SizedBox(
                          height: 2.h,
                        ),
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
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    Images.wktImage,
                                    fit: BoxFit.cover,
                                    width: 90.w,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7.w, vertical: 0.7.h),
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
                                    child: Text(
                                      "Wicket",
                                      style: fontRegular.copyWith(
                                          color: AppColor.textColor,
                                          fontSize: 11.sp),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5.h,
                                    left: 5.w,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                            child: Image.asset(
                                          Images.profileImage,
                                          width: 12.w,
                                        )),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "${item.batsmanName} ",
                                                  style: fontMedium.copyWith(
                                                    fontSize: 14.sp,
                                                    color: AppColor.lightColor,
                                                  )),
                                              TextSpan(
                                                  text: "${item.runsScored}",
                                                  style: fontMedium.copyWith(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColor.lightColor)),
                                              TextSpan(
                                                  text: "(${item.ballsFaced})",
                                                  style: fontMedium.copyWith(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColor.lightColor)),
                                            ])),
                                            SizedBox(
                                              width: 30.w,
                                              child: Text(
                                                "b ${item.wicketerName}",
                                                style: fontRegular.copyWith(
                                                  fontSize: 10.sp,
                                                  color: AppColor.lightColor,
                                                ),
                                              ),
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
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "${item.over}",
                              style: fontMedium.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.blackColour,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "${item.bowlerName}",
                                  style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: Color(0xff666666))),
                              TextSpan(
                                  text: " to ",
                                  style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: Color(0xff666666))),
                              TextSpan(
                                  text: "${item.batsmanName}",
                                  style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: Color(0xff666666))),
                            ])),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xffFA3E3E),
                              radius: 16,
                              child: Text(
                                "W",
                                style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.lightColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "${item.bowlerName} to ${item.batsmanName},${item.outType}",
                              style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xffD3D3D3),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
