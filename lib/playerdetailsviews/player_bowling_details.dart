import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class RecentBowlingDetails extends StatefulWidget {
  const RecentBowlingDetails({super.key});

  @override
  State<RecentBowlingDetails> createState() => _RecentBowlingDetailsState();
}

class _RecentBowlingDetailsState extends State<RecentBowlingDetails> {
  List<Map<String,dynamic>> itemList=[
    {
      "image":'assets/images/req_list.png',
      "name":"Akash",
      "team":"(Toss and Tails)",
      "dot":".",
      "batsman":"Right hand batsman",
      "button":"Connect",
    },
    {}, {}, {}, {},


  ];
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
        Expanded(
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: Divider(
                    color: Color(0xffD3D3D3),
                  ),
                );
              },
              itemCount: itemList.length,
              itemBuilder: (BuildContext, int index) {
                final item = itemList[index];
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
                                    text: ("2-"),
                                    style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.blackColour,
                                    )),
                                TextSpan(
                                    text: "(29)",
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
                          Text("Spartans",style: fontRegular.copyWith(
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

      ],
    );
  }
}
