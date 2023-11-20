import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class OverBallAndBowlerToBatsman extends StatelessWidget {
  final String overBall, batsman, bowler;
  const OverBallAndBowlerToBatsman(this.overBall, this.bowler, this.batsman, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(overBall,style: fontMedium.copyWith(
          fontSize: 12.sp,
          color: AppColor.blackColour,
        ),),
        SizedBox(width: 5.w,),
        RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: bowler,
                  style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: const Color(0xff666666)
                  )),
              TextSpan(
                  text: " to ",
                  style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: const Color(0xff666666)
                  )),
              TextSpan(
                  text: bowler,
                  style: fontMedium.copyWith(
                      fontSize: 11.sp,
                      color: const Color(0xff666666)
                  )),

            ])),
      ],
    );
  }
}