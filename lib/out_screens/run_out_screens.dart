import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class RunOutScreen extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  const RunOutScreen({required this.ballType,required this.scoringData,super.key});

  @override
  State<RunOutScreen> createState() => _RunOutScreenState();
}

class _RunOutScreenState extends State<RunOutScreen> {
  int? isSelected=0;
  int? isStump=0;
  int? isWideSelected ;
  int? isRunSelected ;
  int? selectedBowler;
  List<BowlingPlayers>? itemsBowler= [];
  String? selectedBTeamName ="";
  String selectedBowlerName = "";
  int selectedBowlerId=0;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> chipData =[
      {
        'label': "Wide",
      },
      {
        'label': 'No ball',
      },
      {
        'label': 'LB',
      },
      {
        'label': 'Byes',
      },


    ];
    List<Map<String, dynamic>> chipDatas =[
      {
        'label': "1",
      },
      {
        'label': '2',
      },
      {
        'label': '3',
      },
      {
        'label': '4',
      },
      {
        'label': '5',
      }, {
        'label': '6',
      },
      {
        'label': '7',
      },

    ];
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
                  Text("Run out",style: fontMedium.copyWith(
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
                      padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select the batsman*",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.5.h,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSelected =1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal:4.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isSelected ==1)?AppColor.primaryColor:AppColor.lightColor,

                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(Images.playerImg,width: 20.w,),
                                      SizedBox(height: 1.h,),
                                      Text("${widget.scoringData!.data!.batting![0].playerName}",style: fontMedium.copyWith(
                                        fontSize: 10.sp,
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
                                  padding: EdgeInsets.symmetric(horizontal:4.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isSelected ==2)?AppColor.primaryColor:AppColor.lightColor,

                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(Images.playerImg,width: 20.w,),
                                      SizedBox(height: 1.h,),
                                      Text("${widget.scoringData!.data!.batting![1].playerName}",style: fontMedium.copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor.blackColour,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                          Text("Select the fielder*",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.5.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 10.w),
                            child: GestureDetector(onTap: ()async{

                              await ScoringProvider().getPlayerList(widget.scoringData!.data!.batting![0].matchId.toString(), widget.scoringData!.data!.bowling!.teamId.toString(),'bowl').then((value){
                                setState(() {
                                  itemsBowler = value.bowlingPlayers;
                                  selectedBTeamName= value.team!.teamName;
                                });

                                _displayBowlerBottomSheet (context,selectedBowler,(bowlerIndex) async{

                                  setState(() {
                                    selectedBowler = bowlerIndex;
                                    if (selectedBowler != null) {

                                      selectedBowlerName = itemsBowler![selectedBowler!].name ?? "";
                                      selectedBowlerId= itemsBowler![selectedBowler!].playerId??0;
                                    }
                                  });


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
                          Text((selectedBowlerName.isEmpty)?"Select the fielder*":selectedBowlerName,style: fontRegular.copyWith(
                            fontSize: 13.sp,
                            color: AppColor.blackColour,
                          ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      padding: EdgeInsets.only(left: 6.w,right: 4.w,top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Which End?*",style: fontMedium.copyWith(
                            fontSize: 14.sp,
                            color: AppColor.blackColour,
                          ),),
                          SizedBox(height: 1.5.h,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isStump =1;
                                  });
                                },
                                child: Container(
                                  height: 15.h,
                                  width: 35.w,
                                  padding: EdgeInsets.symmetric(horizontal:2.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isStump ==1)?AppColor.primaryColor:AppColor.lightColor,
                                  ),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(Images.stumpLogo,width: 15.w,),
                                      SizedBox(height: 1.h,),
                                      Text("Striker end",style: fontMedium.copyWith(
                                        fontSize: 12.sp,
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
                                    isStump =2;
                                  });
                                },
                                child: Container(
                                  height: 15.h,
                                  width: 35.w,
                                  padding: EdgeInsets.symmetric(horizontal:2.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffDFDFDF)),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( isStump ==2)?AppColor.primaryColor:AppColor.lightColor,
                                  ),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(Images.batLogo,width: 15.w,),
                                      SizedBox(height: 1.h,),
                                      Text("Non-Striker end",style: fontMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour,
                                      ),),
                                    ],
                                  ),
                                ),
                              ),

                            ],
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
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ("Delivery type"),
                                    style: fontMedium.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColor.blackColour,
                                    )),
                                TextSpan(
                                    text: "(Optional)",
                                    style: fontRegular.copyWith(
                                        fontSize: 12.sp,
                                        color: Color(0xff666666)
                                    )),
                              ])),
                          SizedBox(height: 1.5.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 0.w,right: 0.w),
                            child: Wrap(
                              spacing: 2.w, // Horizontal spacing between items
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
                                    padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 0.8.h),
                                    label: Text(data['label'],style: fontRegular.copyWith(
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
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 2.h,bottom: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.lightColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:EdgeInsets.only(left: 6.w,right: 4.w,),
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: ("Batsman Runs scored"),
                                      style: fontMedium.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColor.blackColour,
                                      )),
                                  TextSpan(
                                      text: "(Optional)",
                                      style: fontRegular.copyWith(
                                          fontSize: 12.sp,
                                          color: Color(0xff666666)
                                      )),
                                ])),
                          ),
                          SizedBox(height: 1.5.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 1.w,right: 1.w),
                            child: Wrap(
                              spacing: 1.w, // Horizontal spacing between items
                              runSpacing: 0.5.h, // Vertical spacing between lines
                              alignment: WrapAlignment.center, // Alignment of items
                              children:chipDatas.map((data) {
                                final index = chipDatas.indexOf(data);
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isRunSelected=index;
                                    });
                                  },
                                  child: Chip(
                                    padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
                                    label: Text(data['label'],style: fontRegular.copyWith(
                                        fontSize: 12.sp,
                                        color: AppColor.blackColour
                                    ),),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: const BorderSide(
                                        color: Color(0xffDADADA),
                                      ),
                                    ),
                                    backgroundColor: isRunSelected==index? AppColor.primaryColor : Color(0xffF8F9FA),
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
                    GestureDetector(onTap:(){
                      Navigator.pop(context);
                    },
                        child: CancelBtn("Cancel")),
                    SizedBox(width: 4.w,),
                    GestureDetector(onTap: ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      int overNumber= prefs.getInt('over_number')??0;
                      int ballNumber= prefs.getInt('ball_number')??0;
                      var strikerId=prefs.getInt('striker_id')??0;
                      var nonStrikerId=prefs.getInt('non_striker_id')??0;
                      var bowlerId=prefs.getInt('bowler_id')??0;
                      var keeperId=prefs.getInt('wicket_keeper_id')??0;

                      ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                      scoreUpdateRequestModel.ballTypeId=14;
                      scoreUpdateRequestModel.matchId=widget.scoringData!.data!.batting![0].matchId;
                      scoreUpdateRequestModel.scorerId=1;
                      scoreUpdateRequestModel.strikerId=strikerId;
                      scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                      scoreUpdateRequestModel.wicketKeeperId=keeperId;
                      scoreUpdateRequestModel.bowlerId=bowlerId;
                      scoreUpdateRequestModel.overNumber=overNumber;
                      scoreUpdateRequestModel.ballNumber=ballNumber;
                      scoreUpdateRequestModel.runsScored=0;
                      scoreUpdateRequestModel.extras=0;
                      scoreUpdateRequestModel.wicket=0;
                      scoreUpdateRequestModel.dismissalType=widget.ballType;
                      scoreUpdateRequestModel.commentary=0;
                      scoreUpdateRequestModel.innings=1;
                      scoreUpdateRequestModel.battingTeamId=widget.scoringData!.data!.batting![0].teamId??0;
                      scoreUpdateRequestModel.bowlingTeamId=widget.scoringData!.data!.bowling!.teamId??0;
                      scoreUpdateRequestModel.overBowled=overNumber;
                      scoreUpdateRequestModel.totalOverBowled=0;
                      scoreUpdateRequestModel.outByPlayer=0;
                      scoreUpdateRequestModel.outPlayer=selectedBowlerId;
                      scoreUpdateRequestModel.totalWicket=0;
                      scoreUpdateRequestModel.fieldingPositionsId=0;
                      scoreUpdateRequestModel.endInnings=false;
                      scoreUpdateRequestModel.bowlerPosition=0;
                      ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('over_number', value.data!.overNumber??0);
                        await prefs.setInt('ball_number', value.data!.ballNumber??1);
                        await prefs.setInt('striker_id', value.data!.strikerId??0);
                        await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                      });
                      Navigator.pop(context);
                    },
                        child: OkBtn("Ok")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
                                        Text("Right hand batsman",style: fontMedium.copyWith(
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
