import 'package:flutter/material.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import 'ok_btn.dart';
import 'out_button.dart';

class OutMethodDialog extends StatefulWidget {
  final String label;
  const OutMethodDialog({required this.label,super.key});

  @override
  State<OutMethodDialog> createState() => _OutMethodDialogState();
}

class _OutMethodDialogState extends State<OutMethodDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 5.w
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
         height: 43.h,
         width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //   )
          // ],
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Column(
            children: [
              ClipOval(child: Image.asset(Images.outProfileimage,width: 20.w,)),
              SizedBox(height: 1.h,),
              Text("Prasanth",style: fontMedium.copyWith(
                  fontSize: 15.sp,
                  color: AppColor.blackColour
              ),),
              SizedBox(height: 1.h,),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(Images.outBg,fit: BoxFit.cover, width: double.maxFinite, height: 12.h,)),
                  Positioned(
                    top: 2.h,
                    child: Text("Dismissal method",style: fontMedium.copyWith(
                        fontSize: 13.sp,
                        color: AppColor.blackColour
                    ),),
                  ),
                  Positioned(
                      bottom: 2.h,
                      child:  Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0.6.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.primaryColor
                        ),
                        child: Text(widget.label,style: fontMedium.copyWith(
                          fontSize: 13.sp,
                          color: AppColor.blackColour,
                        ),),
                      ))
                ],
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: CancelBtn("cancel")),
                    SizedBox(width: 4.w,),
                    OkBtn("ok"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
