import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';


class keeperInjury extends StatefulWidget {
  const keeperInjury({super.key});

  @override
  State<keeperInjury> createState() => _keeperInjuryState();
}

class _keeperInjuryState extends State<keeperInjury> {
  int? keeperSelected = 0 ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': "Injury",
    },
    {
      'label': 'Other',
    },

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  Text("Change keeper",style: fontMedium.copyWith(
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
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
                      decoration: BoxDecoration(
                        color: AppColor.lightColor,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //   )
                        // ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Reason*",style: fontMedium.copyWith(
                            fontSize: 16.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 0.w,right: 0.w),
                            child: Wrap(
                              spacing: 3.w, // Horizontal spacing between items
                              runSpacing: 1.h, // Vertical spacing between lines
                              alignment: WrapAlignment.center, // Alignment of items
                              children:chipData.map((data) {
                                final index = chipData.indexOf(data);
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      keeperSelected=index;
                                    });
                                  },
                                  child: Chip(
                                    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.8.h),
                                    label: Text(data['label'],style: fontSemiBold.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour
                                    ),),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      side: const BorderSide(
                                        color: Color(0xffDADADA),
                                      ),
                                    ),
                                    backgroundColor: keeperSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                                    // backgroundColor:AppColor.lightColor
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select the Keeper*",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.5.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 10.w),
                            child: Container(
                              height: 7.h,
                              width: 14.w,
                              decoration: BoxDecoration(
                                border: RDottedLineBorder.all(
                                  color: Color(0xffCCCCCC),
                                  width: 1,
                                ),
                                color: Color(0xffF8F9FA),
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: 2.h,bottom: 0.h),
                                    child: SvgPicture.asset(Images.plusIcon,width: 5.w,),
                                  ),
                                  SizedBox(height: 2.h,),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 1.5.h,),
                          Text("Select the Keeper",style: fontRegular.copyWith(
                            fontSize: 13.sp,
                            color: AppColor.blackColour,
                          ),),
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
