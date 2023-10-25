import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';


class OutBtn extends StatelessWidget {
  final String label;
  const OutBtn({required this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 8.5.w,vertical: 0.8.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.primaryColor
      ),
      child: Text(label,style: fontRegular.copyWith(
        fontSize: 14.sp,
        color: AppColor.blackColour,
      ),),
    );
  }
}

