import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/models/players/players_overview_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class RecentBattingDetails extends StatefulWidget {
  final List<RecentBatting> recentBatting;
  const RecentBattingDetails(this.recentBatting, {super.key});

  @override
  State<RecentBattingDetails> createState() => _RecentBattingDetailsState();
}

class _RecentBattingDetailsState extends State<RecentBattingDetails> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1.5.h,),
        Row(
          children: [
            Row(
              children: [
                Text("Recent form Batting",style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 1.w,),
                SvgPicture.asset(Images.batIcon,width: 5.w,),
              ],
            ),
            Spacer(),
            Text("(Last 5 matches)",style: fontMedium.copyWith(
              fontSize: 11.sp,
              color: AppColor.textGrey,
            ),),
          ],
        ),
        SizedBox(height: 1.5.h,),
        (widget.recentBatting.isNotEmpty)?Expanded(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: const Divider(
                    color: Color(0xffD3D3D3),
                  ),
                );
              },
              itemCount: widget.recentBatting.length,
              itemBuilder: (context, int index) {
                final item = widget.recentBatting[index];
                return   Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.5.h),
                      width: 30.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffF8F9FA),
                      ),
                      child: Column(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ("${item.runsScored}"),
                                    style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.blackColour,
                                    )),
                                TextSpan(
                                    text: "(${item.ballsFaced})",
                                    style: fontMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour
                                    )),
                              ])),
                          SizedBox(height: 0.5.h,),
                          Text("vs",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.textGrey,
                          ),),
                          SizedBox(height: 0.5.h,),
                          Text("${item.opponent}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.textGrey,
                          ),),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ):const Text('No Data Found'),

      ],
    );
  }
}
