import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/styles.dart';

class CancelBtn extends StatelessWidget {
  final String label;
  const CancelBtn(this.label,{super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 0.8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.blackColour)
      ),
      child: Text("Cancel",style: fontRegular.copyWith(
        fontSize: 14.sp,
        color: AppColor.blackColour,
      ),),
    );
  }
}
