import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/Scoring%20screens/Scoring_tab.dart';
import 'package:scorer/provider/scoring_provider.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/styles.dart';
import 'package:sizer/sizer.dart';

import '../models/all_matches_model.dart';
import '../utils/images.dart';


class ScoringScreen extends StatefulWidget {
  const ScoringScreen({super.key});

  @override
  State<ScoringScreen> createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  AllMatchesModel allMatchesModel =AllMatchesModel();

  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
            width: double.infinity,
              height: 23.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.bannerbg), // Replace with your image path
                  fit: BoxFit.cover, // You can change the BoxFit as needed
                ),
              ),
              child:  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            Images.splashBottom,
                            width: 24.w,
                          ),
                        ),
                        SizedBox(width: 4.w,),
                        Text('Hello!\n prasanth',style: fontMedium.copyWith(
                          fontSize: 15.sp,
                          color: AppColor.lightColor
                        ),),
                        Spacer(),
                        SvgPicture.asset(Images.notificationIcon,color: AppColor.lightColor,)
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      children: [
                        SvgPicture.asset(Images.locationIcon),
                        SizedBox(width: 2.w,),
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: ("Chrompet,"),
                                  style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.lightColor,
                                  )),
                              TextSpan(
                                  text: "Chennai 600210",
                                  style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.lightColor
                                  )),
                            ])),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 1.h,),
            TabBar(
                labelPadding: EdgeInsets.symmetric(vertical: 0.5.h,horizontal: 5.w),
                labelColor: Colors.white,
                // unselectedLabelColor: AppColor.textColor,
                // unselectedLabelStyle: TextStyle(
                //   backgroundColor: Colors.grey, // Background color of inactive tabs
                // ),
                 isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      color: AppColor.primaryColor
                ),
                // dividerColor: Colors.transparent,
                // labelPadding: EdgeInsets.only
                //   (bottom: 0.5.h) + EdgeInsets.symmetric(
                //     horizontal: 4.w
                // ),
                indicatorSize: TabBarIndicatorSize.tab,
                // indicatorColor: AppColor.secondaryColor,
                controller: tabController,
                tabs: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 0.4.h),
                    child: Text('Scoring',style: fontRegular.copyWith(fontSize: 12.sp,color: AppColor.blackColour),),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text('Umpiring',style: fontRegular.copyWith(fontSize: 12.sp,color: AppColor.blackColour),),
                  ),
                ]
            ),
            SizedBox(height: 1.h,),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children:  [
                   ScoringTab(),
                    ScoringTab(),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
