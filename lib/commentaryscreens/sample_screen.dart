import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:sizer/sizer.dart';

import '../utils/images.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 10.h
        ),
        child: Column(
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
                  borderRadius: BorderRadius.circular(15.0)
              ),
              child: Stack(
                children: [
                   SvgPicture.asset(Images.wktImage, fit: BoxFit.cover, width: 90.w,),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 0.7.h
                    ),
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
                    child: Text("Wicket",
                      style: fontRegular.copyWith(
                          color: AppColor.textColor,
                          fontSize: 11.sp
                      ),),
                  ),
                   Positioned(
                     top: 5.h,
                     left: 5.w,
                     child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(child: Image.asset(Images.profileImage,width: 12.w,)),
              SizedBox(width: 2.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Pandi ",
                              style: fontMedium.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.lightColor,
                              )),
                          TextSpan(
                              text: "21",
                              style: fontMedium.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.lightColor
                              )),
                          TextSpan(
                              text: "(10)",
                              style: fontMedium.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.lightColor
                              )),
                        ])),
                  SizedBox(
                      width: 30.w,
                      child: Text("b Prasanth",style: fontRegular.copyWith(
                        fontSize: 10.sp,
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
            ),
          ],
        ),
      ),
    );
  }
}
