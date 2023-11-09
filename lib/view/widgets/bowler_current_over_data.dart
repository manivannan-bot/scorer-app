import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class BowlerCurrentOverData extends StatelessWidget {
  final String bowlerName, overData;
  const BowlerCurrentOverData(this.bowlerName, this.overData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(bowlerName,
            style: fontMedium.copyWith(
                color: AppColor.textColor, fontSize: 10.sp)),
        SizedBox(width: 2.w),
        Text(overData,
            style: fontRegular.copyWith(
                color: AppColor.textColor, fontSize: 10.sp)),
      ],
    );
  }
}
