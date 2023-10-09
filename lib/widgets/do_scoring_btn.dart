import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/styles.dart';

class DoScoringBtn extends StatelessWidget {
  const DoScoringBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.blackColour
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.5.w,vertical: 0.6.h),
        child: Text("Do scoring",style: fontRegular.copyWith(
            fontSize: 10.sp,
            color: AppColor.lightColor
        ),),
      ),
    );
  }
}
