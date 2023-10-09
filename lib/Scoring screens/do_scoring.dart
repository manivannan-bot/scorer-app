import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/styles.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:scorer/widgets/stricker%20container.dart';
import 'package:sizer/sizer.dart';

import '../utils/images.dart';


class DOScoring extends StatefulWidget {
  const DOScoring({super.key});

  @override
  State<DOScoring> createState() => _DOScoringState();
}

class _DOScoringState extends State<DOScoring> {
  final List<Map<String,dynamic>>itemList=[
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back,size: 7.w,)),
                  Text("Start Innings",style: fontMedium.copyWith(
                    fontSize: 18.sp,
                    color: AppColor.blackColour,
                  ),),
                 SizedBox(width: 7.w,),
                ],
              ),
            ),
            SizedBox(height: 4.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w,)+EdgeInsets.only(top: 2.h,bottom: 3.h),
                decoration: BoxDecoration(
                 color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Batsman*",style: fontMedium.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                       GestureDetector(
                         onTap:(){
                           _displayBottomSheet (context);
                         },
                           child: ChooseContainer("Stricker")),
                        SizedBox(width: 8.w,),
                        ChooseContainer("Non-Stricker"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w,)+EdgeInsets.only(top: 2.h,bottom: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Bowler*",style: fontMedium.copyWith(
                          fontSize: 16.sp,
                          color: AppColor.blackColour,
                        ),),
                      SizedBox(width: 15.w,),
                        Text("Wicket Keeper*",style: fontMedium.copyWith(
                          fontSize: 16.sp,
                          color: AppColor.blackColour,
                        ),),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Row(
                      children: [
                        ChooseContainer("Bowler"),
                        SizedBox(width: 8.w,),
                        ChooseContainer("Wicket Keeper"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            //cancel bt
             Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
              decoration: BoxDecoration(
                color: AppColor.lightColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 CancelBtn("Cancel"),
                SizedBox(width: 2.w,),
                OkBtn("Ok"),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<void> _displayBottomSheet (BuildContext context) async{
    int? selectedIndex; // Store the selected item index
    List<String> items = [
      'Item 1',
      'Item 1',
    ];
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> Container(
          height: 90.h,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
              color: AppColor.lightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,size: 7.w,)),
                    Text("Select next batsman",style: fontMedium.copyWith(
                      fontSize: 18.sp,
                      color: AppColor.blackColour,
                    ),),
                    SizedBox(width: 7.w,),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              Divider(
                thickness: 1,
                color: Color(0xffD3D3D3),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffF8F9FA),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.2.h),
                    child: Row(
                      children: [
                        Text("Search players",style: fontRegular.copyWith(
                          fontSize: 12.sp,
                          color: Color(0xff707B81),
                        ),),
                        Spacer(),
                        SvgPicture.asset(Images.searchIcon)
                      ],

                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
                child: Text("Dhoni CC players",style: fontMedium.copyWith(
                  fontSize:14.sp,
                  color: AppColor.pri
                ),),
              ),
              // Divider(
              //   color: Color(0xffD3D3D3),
              // ),
              Divider(
                thickness: 1,
                color: Color(0xffD3D3D3),
              ),
              Expanded(
                child:   ListView.separated(
                  separatorBuilder:(context ,_) {
                    return const Divider(
                      thickness: 0.6,
                    );
                  },
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final itemTitle = items[index];
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: ListTile(
                        title: Row(
                          children: [
                            Radio(
                              value: index,
                              groupValue: selectedIndex,
                              onChanged: (value) {
                                setState(() {
                                  selectedIndex = value as int?;
                                });
                              },
                            ),
                            Image.asset(Images.playersImage,width: 10.w,),
                            SizedBox(width: 2.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Vicky",style: fontMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                                Row(
                                  children: [
                                    Container(
                                      height:1.h,
                                      width: 2.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColor.pri,
                                      ),
                                    ),
                                    SizedBox(width: 2.w,),
                                    Text("Right hand batsman",style: fontMedium.copyWith(
                                        fontSize: 11.sp,
                                        color: Color(0xff555555)
                                    ),),
                                  ],
                                ),

                              ],
                            ),
                            Spacer(),
                            Row(
                              children: [
                               Text("25 ",style: fontRegular.copyWith(
                                 fontSize: 11.sp,
                                 color: AppColor.blackColour,
                               ),),
                                Text("(10) ",style: fontRegular.copyWith(
                                  fontSize: 11.sp,
                                  color: AppColor.blackColour,
                                ),)
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CancelBtn("Cancel"),
                    SizedBox(width: 2.w,),
                    OkBtn("Ok"),
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }


}
