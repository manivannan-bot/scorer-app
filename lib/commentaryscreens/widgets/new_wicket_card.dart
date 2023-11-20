import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/sizes.dart';

class NewWicketCard extends StatelessWidget {
  final String batsmanName, bowlerName, runsScored, ballsFaced;
  const NewWicketCard(this.batsmanName, this.bowlerName, this.runsScored, this.ballsFaced, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xddff114411),
              Color(0xffFF0000),
            ],
          ),
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Stack(
        children: [
          SvgPicture.asset(Images.wktImage, fit: BoxFit.cover, width: 90.w,),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 0.5.h
            ) + EdgeInsets.only(
                left: 3.w, right: 12.w
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15.0),
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
            child: Text("Wicket",
              style: fontRegular.copyWith(
                  color: AppColor.textColor,
                  fontSize: 9.sp
              ),),
          ),
          Positioned(
            bottom: 1.h,
            left: 5.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(child: Image.asset(Images.profileImage,width: 10.w,)),
                SizedBox(width: 2.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: batsmanName.toUpperCase(),
                              style: fontMedium.copyWith(
                                fontSize: 11.sp,
                                color: AppColor.lightColor,
                              )),
                          TextSpan(
                              text: " $runsScored",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.lightColor
                              )),
                          TextSpan(
                              text: " ($ballsFaced)",
                              style: fontMedium.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.lightColor
                              )),
                        ])),
                    SizedBox(
                      width: 30.w,
                      child: Text("b ${bowlerName.toUpperCase()}",style: fontRegular.copyWith(
                        fontSize: 9.sp,
                        color: AppColor.lightColor,
                      ),),
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