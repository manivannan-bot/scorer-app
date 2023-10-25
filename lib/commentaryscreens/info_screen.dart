import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/commentaryscreens/playing_eleven_list_screen.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 6.w),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            color: AppColor.lightColor
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          SvgPicture.asset(Images.teamIcon,width: 6.w,),
                          SizedBox(width: 2.w,),
                          Text("Teams",style: fontMedium.copyWith(
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


              //playingx1
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => PlayingElevenListScreen()));
                },
                child: Text('Playing XI',style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.blackColour,
                ),),
              ),
              Divider(
                color: Color(0xffD3D3D3),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 0.5.h,bottom: 1.2.h),
                child: Row(
                  children: [
                    ClipOval(child: Image.asset(Images.profileImage,width: 14.w,)),
                    SizedBox(width: 5.w,),
                    Text('Dhoni CC',style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.blackColour,
                    ),),
                    Spacer(),
                    SvgPicture.asset(Images.arrowICon,width: 6.5.w,),

                  ],
                ),
              ),
              DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(top: 0.5.h,bottom: 1.2.h),
                child: Row(
                  children: [
                    ClipOval(child: Image.asset(Images.profileImage,width: 14.w,)),
                    SizedBox(width: 5.w,),
                    Text('Spartans',style: fontMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.blackColour,
                    ),),
                    Spacer(),
                    SvgPicture.asset(Images.arrowICon,width: 6.5.w,)

                  ],
                ),
              ),
              SizedBox(height: 2.h,),

         //headto head
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Head to Head',
                        style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.blackColour,
                        )),
                    TextSpan(
                        text: "(Last 10 matches)",
                        style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: Color(0xff666666)
                        )),
                  ])),
              SizedBox(height: 1.5.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffF8F9FA),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ClipOval(child: Image.asset(Images.profileImage,width: 16.w,)),
                        SizedBox(height: 0.5.h,),
                        Text('Dhoni CC',style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.blackColour,
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '0',
                                  style: fontMedium.copyWith(
                                    fontSize: 20.sp,
                                    color: AppColor.blackColour,
                                  )),
                              TextSpan(
                                  text: '-',
                                  style: fontMedium.copyWith(
                                    fontSize: 20.sp,
                                    color: AppColor.blackColour,
                                  )),
                              TextSpan(
                                  text: '0',
                                  style: fontMedium.copyWith(
                                    fontSize: 20.sp,
                                    color: AppColor.blackColour,
                                  )),


                            ])),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(child: Image.asset(Images.profileImage,width: 16.w,)),
                        SizedBox(height: 0.5.h,),
                        Text('Spartans',style: fontMedium.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.blackColour,
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),


           //professionals
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

    );
  }
}
