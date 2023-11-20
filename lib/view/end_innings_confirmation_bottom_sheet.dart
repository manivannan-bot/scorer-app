import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Scoring screens/home_screen.dart';
import '../utils/colours.dart';
import '../utils/sizes.dart';

class EndInningsConfirmationBottomSheet extends StatelessWidget {
  const EndInningsConfirmationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var platform = Theme
        .of(context)
        .platform;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Padding(
        padding: platform == TargetPlatform.iOS
            ? EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 2.w)
            : EdgeInsets.symmetric(
            vertical: 1.h,
            horizontal: 2.w),
        child: Container(
            height: 20.h,
            padding: EdgeInsets.symmetric(
                vertical: 2.h,
                horizontal: 5.w),
            decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Would you like to end the innings?",
                  style: fontMedium.copyWith(
                      color: AppColor.textColor,
                      fontSize: 14.sp),
                ),
                SizedBox(height: 1.h),
                const Spacer(),
                Row(
                  children: [
                    //don't close the app
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColor.secondaryColor, width: 0.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  1.5.h),
                              child: Text(
                                "No",
                                style: fontMedium.copyWith(
                                  color: AppColor.secondaryColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    //close the app
                    Expanded(
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.pri,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                  1.5.h),
                              child: Text(
                                "Yes",
                                style: fontMedium.copyWith(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
