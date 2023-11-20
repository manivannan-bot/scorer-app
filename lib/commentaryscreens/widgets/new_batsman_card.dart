import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/images.dart';
import '../../utils/sizes.dart';

class NewBatsmanCard extends StatelessWidget {
  final String batsmanName, style;
  const NewBatsmanCard(this.batsmanName, this.style, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff141E4A),
              Color(0xff202F7B)
            ],
          ),
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Stack(
        children: [
          SvgPicture.asset(Images.newBatsmanImage, fit: BoxFit.cover, width: 90.w,),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 0.7.h
            ) + EdgeInsets.only(
                left: 3.w, right: 12.w
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
            child: Text("New batsman",
              style: fontRegular.copyWith(
                  color: AppColor.textColor,
                  fontSize: 9.sp
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
                    Text(
                        batsmanName.toUpperCase(),
                        style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.lightColor,
                        )),
                    Text("b ${style.toUpperCase()}",style: fontRegular.copyWith(
                      fontSize: 9.sp,
                      color: AppColor.lightColor,
                    ),),
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