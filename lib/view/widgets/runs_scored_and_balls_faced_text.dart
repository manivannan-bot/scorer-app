import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class RunsScoredAndBallsFacedText extends StatelessWidget {
  final String runsScored, ballsFaced;
  const RunsScoredAndBallsFacedText(this.runsScored, this.ballsFaced, {super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: runsScored,
          style: fontMedium.copyWith(
              color: AppColor.textColor, fontSize: 10.sp),
          children: <TextSpan>[
            TextSpan(text: ' ($ballsFaced)',
              style: fontRegular.copyWith(
                  color: AppColor.textColor, fontSize: 10.sp),
            )
          ]
      ),
    );
  }
}
