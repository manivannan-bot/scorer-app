import 'package:flutter/material.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';
import '../widgets/ok_btn.dart';


class UndoScreen extends StatefulWidget {
  const UndoScreen({super.key});

  @override
  State<UndoScreen> createState() => _UndoScreenState();
}

class _UndoScreenState extends State<UndoScreen> {
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        height: 18.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //   )
          // ],
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("Undo",style: fontMedium.copyWith(
                fontSize: 17.sp,
                color: AppColor.blackColour,
              ),),
            ),
            SizedBox(height: 1.5.h,),
            Text("Are you sure ?",style: fontRegular.copyWith(
                fontSize: 11.sp,
                color: Color(0xff808080)
            ),),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CancelBtn("Cancel"),
                  SizedBox(width: 4.w,),
                  OkBtn("ok"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}