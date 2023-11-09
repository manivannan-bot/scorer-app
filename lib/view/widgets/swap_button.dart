import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/sizes.dart';

class SwapButton extends StatelessWidget {
  const SwapButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.rectangle,
          color: Colors.black

      ),
      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.5.h),
      child: Text('Swap',
        style: fontMedium.copyWith(
            color: Colors.white,
            fontSize: 9.sp),),);
  }
}
