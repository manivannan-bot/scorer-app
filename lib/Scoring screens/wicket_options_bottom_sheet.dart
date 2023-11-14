import 'package:flutter/material.dart';
import 'package:scorer/Scoring%20screens/retired_screen.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:sizer/sizer.dart';

import '../out_screens/caught_out_screen.dart';
import '../out_screens/obstruct_field_screen.dart';
import '../out_screens/out_method_dialog.dart';
import '../out_screens/retired _hurt_screen.dart';
import '../out_screens/run_out_screens.dart';
import '../out_screens/timeout_absence.dart';
import '../utils/colours.dart';
import '../utils/sizes.dart';

class WicketOptionsBottomSheet extends StatefulWidget {
  final ScoringDetailResponseModel? scoringData;
  final VoidCallback refresh;
  const WicketOptionsBottomSheet(this.scoringData, this.refresh, {super.key});

  @override
  State<WicketOptionsBottomSheet> createState() => _WicketOptionsBottomSheetState();
}

class _WicketOptionsBottomSheetState extends State<WicketOptionsBottomSheet> {

  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    { 'id':15,
      'label': "Bowled",
      'who' : "striker"
    },
    { 'id':32,
      'label': 'Caught',
      'who' : "striker"
    },
    { 'id':16,
      'label': 'Stumped',
      'who' : "striker"
    },
    { 'id':17,
      'label': 'LBW',
      'who' : "striker"
    },
    {  'id':18,
      'label': 'Caught Behind',
      'who' : "striker"
    },
    { 'id':19,
      'label': 'Caught & Bowled',
      'who' : "striker"
    },
    { 'id':20,
      'label': ' Run Out',
      'who' : "both"
    },
    {  'id':21,
      'label': 'Run out (Mankaded)',
      'who' : "non-striker"
    },
    { 'id':22,
      'label': 'Retired Hurt',
      'who' : "both"
    },
    { 'id':23,
      'label': 'Hit Wicket',
      'who' : "striker"
    },
    { 'id':24,
      'label': 'Retired',
      'who' : "both"
    },
    { 'id':25,
      'label': 'Retired Out',
      'who' : "both"
    },
    { 'id':26,
      'label': 'Handling the Ball',
      'who' : "both"
    },
    { 'id':27,
      'label': 'Hit the Ball Twice',
      'who' : "striker"
    },
    { 'id':28,
      'label': 'Obstruct the field',
      'who' : "both"
    },
    { 'id':30,
      'label': 'Timed Out',
      'who' : "both"
    },
    { 'id':29,
      'label': 'Absence Hurt',
      'who' : "both"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w,)+EdgeInsets.only(top: 2.h,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back,size: 7.w,)),
                Text("Select out method",style: fontMedium.copyWith(
                  fontSize: 17.sp,
                  color: AppColor.blackColour,
                ),),
                SizedBox(width: 7.w,),
              ],
            ),
          ),
          SizedBox(height: 1.h,),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 1.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Wrap(
              spacing: 3.w,
              runSpacing: 1.h,
              alignment: WrapAlignment.center,
              children:chipData.map((data) {
                final index = chipData.indexOf(data);
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      isWideSelected=index;
                    });
                    if (data['label'] == 'Bowled'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'Bowled', id: data['id'], scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == 'LBW'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'LBW',id: data['id'],scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == 'Caught Behind'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'Caught Behind',id: data['id'],scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == 'Caught & Bowled'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'Caught & Bowled',id: data['id'],scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == 'Run out (Mankaded)'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'Mankaded',id: data['id'],scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == 'Hit Wicket'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'Hit Wicket',id: data['id'],scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == 'Handling the Ball'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'Handling the Ball',id: data['id'],scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == 'Hit the Ball Twice'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'Hit the Ball Twice',id: data['id'],scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == 'Stumped'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return OutMethodDialog(label: 'Stumped',id: data['id'],scoringData: widget.scoringData!, refresh: widget.refresh, who: data['who']);
                        },
                      );
                    }
                    if (data['label'] == ' Run Out'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RunOutScreen(ballType:data['id'],scoringData: widget.scoringData!)));
                    }
                    if (data['label'] == 'Caught'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CaughtOutScreen(ballType:data['id'],scoringData: widget.scoringData!, refresh: widget.refresh)));
                    }
                    if (data['label'] == 'Retired Hurt'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RetiredHurtScreen(label: 'Retired Hurt', checkcount: "Don't count the ball",ballType:data['id'],scoringData: widget.scoringData!,)));
                    }
                    if (data['label'] == 'Retired Out'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RetiredHurtScreen(label: 'Retired Out', checkcount: "Don't count the ball",ballType:data['id'],scoringData: widget.scoringData!,)));
                    }
                    if (data['label'] == 'Timed Out'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TimeOutAbsence(label: 'Timed out',ballType:data['id'],scoringData: widget.scoringData!, )));
                    }
                    if (data['label'] == 'Absence Hurt'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TimeOutAbsence(label: 'Absence hurt',ballType:data['id'],scoringData: widget.scoringData!,)));
                    }
                    if (data['label'] == 'Retired'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RetiredScreens(ballType:data['id'],scoringData: widget.scoringData!,)));
                    }
                    if (data['label'] == 'Obstruct the field' ){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ObstructTheField(ballType:data['id'],scoringData: widget.scoringData!,)));
                    }

                  },
                  child: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 0.8.h),
                    label: Text(data['label'],style: fontMedium.copyWith(
                        fontSize: 11.sp,
                        color: AppColor.textColor
                    ),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: const BorderSide(
                        width: 0.5,
                        color: Color(0xffDADADA),
                      ),
                    ),
                    backgroundColor: isWideSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
                    // backgroundColor:AppColor.lightColor
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
