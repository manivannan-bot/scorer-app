import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class BallResultAndCommentary extends StatelessWidget {
  final String ballResult, commentary;
  const BallResultAndCommentary(this.ballResult, this.commentary, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xffFA3E3E),
          radius: 16,
          child: Text(ballResult,style:fontMedium.copyWith(
            fontSize: 12.sp,
            color: AppColor.lightColor,
          ),),
        ),
        SizedBox(width: 5.w,),
        Expanded(
          child: Text(commentary,style:fontRegular.copyWith(
            fontSize: 11.sp,
            color: AppColor.blackColour,
          ),),
        ),
      ],
    );
  }
}