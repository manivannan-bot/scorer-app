import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class BowlerCurrentOverData extends StatelessWidget {
  final String bowlerName, overData1, overData2;
  const BowlerCurrentOverData(this.bowlerName, this.overData1, this.overData2, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(bowlerName.split(' ').first.toString(),
              style: fontSemiBold.copyWith(
                  color: AppColor.textColor, fontSize: 9.sp)),
        ),
        SizedBox(width: 2.w),
        Text(overData1,
            style: fontMedium.copyWith(
                color: AppColor.textColor, fontSize: 11.sp)),
        SizedBox(width: 1.w),
        Text(overData2,
            style: fontRegular.copyWith(
                color: AppColor.textColor, fontSize: 9.sp)),
      ],
    );
  }
}
