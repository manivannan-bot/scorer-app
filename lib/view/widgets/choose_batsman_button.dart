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
        padding: EdgeInsets.symmetric(
            vertical: 1.4.h, horizontal: 3.w
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 5.w
        ),
        decoration: BoxDecoration(
            color: AppColor.blackColour,
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Text("Choose Batsman",
          style: fontMedium.copyWith(
              color: AppColor.lightColor,
              fontSize: 9.sp
          ),)
    );
  }
}
