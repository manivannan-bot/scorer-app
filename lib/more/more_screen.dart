import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../playerdetailsviews/player_detail_view_screen.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import 'about_screen.dart';
import 'edit_profile_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    // height: 29.h,
                    child: Image.asset(Images.moreBgImage, fit: BoxFit.cover,),
                  ),
                  Positioned(
                    top: 5.h,
                    // top: statusBarHeight + 1.h,
                    left: 5.w,
                    right: 5.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back,size: 7.w,color: AppColor.lightColor,)),
                        Text("Profile",style: fontMedium.copyWith(
                          fontSize: 17.sp,
                          color: AppColor.lightColor,
                        ),),
                        SizedBox(width: 7.w,),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 5.w,
                    right: 5.w,
                    child:Row(
                      children: [
                        ClipOval(
                          child:  Image.asset(Images.profileImage,width: 20.w,),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              Text("Prasanth",
                                style: fontMedium.copyWith(
                                    fontSize: 18.sp,
                                    color: AppColor.lightColor
                                ),),
                              SizedBox(height: 0.2.h),
                              Text("9856235665",
                                style: fontRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.lightColor
                                ),),
                              SizedBox(height: 0.5.h),
                              Bounceable(
                                onTap: () {
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 1.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF9D700),
                                    borderRadius: BorderRadius.circular(
                                        5.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,
                                                                    MaterialPageRoute(builder: (context) => EditProfileScreen()));
                                    },
                                    child: Text("Edit Profile",
                                      style: fontRegular.copyWith(
                                          color: AppColor.textColor,
                                          fontSize: 8.sp
                                      ),),
                                  ),
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              SizedBox(
                                width: 40.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .end,
                                  children: [
                                    Text("66%",
                                      style: fontRegular.copyWith(
                                          fontSize: 9.sp,
                                          color: AppColor.lightColor
                                      ),),
                                    ClipRRect(
                                      borderRadius: BorderRadius
                                          .circular(3.0),
                                      child: LinearProgressIndicator(
                                        color: const Color(0xffF9D700),
                                        backgroundColor: AppColor
                                            .lightColor,
                                        value: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.w
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(""
                                "Overview",
                              style: fontMedium.copyWith(
                                  fontSize: 16.sp,
                                  color:  AppColor
                                      .textColor
                              ),),
                            SizedBox(height: 2.h),
                            const ProfileOption(
                                "Matches"),
                            const SeparatorDivider(),
                             const ProfileOption("Scored Matches"),
                             const SeparatorDivider(),
                            SizedBox(height: 2.h),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Settings",
                              style: fontMedium.copyWith(
                                  fontSize: 16.sp,
                                  color: AppColor
                                      .textColor
                              ),),
                            SizedBox(height: 1.h),
                            const ProfileOption(
                                "Notifications"),
                            const SeparatorDivider(),
                            // const ProfileOption("Reports"),
                            // const SeparatorDivider(),
                            SizedBox(height: 2.h),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "About",
                              style: fontMedium.copyWith(
                                  fontSize: 16.sp,
                                  color:  AppColor
                                      .textColor
                              ),),
                            SizedBox(height: 2.h),
                            const ProfileOption(
                                "Terms & conditions"),
                            const SeparatorDivider(),
                            const ProfileOption("Privacy Policy"),
                            const SeparatorDivider(),
                            SizedBox(height: 2.h),

                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerDetailViewScreen('1')));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.blackColour,
                                ),
                                child: Text(
                                  "Register as Scorer",
                                  style: fontRegular.copyWith(
                                      fontSize: 12.sp,
                                      color:  AppColor
                                          .lightColor
                                  ),),
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.blackColour,
                                ),
                                child: Text(
                                  "Register as Scorer",
                                  style: fontRegular.copyWith(
                                      fontSize: 12.sp,
                                      color:  AppColor
                                          .lightColor
                                  ),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // permissionGranted
          //     ? const SizedBox()
          //     : Positioned(
          //   bottom: 0.0,
          //   left: 0.0,
          //   right: 0.0,
          //   child: Container(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 3.w,
          //       vertical: 2.h,
          //     ),
          //     width: double.maxFinite,
          //     decoration: const BoxDecoration(
          //       color: Color(0xffFEF5E7),
          //     ),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: Text("Allow permission to get notified for every action on your 11s journey",
          //             style: fontMedium.copyWith(
          //                 color: const Color(0xff34495E),
          //                 fontSize: 11.sp
          //             ),
          //           ),
          //         ),
          //         SizedBox(width: 3.w),
          //         Container(
          //           padding: EdgeInsets.symmetric(
          //             horizontal: 2.w,
          //             vertical: 1.h,
          //           ),
          //           decoration: BoxDecoration(
          //             color: const Color(0xff34495E),
          //             borderRadius: BorderRadius.circular(5.0),
          //           ),
          //           child: Text("Go to Settings",
          //             style: fontMedium.copyWith(
          //                 color: AppColor.lightColor,
          //                 fontSize: 10.sp
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class SeparatorDivider extends StatelessWidget {
  const SeparatorDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: 1 , color: Color(0xffEFEFEF));
  }
}

class ProfileOption extends StatelessWidget {
  final String option;
  const ProfileOption(this.option, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 0.7.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(option,
            style: fontRegular.copyWith(
                fontSize: 11.sp,
                color: AppColor.textColor
            ),),
          Icon(Icons.arrow_forward_ios, color: const Color(0xff8E8E8E), size: 3.5.w,)
        ],
      ),
    );
  }
}
