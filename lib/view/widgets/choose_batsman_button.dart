import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class ChooseBatsmanButton extends StatelessWidget {
  const ChooseBatsmanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
            vertical: 1.4.h
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 5.w
        ),
        decoration: BoxDecoration(
            color: AppColor.availableSlot.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(
          child: Text("Choose Batsman",
            style: fontMedium.copyWith(
                color: AppColor.textColor,
                fontSize: 10.sp
            ),),
        )
    );
  }
}
