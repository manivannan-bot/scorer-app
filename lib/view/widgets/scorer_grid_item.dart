import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colours.dart';
import '../../utils/sizes.dart';

class ScorerGridItem extends StatelessWidget {
  final String index, text;
  const ScorerGridItem(this.index, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      width: 19.w,
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      decoration: const BoxDecoration(shape: BoxShape.rectangle,color: Colors.black,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(text == "UNDO" || text == "OTHER")...[
            const SizedBox()
          ] else ...[
            CircleAvatar(
              radius: 5.w, // Adjust the radius as needed for the circle size
              backgroundColor: Colors.white,
              child: Text(
                index,
                style: fontMedium.copyWith(
                    color: AppColor.textColor, fontSize: 12.sp),
              ),
            ),
            SizedBox(height: 1.h,),
          ],
          text == "" ? const SizedBox() : Text(text == "UNDO" ? "Undo" : text == "OTHER" ? "Other" : text,
              style: fontMedium.copyWith(
              color: AppColor.lightColor,
              fontSize: text == "UNDO" || text == "OTHER" ?  12.sp : 9.sp)),
        ],
      ),
    );
  }
}
