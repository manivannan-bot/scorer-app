import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/models/players/players_overview_model.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class RecentBowlingDetails extends StatefulWidget {
  final List<RecentBowling>? bowlingList;
  const RecentBowlingDetails(this.bowlingList, {super.key});

  @override
  State<RecentBowlingDetails> createState() => _RecentBowlingDetailsState();
}

class _RecentBowlingDetailsState extends State<RecentBowlingDetails> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1.5.h,),
        Row(
          children: [
            Row(
              children: [
                Text("Recent form Bowling",style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 1.w,),
                SvgPicture.asset(Images.ballIcon,width: 5.w,),
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
        (widget.bowlingList!.isNotEmpty)?Expanded(
          child: Align(alignment: Alignment.topLeft,
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
                itemCount: widget.bowlingList!.length,
                itemBuilder: (context, int index) {
                  final item = widget.bowlingList![index];
                  return   Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.5.h),
                        width: 30.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffF8F9FA),
                        ),
                        child: Column(
                          children: [
                            RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: ("${item.wickets}-"),
                                      style: fontMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour,
                                      )),
                                  TextSpan(
                                      text: "(${item.runsConceded})",
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
          ),
        ):const Text('No Data Found'),

      ],
    );
  }
}
