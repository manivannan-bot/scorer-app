import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/Scoring%20screens/home_tab.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/styles.dart';
import 'package:sizer/sizer.dart';

import '../commentaryscreens/sample_screen.dart';
import '../models/all_matches_model.dart';

import '../sample_screen.dart';

import '../more/more_screen.dart';

import '../utils/images.dart';
import '../widgets/Individual_player_completed_list.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/dialog_others.dart';
import '../widgets/individual_player_upcoming_matches.dart';
import '../widgets/ok_btn.dart';
import 'match_preview_bottom_sheet.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  late TabController tabController;
  AllMatchesModel allMatchesModel =AllMatchesModel();

  @override
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

                        GestureDetector(
                          onTap: (){
                            _displayBottomSheetDoScoring(context);
                          },
                          child: Text('Hello!\n prasanth',style: fontMedium.copyWith(
                            fontSize: 15.sp,
                            color: AppColor.lightColor
                          ),),
                        ),
                        Spacer(),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                                            MaterialPageRoute(builder: (context) => MoreScreen()));

                            },
                            child: SvgPicture.asset(Images.notificationIcon,color: AppColor.lightColor,))
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      children: [
                        SvgPicture.asset(Images.locationIcon),
                        SizedBox(width: 2.w,),
                        GestureDetector(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => SampleScreen()));
                          },
                          child: RichText(
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
                        ),
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
                 isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      color: AppColor.primaryColor
                ),
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
                   HomeTab(),
                    HomeTab(),
                  ]),
            )
          ],
        ),
      ),
    );
  }

}

