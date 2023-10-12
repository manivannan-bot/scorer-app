import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';


class RetiredHurtScreen extends StatefulWidget {
  const RetiredHurtScreen({super.key});

  @override
  State<RetiredHurtScreen> createState() => _RetiredHurtScreenState();
}

class _RetiredHurtScreenState extends State<RetiredHurtScreen> {
  int? isSelected=0;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF8F9FA),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w)+EdgeInsets.only(top: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,size: 7.w,)),
                  Text("Retired Hurt",style: fontMedium.copyWith(
                    fontSize: 17.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(width: 7.w,),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: ListView(
                  children: [
                    SizedBox(height: 2.h,),
                    Container(
                      // padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 0.h),
                            child: Text("Select the batsman*",style: fontMedium.copyWith(
                              fontSize: 14.sp,
                              color: AppColor.blackColour,
                            ),),
                          ),
                          SizedBox(height: 1.5.h,),
                          Padding(
                            padding:EdgeInsets.only(left: 6.w,right: 4.w,top: 0.h,bottom: 2.5.h),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isSelected =1;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal:8.w,vertical: 2.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffDFDFDF)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: ( isSelected ==1)?AppColor.primaryColor:AppColor.lightColor,

                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(Images.playerImg,width: 20.w,),
                                        SizedBox(height: 1.h,),
                                        Text("Pandi",style: fontMedium.copyWith(
                                          fontSize: 17.sp,
                                          color: AppColor.blackColour,
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {

                                      isSelected =2;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal:8.w,vertical: 2.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffDFDFDF)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: ( isSelected ==2)?AppColor.primaryColor:AppColor.lightColor,

                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(Images.playerImg,width: 20.w,),
                                        SizedBox(height: 1.h,),
                                        Text("Pandi",style: fontMedium.copyWith(
                                          fontSize: 17.sp,
                                          color: AppColor.blackColour,
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.blackColour,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                            ),
                             child: Row(
                             children: <Widget>[
                               Theme(
                                 data: ThemeData(
                                   unselectedWidgetColor: Color(0xffFBC041), // Change color here
                                 ),
                                 child: Checkbox(
                              value: isChecked,
                              onChanged: ( value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                              },
                          ),
                               ),
                                Text("Don’t count the ball",style: fontRegular.copyWith(
                                 fontSize: 12.sp,
                                 color: AppColor.lightColor,
                               ),),

                        ],
                      ),
                           ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.lightColor
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CancelBtn("Cancel"),
                    SizedBox(width: 4.w,),
                    OkBtn("Ok"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
