import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';


class keeperInjury extends StatefulWidget {
  final String matchId;
  final String teamId;
  final int changeReason;
  const keeperInjury(this.matchId, this.teamId, this.changeReason,{super.key});

  @override
  State<keeperInjury> createState() => _keeperInjuryState();
}

class _keeperInjuryState extends State<keeperInjury> {
  int? keeperSelected = 0 ;
  List<WkPlayers>? itemsKeeper= [];
  String? selectedBTeamName ="";
  int? selectedWicketKeeper;
  String selectedWicketKeeperName = "";

  bool showError=false;
  List<Map<String, dynamic>> chipData =[
    {
      'label': "Injury",
    },
    {
      'label': 'Other',
    },

  ];
  @override
  void initState() {
    super.initState();
    keeperSelected=widget.changeReason;
    //_fetchPlayers(widget.matchId, widget.teamId);
  }


  Future<void> _fetchPlayers(String matchId, String teamId) async {
    try {
      final response = await ScoringProvider().getPlayerList(matchId, teamId,'wk');
      setState(() {
        itemsKeeper = response.wkPlayers;
        selectedBTeamName= response.team!.teamName;

      });
    } catch (error) {
    }
  }
  @override
  Widget build(BuildContext context) {
    showError=false;
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
                            child: GestureDetector(onTap:(){
                              _fetchPlayers(widget.matchId,widget.teamId);
                              _displayKeeperBottomSheet (context,selectedWicketKeeper,(bowlerIndex) async{

                                setState(() {
                                  selectedWicketKeeper = bowlerIndex;
                                  if (selectedWicketKeeper != null) {
                                    selectedWicketKeeperName = itemsKeeper![selectedWicketKeeper!].playerName ?? "";
                                  }
                                });

                              });
                            },
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

  _displayKeeperBottomSheet (BuildContext context, int? selectedBowler,Function(int?) onItemSelected) async{
    int? localBowlerIndex =selectedBowler;
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(
          builder: (context, setState) {
            return Container(
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
                        Text("Select Keeper",style: fontMedium.copyWith(
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
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text('${selectedBTeamName}',style: fontMedium.copyWith(
                        fontSize:14.sp,
                        color: AppColor.pri
                    ),),
                  ),
                  // Divider(
                  //   color: Color(0xffD3D3D3),
                  // ),
                  Divider(
                    thickness: 0.5,
                    color: Color(0xffD3D3D3),
                  ),
                  Expanded(
                    child:   ListView.separated(
                      separatorBuilder:(context ,_) {
                        return const Divider(
                          thickness: 0.6,
                        );
                      },
                      itemCount: itemsKeeper!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (localBowlerIndex  == index) {
                                localBowlerIndex  = null; // Deselect the item if it's already selected
                              } else {
                                localBowlerIndex  = index; // Select the item if it's not selected
                              }
                              onItemSelected(localBowlerIndex);
                            });
                          },
                          child:Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.5.w,vertical: 1.h),
                            child: Row(
                              children: [
                                //circular button
                                Container(
                                  height: 20.0, // Adjust the height as needed
                                  width: 20.0,  // Adjust the width as needed
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: localBowlerIndex  == index ? Colors.blue : Colors.grey, // Change colors based on selected index
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.circle_outlined, // You can change the icon as needed
                                      color: Colors.white, // Icon color
                                      size: 20.0, // Icon size
                                    ),
                                  ),
                                ), SizedBox(width: 3.w,),
                                Image.asset(Images.playersImage,width: 10.w,),
                                SizedBox(width: 2.w,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${itemsKeeper![index].playerName??'-'}",style: fontMedium.copyWith(
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
                                        Text(itemsKeeper![index].battingStyle??'-',style: fontMedium.copyWith(
                                            fontSize: 11.sp,
                                            color: Color(0xff555555)
                                        ),),
                                      ],
                                    ),

                                  ],
                                ),
                                Spacer(),
                                // Row(
                                //   children: [
                                //     Text("25 ",style: fontRegular.copyWith(
                                //       fontSize: 11.sp,
                                //       color: AppColor.blackColour,
                                //     ),),
                                //     Text("(10) ",style: fontRegular.copyWith(
                                //       fontSize: 11.sp,
                                //       color: AppColor.blackColour,
                                //     ),)
                                //   ],
                                // )
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
                        Visibility(
                          visible: showError,
                          child: Text(
                            'Please Select a Player',
                            style: fontMedium.copyWith(color: AppColor.redColor),
                          ),
                        ),
                        GestureDetector(onTap:(){
                          Navigator.pop(context);
                        },child: CancelBtn("Cancel")),
                        SizedBox(width: 2.w,),
                        GestureDetector(onTap:()async {

                          if(localBowlerIndex!=null){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('wicket_keeper_id', itemsKeeper![localBowlerIndex!].playerId!);
                            Navigator.pop(context);
                          }else{

                            setState(() {showError = true;});
                            Timer(Duration(seconds: 4), () {setState(() {showError = false;});});

                          }

                        },child: OkBtn("Ok")),
                      ],
                    ),
                  ),

                ],
              ),
            );},
        )
    );
  }
}
