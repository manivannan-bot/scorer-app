import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/styles.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:scorer/widgets/stricker%20container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../models/save_batsman_request_model.dart';
import '../pages/score_update_screen.dart';
import '../provider/scoring_provider.dart';
import '../utils/images.dart';


class DOScoring extends StatefulWidget {
  final String matchId; // Add matchId as a parameter
  final String team1id;
  final String team2id;// Add team1id as a parameter
  const DOScoring(this.matchId, this.team1id, this.team2id, {super.key});

  @override
  State<DOScoring> createState() => _DOScoringState();
}

class _DOScoringState extends State<DOScoring> {
  List<BattingPlayers>? items = [];
  List<BowlingPlayers>? itemsBowler= [];
  List<WkPlayers>? itemsKeeper= [];
  int? selectedIndex;
  int? selectedBowler;
  int? selectedWicketKeeper;
  int? player2Index;
  String selectedPlayerName = "";
  String? selectedTeamName ="";
  String? selectedBTeamName ="";
  String selectedBowlerName = "";
  String? selectedPlayer2Name='';
  String selectedWicketKeeperName = "";
  bool showError=false;

  @override
  void initState() {
    super.initState();
    selectedIndex = null;
    selectedBowler=null;
    player2Index=null;
    selectedWicketKeeper=null;
    _fetchPlayers(widget.matchId, widget.team1id,widget.team2id);
  }

