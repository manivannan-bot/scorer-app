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
      decoration: const BoxDecoration(shape: BoxShape.rectangle,color: Colors.black,),
      child: Center(
        child: CircleAvatar(
          radius: 5.w, // Adjust the radius as needed for the circle size
          backgroundColor: Colors.red,
          child: Text(
            index,
            style:  fontMedium.copyWith(color: AppColor.lightColor, fontSize: 10.sp),
          ),
        ),
      ),
    );
  }
}
