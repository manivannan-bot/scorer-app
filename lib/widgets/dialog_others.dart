import 'package:flutter/material.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:sizer/sizer.dart';

import '../out_screens/keeper_injury.dart';
import '../out_screens/obstruct_field_screen.dart';
import '../utils/sizes.dart';
import 'ok_btn.dart';


//match break
class DialogsOthers extends StatefulWidget {
  const DialogsOthers({super.key});

  @override
  State<DialogsOthers> createState() => _DialogsOthersState();
}

class _DialogsOthersState extends State<DialogsOthers> {
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': "Drinks",
    },
    {
      'label': 'Strategic timeout',
    },
    {
      'label': 'Lunch',
    },
    {
      'label': 'Stumps',
    },
    {
      'label': 'Other',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
        height: 28.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //   )
          // ],
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        isWideSelected=index;
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
                      backgroundColor: isWideSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
                      // backgroundColor:AppColor.lightColor
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 1.5.h,),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: CancelBtn("cancel")),
                  SizedBox(width: 4.w,),
                  OkBtn("ok"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

//change target
class ChangeTargetDialog extends StatefulWidget {
  const ChangeTargetDialog({super.key});

  @override
  State<ChangeTargetDialog> createState() => _ChangeTargetDialogState();
}

class _ChangeTargetDialogState extends State<ChangeTargetDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        height: 20.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //   )
          // ],
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Change Target",style: fontMedium.copyWith(
                fontSize: 17.sp,
                color: AppColor.blackColour,
              ),),
            ),
            SizedBox(height: 2.h,),
            Text("Target can be changed only after the first innings",style: fontRegular.copyWith(
              fontSize: 11.sp,
              color: Color(0xff808080)
            ),),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OkBtn("ok"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//D/L method

class DlMethodDialog extends StatefulWidget {
  const DlMethodDialog({super.key});

  @override
  State<DlMethodDialog> createState() => _DlMethodDialogState();
}

class _DlMethodDialogState extends State<DlMethodDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        height: 40.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //   )
          // ],
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("D/L Method",style: fontMedium.copyWith(
                fontSize: 17.sp,
                color: AppColor.blackColour,
              ),),
            ),
            SizedBox(height: 2.h,),
            Text("Enter over and target runs",style: fontRegular.copyWith(
                fontSize: 11.sp,
                color: Color(0xff808080)
            ),),
            SizedBox(height: 2.h,),
            Text(" Overs",style: fontMedium.copyWith(
                fontSize: 12.sp,
                color: AppColor.blackColour,
            ),),
            SizedBox(height: 1.h,),
            Container(
              height: 5.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffF8F9FA),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.0.h),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,// Label text
                  // Hint text
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Text(" Target runs",style: fontMedium.copyWith(
              fontSize: 12.sp,
              color: AppColor.blackColour,
            ),),
            SizedBox(height: 1.h,),
            Container(
              height: 5.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffF8F9FA),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.0.h),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,// Label text
                    // Hint text
                  ),
                ),
              ),
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
                      child: CancelBtn("cancel")),
                  SizedBox(width: 4.w,),
                  OkBtn("ok"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//changekeeper
class ChangeKeeper extends StatefulWidget {
  const ChangeKeeper({super.key});

  @override
  State<ChangeKeeper> createState() => _ChangeKeeperState();
}

class _ChangeKeeperState extends State<ChangeKeeper> {
  int? keeperSelected ;
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
        height: 25.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //   )
          // ],
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Change  Keeper",style: fontMedium.copyWith(
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
                      if (data['label'] == "Injury" ){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => keeperInjury()));
                      }
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
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: CancelBtn("cancel")),
                  SizedBox(width: 4.w,),
                  OkBtn("ok"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