  Future<void> _fetchPlayers(String matchId, String team1id,String team2id) async {
    try {
      final response = await ScoringProvider().getPlayerList(matchId, team1id,'bat');
      setState(() {
        items = response.battingPlayers;
        selectedTeamName= response.team!.teamName;

      });

    } catch (error) {
      // Handle any errors here
    }

    try {
      final response = await ScoringProvider().getPlayerList(matchId, team2id,'bowl');
      setState(() {
        itemsBowler = response.bowlingPlayers;
        selectedBTeamName= response.team!.teamName;

      });
    } catch (error) {
    }

    try {
      final response = await ScoringProvider().getPlayerList(matchId, team2id,'wk');
      setState(() {
        itemsKeeper = response.wkPlayers;
        selectedBTeamName= response.team!.teamName;

      });
    } catch (error) {
    }
  }

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
                           _displayBottomSheet (context,selectedIndex,(newIndex) async{

                             setState(() {
                               selectedIndex = newIndex;
                               if (selectedIndex != null) {

                                 selectedPlayerName = items![selectedIndex!].name ?? "";
                               }
                             });
                             SharedPreferences prefs = await SharedPreferences.getInstance();
                             await prefs.setInt('striker_id', items![selectedIndex!].playerId!);
                           });

                         },
                           child: ChooseContainer(selectedIndex != null
                               ? selectedPlayerName : "Striker")),
                        SizedBox(width: 8.w,),
                        GestureDetector(
                            onTap:(){
                              _displayPlayer2BottomSheet (context,player2Index,(newIndex) async{

                                setState(() {
                                  player2Index = newIndex;
                                  if (player2Index != null) {

                                    selectedPlayer2Name = items![player2Index!].name ?? "";
                                  }
                                });

                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setInt('non_striker_id', items![player2Index!].playerId!);
                              });

                            },
                            child: ChooseContainer(player2Index==null?"Non-Stricker":selectedPlayer2Name!)),
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
                        GestureDetector(
                            onTap:(){
                              _displayBowlerBottomSheet (context,selectedBowler,(bowlerIndex) async{

                                setState(() {
                                  selectedBowler = bowlerIndex;
                                  if (selectedBowler != null) {

                                    selectedBowlerName = itemsBowler![selectedBowler!].name ?? "";
                                  }
                                });
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setInt('bowler_id', itemsBowler![selectedBowler!].playerId!);
                              });
                            },
                            child: ChooseContainer(selectedBowler==null?"Bowler":selectedBowlerName)),
                        SizedBox(width: 8.w,),
                        GestureDetector(
                          onTap:(){

                            _displayKeeperBottomSheet (context,selectedWicketKeeper,(bowlerIndex) async{

                              setState(() {
                                selectedWicketKeeper = bowlerIndex;
                                if (selectedWicketKeeper != null) {
                                  selectedWicketKeeperName = itemsKeeper![selectedWicketKeeper!].name ?? "";
                                }
                              });

                            });
                          },
                            child: ChooseContainer(selectedWicketKeeper==null?"Wicket Keeper":selectedWicketKeeperName)),
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
                GestureDetector(
                    child: OkBtn("Ok"),
                onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ScoreUpdateScreen(widget.matchId,widget.team1id)));
            }),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }




   _displayBottomSheet (BuildContext context, int? initialSelectedIndex,Function(int?) onItemSelected) async{
     int? localSelectedIndex = initialSelectedIndex;
     showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(
          builder: (context, setState) {
            return Container(
            height: 90.h,
            padding: EdgeInsets.symmetric(vertical: 2.h),
            decoration: const BoxDecoration(
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
                      Text("Select Players",style: fontMedium.copyWith(
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
                  child: Text('${selectedTeamName}',style: fontMedium.copyWith(
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
                    itemCount: items!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (localSelectedIndex  == index) {
                              localSelectedIndex  = null; // Deselect the item if it's already selected
                            } else {
                              localSelectedIndex  = index; // Select the item if it's not selected
                            }
                            onItemSelected(localSelectedIndex);
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
                                  color: localSelectedIndex  == index ? Colors.blue : Colors.grey, // Change colors based on selected index
                                ),
                                child:  Center(
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
                                  Text("${items![index].name??'-'}",style: fontMedium.copyWith(
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
                                      Text(items![index].playingStyle??'-',style: fontMedium.copyWith(
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
                      CancelBtn("Cancel"),
                      SizedBox(width: 2.w,),
                      GestureDetector(onTap:()async {
                        SaveBatsmanDetailRequestModel requestModel = SaveBatsmanDetailRequestModel(
                          batsman: [
                            Batsman(
                              matchId:int.parse(widget.matchId),
                              teamId: int.parse(widget.team1id),
                              playerId: items![localSelectedIndex!].playerId,
                              striker: true
                            ),
                          ],
                        );

                        // Call the saveBatsman function with the request model
                        await ScoringProvider().saveBatsman(requestModel);
                        Navigator.pop(context);
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
  _displayBowlerBottomSheet (BuildContext context, int? selectedBowler,Function(int?) onItemSelected) async{
    int? localBowlerIndex = selectedBowler;
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
                        Text("Select Players",style: fontMedium.copyWith(
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
                      itemCount: itemsBowler!.length,
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
                                  child: Center(
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
                                    Text("${itemsBowler![index].name??'-'}",style: fontMedium.copyWith(
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
                                        Text(itemsBowler![index].playingStyle??'-',style: fontMedium.copyWith(
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
                        CancelBtn("Cancel"),
                        SizedBox(width: 2.w,),
                        GestureDetector(onTap:()async {
                          ScoringProvider().saveBowler(widget.matchId,widget.team2id,itemsBowler![localBowlerIndex!].playerId.toString());
                          Navigator.pop(context);
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
                        Text("Select Players",style: fontMedium.copyWith(
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
                                    Text("${itemsKeeper![index].name??'-'}",style: fontMedium.copyWith(
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
                                        Text(itemsKeeper![index].playingStyle??'-',style: fontMedium.copyWith(
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
                            'Please Select One Option',
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
  _displayPlayer2BottomSheet (BuildContext context, int? initialSelectedIndex,Function(int?) onItemSelected) async{
    int? localSelectedIndex = initialSelectedIndex;
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
                        Text("Select Players",style: fontMedium.copyWith(
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
                    child: Text('${selectedTeamName}',style: fontMedium.copyWith(
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
                      itemCount: items!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (localSelectedIndex  == index) {
                                localSelectedIndex  = null; // Deselect the item if it's already selected
                              } else {
                                localSelectedIndex  = index; // Select the item if it's not selected
                              }
                              onItemSelected(localSelectedIndex);
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
                                    color: localSelectedIndex  == index ? Colors.blue : Colors.grey, // Change colors based on selected index
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
                                    Text("${items![index].name??'-'}",style: fontMedium.copyWith(
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
                                        Text(items![index].playingStyle??'-',style: fontMedium.copyWith(
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
                        GestureDetector(
                            child: CancelBtn("Cancel")),
                        SizedBox(width: 2.w,),
                        GestureDetector(onTap:()async {
                          SaveBatsmanDetailRequestModel requestModel = SaveBatsmanDetailRequestModel(
                            batsman: [
                              Batsman(
                                matchId:int.parse(widget.matchId),
                                teamId: int.parse(widget.team1id),
                                playerId: items![localSelectedIndex!].playerId,
                                  striker: false
                              ),
                            ],
                          );


                          await ScoringProvider().saveBatsman(requestModel);
                          Navigator.pop(context);
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
