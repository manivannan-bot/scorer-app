import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/Scoring%20screens/home_tab.dart';
import 'package:scorer/provider/scoring_provider.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/styles.dart';
import 'package:sizer/sizer.dart';

import '../models/all_matches_model.dart';
import '../utils/images.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/dialog_others.dart';
import '../widgets/ok_btn.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
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
                        GestureDetector(
                          onTap: (){
                            _displayBottomSheetSettings(context);
                          },
                          child: Text('Hello!\n prasanth',style: fontMedium.copyWith(
                            fontSize: 15.sp,
                            color: AppColor.lightColor
                          ),),
                        ),
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
                   HomeTab(),
                    HomeTab(),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _displayBottomSheetSettings (BuildContext context) async{
    bool value1=false;bool value2=false;bool value3=false;bool value4=false;
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return Container(
            height: 45.h,
            // padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: const BoxDecoration(
                color: AppColor.lightColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,size: 7.w,)),
                      Text("Settings",style: fontMedium.copyWith(
                        fontSize: 17.sp,
                        color: AppColor.blackColour,
                      ),),
                      SizedBox(width: 7.w,),
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  const Divider(
                    color: Color(0xffD3D3D3),
                  ),
                  SizedBox(height: 1.h,),
                  Row(
                    children: [
                      Text("Scoring area",style: fontMedium.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColour,
                      ),),
                      Spacer(),
                      Switch(value: value1,
                          onChanged:(bool newValue) {
                            setState(() {
                              value1 = newValue;
                            });
                          })
                    ],
                  ),
                  SizedBox(height: 0.5.h,),
                  DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                  Row(
                    children: [
                      Text("Bowling area",style: fontMedium.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColour,
                      ),),
                      Spacer(),
                      Switch(value: value2,
                          onChanged:(bool newValue) {
                            setState(() {
                              value2 = newValue;
                            });
                          })
                    ],
                  ),
                  SizedBox(height: 0.5.h,),
                  DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                  Row(
                    children: [
                      Text("Extras wide",style: fontMedium.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColour,
                      ),),
                      Spacer(),
                      Switch(value: value3,
                          onChanged:(bool newValue) {
                            setState(() {
                              value3 = newValue;
                            });
                          })
                    ],
                  ),
                  SizedBox(height: 0.5.h,),
                  DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                  Row(
                    children: [
                      Text("No ball run",style: fontMedium.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.blackColour,
                      ),),
                      Spacer(),
                      Switch(value: value4,
                          onChanged:(bool newValue) {
                            setState(() {
                              value4 = newValue;
                            });
                          })
                    ],
                  ),
                  SizedBox(height: 0.5.h,),
                  DottedLine(
                    dashColor: Color(0xffD2D2D2),
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
                            child: CancelBtn("Reset")),
                        SizedBox(width: 4.w,),
                        OkBtn("Save"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })
    );
  }

}
