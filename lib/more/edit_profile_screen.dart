import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(Images.playerDetailBg,),
              SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,color: AppColor.lightColor,)),
                    Column(
                      children: [
                        Image.asset(Images.playersImage,width: 30.w,),
                        Text('Murugaprasanth',
                          style: fontMedium.copyWith(fontSize: 15.sp,color: AppColor.lightColor),),
                      ],
                    ),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 0.5.h,),
            ],
          ),
          SizedBox(height: 2.h,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                  color: AppColor.lightColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Profile Information",style: fontMedium.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(height: 1.h,),
                  Divider(
                    color: Color(0xffCCC6C6),
                  ),
                  SizedBox(height: 1.h,),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true, // Remove top system padding (status bar)
                      removeBottom: true,
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //name
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ('Name'),
                                        style: fontRegular.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour,
                                        )),
                                    TextSpan(
                                        text: "*",
                                        style: fontMedium.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColor.blackColour
                                        )),

                                  ])),
                              SizedBox(height: 0.5.h,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                                decoration: BoxDecoration(
                                  color: Color(0xffF8F9FA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none, // Removes the border line
                                    hintText: 'Enter text here',
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h,),
                              //phone number
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ('Phone Number'),
                                        style: fontRegular.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour,
                                        )),
                                    TextSpan(
                                        text: "*",
                                        style: fontMedium.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColor.blackColour
                                        )),

                                  ])),
                              SizedBox(height: 0.5.h,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                                decoration: BoxDecoration(
                                  color: Color(0xffF8F9FA),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none, // Removes the border line
                                    hintText: 'Enter text here',
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h,),
                              //Date of birth
                              Row(
                                children: [
                                  Text("Date of birth",style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColor.blackColour,
                                  ),),
                                  Spacer(),
                                  Text("(Optional)",style: fontRegular.copyWith(
                                    fontSize: 12.sp,
                                    color: Color(0xff737373),
                                  ),),
                                ],
                              ),
                              SizedBox(height: 0.5.h,),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F9FA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("Select a date",style: fontRegular.copyWith(
                                            fontSize: 12.sp,
                                            color: Color(0xff666666)
                                        ),),
                                      ),
                                      SvgPicture.asset(Images.stupmsIconss)
                                    ],
                                  )
                              ),
                              SizedBox(height: 1.h,),
                              //Location
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ('Location'),
                                        style: fontRegular.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour,
                                        )),
                                    TextSpan(
                                        text: "*",
                                        style: fontMedium.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColor.blackColour
                                        )),

                                  ])),
                              SizedBox(height: 0.5.h,),
                              Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F9FA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text("Medavakkam",style: fontRegular.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.blackColour
                                  ),)
                              ),
                              SizedBox(height: 1.h,),
                              //state
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ('State'),
                                        style: fontRegular.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour,
                                        )),
                                    TextSpan(
                                        text: "*",
                                        style: fontMedium.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColor.blackColour
                                        )),

                                  ])),
                              SizedBox(height: 0.5.h,),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F9FA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("Tamil nadu",style: fontRegular.copyWith(
                                            fontSize: 12.sp,
                                            color: Color(0xff666666)
                                        ),),
                                      ),
                                      Icon(Icons.keyboard_arrow_down, color: const Color(0xff8E8E8E), size: 6.w,)
                                    ],
                                  )
                              ),
                              SizedBox(height: 1.h,),
                              //city
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ('City'),
                                        style: fontRegular.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour,
                                        )),
                                    TextSpan(
                                        text: "*",
                                        style: fontMedium.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColor.blackColour
                                        )),

                                  ])),
                              SizedBox(height: 0.5.h,),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F9FA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text("Chennai",style: fontRegular.copyWith(
                                            fontSize: 12.sp,
                                            color: Color(0xff666666)
                                        ),),
                                      ),
                                      Icon(Icons.keyboard_arrow_down, color: const Color(0xff8E8E8E), size: 6.w,)
                                    ],
                                  )
                              ),
                              SizedBox(height: 1.h,),
                              //pincode
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Pincode',
                                        style: fontRegular.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColor.blackColour,
                                        )),
                                    TextSpan(
                                        text: "*",
                                        style: fontMedium.copyWith(
                                            fontSize: 14.sp,
                                            color: AppColor.blackColour
                                        )),

                                  ])),
                              SizedBox(height: 0.5.h,),
                              Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F9FA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text("600100",style: fontRegular.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.blackColour
                                  ),)
                              ),
                              SizedBox(height: 1.h,),
                            ],

                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  

                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
            color: AppColor.lightColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CancelBtn("Reset"),
                SizedBox(width: 5.w,),
                OkBtn("Save")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
