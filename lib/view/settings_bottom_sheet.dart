import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({super.key});

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {

  bool value1=false;
  bool value2=false;
  bool value3=false;
  bool value4=false;

  Future<int?> getScoringArea() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('fourOrSix')??0;
  }
  Future<int?> getBowlingArea() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('bowlingArea')??0;
  }
  Future<int?> getWideRun() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('wideRun')??0;
  }
  Future<int?> getNoBallRun() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('noBallRun')??0;
  }

  getData(){
    getScoringArea().then((val) {
      value1 = val == 1;
    });
    getBowlingArea().then((val) {
      value2 = val == 1;
    });
    getWideRun().then((val) {
      value3 = val == 1;
    });
    getNoBallRun().then((val) {
      value4 = val == 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
                const Spacer(),
                Switch(value: value1,
                    onChanged:(bool newValue) async{
                      SharedPreferences pref=await SharedPreferences.getInstance();
                      var isFourOrSix=pref.getInt('fourOrSix');
                      if(isFourOrSix==1){
                        await pref.setInt('fourOrSix',0);
                      }else{
                        await pref.setInt('fourOrSix',1);
                      }

                      setState(() {
                        value1 = newValue;
                      });
                    })
              ],
            ),
            SizedBox(height: 0.5.h,),
            const DottedLine(
              dashColor: Color(0xffD2D2D2),
            ),
            Row(
              children: [
                Text("Bowling area",style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.blackColour,
                ),),
                const Spacer(),
                Switch(value: value2,
                    onChanged:(bool newValue) async{
                      SharedPreferences pref=await SharedPreferences.getInstance();
                      var bowlingArea=pref.getInt('bowlingArea');
                      if(bowlingArea==1){
                        await pref.setInt('bowlingArea',0);
                      }else{
                        await pref.setInt('bowlingArea',1);
                      }
                      setState(() {
                        value2 = newValue;
                      });
                    })
              ],
            ),
            SizedBox(height: 0.5.h,),
            const DottedLine(
              dashColor: Color(0xffD2D2D2),
            ),
            Row(
              children: [
                Text("Extras wide",style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.blackColour,
                ),),
                const Spacer(),
                Switch(value: value3,
                    onChanged:(bool newValue) async{
                      SharedPreferences pref=await SharedPreferences.getInstance();
                      var extraWide=pref.getInt('wideRun');
                      if(extraWide==1){
                        await pref.setInt('wideRun',0);
                      }else{
                        await pref.setInt('wideRun',1);
                      }
                      setState(() {
                        value3 = newValue;
                      });
                    })
              ],
            ),
            SizedBox(height: 0.5.h,),
            const DottedLine(
              dashColor: Color(0xffD2D2D2),
            ),
            Row(
              children: [
                Text("No ball run",style: fontMedium.copyWith(
                  fontSize: 14.sp,
                  color: AppColor.blackColour,
                ),),
                const Spacer(),
                Switch(value: value4,
                    onChanged:(bool newValue) async{
                      SharedPreferences pref=await SharedPreferences.getInstance();
                      var noballRun=pref.getInt('noBallRun');
                      if(noballRun==1){
                        await pref.setInt('noBallRun',0);
                      }else{
                        await pref.setInt('noBallRun',1);
                      }
                      setState(() {
                        value4 = newValue;
                      });
                    })
              ],
            ),
            SizedBox(height: 0.5.h,),
            const DottedLine(
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
                      child: const CancelBtn("Reset")),
                  SizedBox(width: 4.w,),
                  GestureDetector(onTap:(){
                    Navigator.pop(context);
                  },
                      child: const OkBtn("Save")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
