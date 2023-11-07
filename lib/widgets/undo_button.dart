import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 3.w
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: AppColor.textColor)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.undo, color: AppColor.textColor, size: 5.w,),
          SizedBox(width: 2.w,),
          Text("Undo",
            style: fontMedium.copyWith(
                color: AppColor.textColor,
                fontSize: 12.sp
            ),),
        ],
      ),
    );
  }
}
