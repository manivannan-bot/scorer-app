import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class ScorerGridOut extends StatelessWidget {
  final String index, text;
  const ScorerGridOut(this.index, this.text,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      width: 19.w,
      decoration: const BoxDecoration(shape: BoxShape.rectangle,color: AppColor.scoreUpdateBg,),
      child: Center(
        child: CircleAvatar(
          radius: 6.w, // Adjust the radius as needed for the circle size
          backgroundColor: Colors.red,
          child: Text(
            index,
            style:  fontSemiBold.copyWith(color: AppColor.lightColor, fontSize: 12.sp),
          ),
        ),
      ),
    );
  }
}
