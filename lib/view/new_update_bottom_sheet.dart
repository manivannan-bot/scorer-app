import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:lottie/lottie.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';

class NewUpdateBottomSheet extends StatefulWidget {
  final String heading, releaseNotes, type, versionNumber;
  final bool priority;
  const NewUpdateBottomSheet(this.heading, this.releaseNotes, this.priority, this.type, this.versionNumber, {super.key});

  @override
  State<NewUpdateBottomSheet> createState() => _NewUpdateBottomSheetState();
}

class _NewUpdateBottomSheetState extends State<NewUpdateBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(
          horizontal: 5.w
        ),
        decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5.h,),
            Lottie.asset("assets/update.json"),
            SizedBox(height: 5.h,),
            Text("v ${widget.versionNumber}",
              style: fontBold.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.textMildColor
              ),),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text(widget.heading,
              style: fontBold.copyWith(
                fontSize: 18.sp,
                color: AppColor.textColor
              ),),
            ),
            SizedBox(height: 5.h,),
            Text(widget.releaseNotes,
              textAlign: TextAlign.center,
              style: fontMedium.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.textColor
              ),),
            const Spacer(),
            Bounceable(
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 2.h
                ),
                decoration: BoxDecoration(
                  color: AppColor.pri,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Center(
                  child: Text("Update Now",
                  textAlign: TextAlign.center,
                  style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.lightColor
                  ),),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            !widget.priority ? const SizedBox() : Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text("Skip update",
                  style: fontBold.copyWith(
                      fontSize: 12.sp,
                      color: AppColor.pri
                  ),),
              ),
            ),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    );
  }
}
