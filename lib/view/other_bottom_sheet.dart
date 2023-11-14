import 'package:flutter/material.dart';
import 'package:scorer/view/settings_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../utils/colours.dart';
import '../utils/sizes.dart';
import '../widgets/dialog_others.dart';

class OtherBottomSheet extends StatefulWidget {
  final String matchId, team1Id, team2Id;
  const OtherBottomSheet(this.matchId, this.team1Id, this.team2Id, {super.key});

  @override
  State<OtherBottomSheet> createState() => _OtherBottomSheetState();
}

class _OtherBottomSheetState extends State<OtherBottomSheet> {

  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': "Match break",
    },
    {
      'label': 'Settings',
    },
    {
      'label': 'End Innings',
    },
    {
      'label': 'D/L Method',
    },
    {
      'label': 'Change keeper',
    },
    {
      'label': 'Abandon',
    },
    // {
    //   'label': 'Change target',
    // },
    // {
    //   'label': 'Change Batsman',
    // },

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      // padding: EdgeInsets.symmetric(horizontal: 2.w),
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
                Text("Other",style: fontMedium.copyWith(
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
            padding:  EdgeInsets.only(left: 2.w,right: 2.w),
            child: Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              alignment: WrapAlignment.center,
              children:chipData.map((data) {
                final index = chipData.indexOf(data);
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      isWideSelected=index;
                    });
                    if (data['label'] == 'End Innings'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EndInnings(widget.matchId);
                        },
                      ).whenComplete(() {
                        Navigator.pop(context);
                      });
                    }
                    if (data['label'] == 'Match break'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogsOthers(widget.matchId,widget.team1Id,widget.team2Id);
                        },
                      ).whenComplete(() {
                        Navigator.pop(context);
                      });
                    }
                    if (data['label'] == 'Change keeper'){

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ChangeKeeper(widget.matchId,widget.team2Id);
                        },
                      );
                    }
                    // if (data['label'] == 'Change target'){
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return ChangeTargetDialog();
                    //     },
                    //   );
                    // }
                    if (data['label'] == 'D/L Method'){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DlMethodDialog(widget.matchId);
                        },
                      );
                    }
                    if (data['label'] == 'Settings'){
                      _displayBottomSheetSettings();
                    }
                    if (data['label'] == 'Change Batsman'){
                      // String player=(value.data!.strikerId==0)?'striker_id':'non_striker_id';
                      // changeBatsman(player);
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

  Future<void> _displayBottomSheetSettings () async{
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return const SettingsBottomSheet();
        })
    );
  }
}


