import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/Scoring%20screens/home_tab.dart';
import 'package:scorer/provider/scoring_provider.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/styles.dart';
import 'package:sizer/sizer.dart';

import '../commentaryscreens/sample_screen.dart';
import '../models/all_matches_model.dart';
import '../more/more_screen.dart';
import '../utils/images.dart';
import '../widgets/Individual_player_completed_list.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/dialog_others.dart';
import '../widgets/individual_player_upcoming_matches.dart';
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SampleScreen()));
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

  Future<void> _displayBottomSheetDoScoring (BuildContext context) async{
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return Container(
          height: 95.h,
            // padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: const BoxDecoration(
                color: AppColor.lightColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 4.w,)+EdgeInsets.only(top: 2.h,bottom: 0.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,size: 7.w,)),
                      Text("Match Preview",style: fontMedium.copyWith(
                        fontSize: 17.sp,
                        color: AppColor.blackColour,
                      ),),
                      SizedBox(width: 7.w,),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.h),
                    child: ListView(
                      children: [
                        SizedBox(height: 1.h,),
                        const Divider(
                          color: Color(0xffD3D3D3),
                        ),
                        Text("Teams",style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.blackColour,
                        ),),
                        SizedBox(height: 1.h,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  ClipOval(child: Image.asset(Images.teamPreviewlogoA,width: 20.w,)),
                                  SizedBox(height: 1.h,),
                                  Text("Toss & Tails",style: fontMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipOval(child: Image.asset(Images.teamPreviewlogoA,width: 20.w,)),
                                  SizedBox(height: 1.h,),
                                  Text("Toss & Tails",style: fontMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        Text("Match Information",style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.blackColour,
                        ),),
                        SizedBox(height: 2.h,),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffF8F9FA)
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Images.dateIcon,width: 6.w,),
                                    SizedBox(width: 2.w,),
                                    Text("Date",style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: Color(0xff666666),
                                    ),),
                                    Spacer(),
                                    Text("Aug 21, 2023 ",style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.blackColour,
                                    ),),
                                  ],
                                ),
                              ),
                              DottedLine(
                                dashColor: Color(0xffD2D2D2),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Images.clockIcon,width: 6.w,),
                                    SizedBox(width: 2.w,),
                                    Text("Slot",style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: Color(0xff666666),
                                    ),),
                                    Spacer(),
                                    Text("6:00 AM",style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.blackColour,
                                    ),),
                                  ],
                                ),
                              ),
                              DottedLine(
                                dashColor: Color(0xffD2D2D2),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Images.groundIcon,width: 6.w,),
                                    SizedBox(width: 2.w,),
                                    Text("Organizer & \nGround",style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: Color(0xff666666),
                                    ),),
                                    Spacer(),
                                    Text("JK Organizer \n Square out fighters"
                                      ,style: fontMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour,
                                      ),),
                                  ],
                                ),
                              ),
                              DottedLine(
                                dashColor: Color(0xffD2D2D2),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Images.locationsIcon,width: 6.w,),
                                    SizedBox(width: 2.w,),
                                    Text("Location",style: fontMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: Color(0xff666666),
                                    ),),
                                    Spacer(),
                                    Text("Chrompet"
                                      ,style: fontMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour,
                                      ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Text("Professionals",style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.blackColour,
                        ),),
                        SizedBox(height: 1.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text("Umpire 2",style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                  SizedBox(height: 1.h,),
                                  Container(
                                    width: 42.w,
                                    height: 16.h,
                                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xffF8F9FA),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(child: Image.asset(Images.umpireImage,width: 16.w,)),
                                        SizedBox(height: 0.5.h,),
                                        Text("ArunKumar",style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour,
                                        ),),
                                      ],
                                    ),

                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text("Umpire 2",style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                  SizedBox(height: 1.h,),
                                  Container(
                                    width: 42.w,
                                    height: 16.h,
                                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xffF8F9FA),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(child: Image.asset(Images.umpireImage,width: 16.w,)),
                                        SizedBox(height: 0.5.h,),
                                        Text("vinayagam\nMoorthy",style: fontMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour,
                                        ),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h,),
                        Column(
                          children: [
                            Text("Scorer",style: fontRegular.copyWith(
                              fontSize: 12.sp,
                              color: AppColor.blackColour,
                            ),),
                            SizedBox(height: 1.h,),
                            Container(
                              width: 42.w,
                              height: 16.h,
                              padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffF8F9FA),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(child: Image.asset(Images.umpireImage,width: 16.w,)),
                                  SizedBox(height: 0.5.h,),
                                  Text("ArunKumar",style: fontMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                ],
                              ),

                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffF8F9FA),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 4.w)+EdgeInsets.only(top: 1.5.h,bottom: 1.h),
                    child: Row(
                      children: [
                        Text('Match Details',style: fontRegular.copyWith(
                            fontSize: 14.sp,
                            color: Color(0xffD3810C)
                        ),),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 0.8.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.blackColour,
                          ),
                          child:  Text('Do Scoring',style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.lightColor,
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        })
    );
  }

}
