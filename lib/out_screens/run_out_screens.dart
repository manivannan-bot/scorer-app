import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:scorer/widgets/ok_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Scoring screens/home_screen.dart';
import '../models/player_list_model.dart';
import '../models/score_update_request_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../provider/player_selection_provider.dart';
import '../provider/score_update_provider.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../view/widgets/player_list_item.dart';
import '../widgets/snackbar.dart';

class RunOutScreen extends StatefulWidget {
  final int ballType;
  final ScoringDetailResponseModel? scoringData;
  final VoidCallback refresh;
  const RunOutScreen({required this.ballType,required this.scoringData, required this.refresh, super.key});

  @override
  State<RunOutScreen> createState() => _RunOutScreenState();
}

class _RunOutScreenState extends State<RunOutScreen> {
  int? isSelected=0;
  int? isStump=0;
  int? isWideSelected = -1;
  int? isRunSelected;
  int runsScored = 0;
  int? selectedBowler;
  List<BowlingPlayers>? itemsBowler= [];
  String? selectedBTeamName ="";
  String selectedBowlerName = "";
  int selectedBowlerId=0;
  int? selectedBatsmanId;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
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
    selectedBatsmanId=widget.scoringData!.data!.batting![0].playerId;
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w)+EdgeInsets.only(top: statusBarHeight + 2.h),
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
                                  isSelected =0;
                                  selectedBatsmanId=widget.scoringData!.data!.batting![0].playerId;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal:4.w,vertical: 2.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xffDFDFDF)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: ( isSelected ==0)?AppColor.primaryColor:AppColor.lightColor,

                                ),
                                child: Column(
                                  children: [
                                    Image.asset(Images.playerImg,width: 20.w,),
                                    SizedBox(height: 1.h,),
                                    Text("${widget.scoringData!.data!.batting?.first.playerName}",style: fontMedium.copyWith(
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
                                  isSelected =1;
                                  selectedBatsmanId=widget.scoringData!.data!.batting![1].playerId;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal:4.w,vertical: 2.h),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xffDFDFDF)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: ( isSelected ==1)?AppColor.primaryColor:AppColor.lightColor,

                                ),
                                child: Column(
                                  children: [
                                    Image.asset(Images.playerImg,width: 20.w,),
                                    SizedBox(height: 1.h,),
                                    Text("${widget.scoringData!.data!.batting?.last.playerName}",style: fontMedium.copyWith(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: ()async{
                              await ScoringProvider().getPlayerList(widget.scoringData!.data!.batting![0].matchId.toString(), widget.scoringData!.data!.bowling!.teamId.toString(),'bowl').then((value){
                                setState(() {
                                  itemsBowler = value.bowlingPlayers;
                                  selectedBTeamName= value.team!.teamName;
                                });
                                _displayBowlerBottomSheet (context,selectedBowler,(bowlerIndex) async{
                                  setState(() {
                                    selectedBowler = bowlerIndex;
                                    if (selectedBowler != null) {
                                      selectedBowlerName = itemsBowler![selectedBowler!].playerName ?? "";
                                      selectedBowlerId= itemsBowler![selectedBowler!].playerId??0;
                                    }
                                  });
                                });
                              });
                            },
                              child: selectedBowlerName.isEmpty
                                  ? Container(
                                height: 7.h,
                                width: 15.w,
                                decoration: BoxDecoration(
                                  border: RDottedLineBorder.all(
                                    color: const Color(0xffCCCCCC),
                                    width: 1,
                                  ),
                                  color: const Color(0xffF8F9FA),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Center(
                                    child: SvgPicture.asset(Images.plusIcon,width: 5.w,)),
                              ) : Image.network(Images.playersImage, width: 14.w,),
                            ),
                            selectedBowlerName.isEmpty
                                ? const SizedBox()
                                : SizedBox(height: 1.5.h,),
                            selectedBowlerName.isEmpty
                                ? const SizedBox()
                                : Text(selectedBowlerName,
                              style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                          ],
                        ),
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
                                  border: Border.all(color: const Color(0xffDFDFDF)),
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
                                  border: Border.all(color: const Color(0xffDFDFDF)),
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
                                  text: "Delivery type",
                                  style: fontMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.blackColour,
                                  )),
                              TextSpan(
                                  text: " (Optional)",
                                  style: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: const Color(0xff666666)
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
                                  backgroundColor: isWideSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
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
                          padding:EdgeInsets.symmetric(horizontal: 4.w,),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Batsman Runs scored",
                                    style: fontMedium.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColor.blackColour,
                                    )),
                                TextSpan(
                                    text: " (Optional)",
                                    style: fontRegular.copyWith(
                                        fontSize: 10.sp,
                                        color: const Color(0xff666666)
                                    )),
                              ])),
                        ),
                        SizedBox(height: 1.5.h,),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 1.w),
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
                                    runsScored = index+1;
                                  });
                                  print(runsScored);
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
                                  backgroundColor: isRunSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
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
            decoration: const BoxDecoration(
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
                      child: const CancelBtn("Cancel")),
                  SizedBox(width: 4.w,),
                  GestureDetector(onTap: ()async{
                    final player = Provider.of<PlayerSelectionProvider>(context, listen: false);
                    final score = Provider.of<ScoreUpdateProvider>(context, listen: false);
                    print("striker id ${player.selectedStrikerId}");
                    print("non striker id ${player.selectedNonStrikerId}");
                    print("passing over number to score update api ${score.overNumberInnings}");
                    print("passing ball number to score update api ${score.ballNumberInnings}");
                    print("passing overs bowled to score update api ${score.oversBowled}");
                    score.trackOvers(score.overNumberInnings, score.ballNumberInnings);

                    ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                    scoreUpdateRequestModel.ballTypeId=14;
                    scoreUpdateRequestModel.matchId=widget.scoringData!.data!.batting![0].matchId;
                    scoreUpdateRequestModel.scorerId=46;
                    scoreUpdateRequestModel.strikerId=int.parse(player.selectedStrikerId.toString());
                    scoreUpdateRequestModel.nonStrikerId=int.parse(player.selectedNonStrikerId.toString());
                    scoreUpdateRequestModel.wicketKeeperId=int.parse(player.selectedWicketKeeperId.toString());
                    scoreUpdateRequestModel.bowlerId=int.parse(player.selectedBowlerId.toString());
                    scoreUpdateRequestModel.overNumber=score.overNumberInnings;
                    scoreUpdateRequestModel.ballNumber=score.ballNumberInnings;
                    scoreUpdateRequestModel.runsScored=(runsScored??0+1);
                    scoreUpdateRequestModel.extras=0;
                    scoreUpdateRequestModel.extrasSlug=0;
                    scoreUpdateRequestModel.wicket=0;
                    scoreUpdateRequestModel.dismissalType=widget.ballType;
                    scoreUpdateRequestModel.commentary=0;
                    scoreUpdateRequestModel.innings=score.innings;
                    scoreUpdateRequestModel.battingTeamId=widget.scoringData!.data!.batting![0].teamId??0;
                    scoreUpdateRequestModel.bowlingTeamId=widget.scoringData!.data!.bowling!.teamId??0;
                    scoreUpdateRequestModel.overBowled=score.oversBowled;
                    scoreUpdateRequestModel.totalOverBowled=0;
                    scoreUpdateRequestModel.outByPlayer=selectedBowlerId;
                    scoreUpdateRequestModel.outPlayer=selectedBatsmanId;
                    scoreUpdateRequestModel.totalWicket=0;
                    scoreUpdateRequestModel.fieldingPositionsId=0;
                    scoreUpdateRequestModel.endInnings=false;
                    scoreUpdateRequestModel.bowlerPosition=score.bowlerPosition;
                    ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                      if(value.data?.innings == 3){
                        Dialogs.snackBar("Match Ended", context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      } else if(value.data?.inningCompleted == true){
                        print("end of innings");
                        print("navigating to home screen");
                        Dialogs.snackBar(value.data!.inningsMessage.toString(), context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      } else {
                        print("striker and non striker id - ${value.data?.strikerId.toString()} ${value.data?.nonStrikerId.toString()}");

                        print("after score update - obstruct field");
                        print(value.data?.overNumber);
                        print(value.data?.ballNumber);
                        print(value.data?.bowlerChange);
                        print("score update print end - obstruct field");

                        print("setting over number ${value.data?.overNumber} and ball number ${value.data?.ballNumber} and bowler change ${value.data?.bowlerChange} to provider after score update");
                        score.setOverNumber(value.data?.overNumber??0);
                        score.setBallNumber(value.data?.ballNumber??0);
                        score.setBowlerChangeValue(value.data?.bowlerChange??0);
                        player.setStrikerId(value.data!.strikerId.toString(), "");
                        player.setNonStrikerId(value.data!.nonStrikerId.toString(), "");
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setInt('bowlerPosition', 0);
                        widget.refresh();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                        });
                      }
                    });
                  },
                      child: const OkBtn("Ok")),
                ],
              ),
            ),
          ),
        ],
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
              decoration: const BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back,size: 7.w,)),
                        Text("Select Players",style: fontMedium.copyWith(
                          fontSize: 16.sp,
                          color: AppColor.blackColour,
                        ),),
                        SizedBox(width: 7.w,),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  const Divider(
                    thickness: 1,
                    color: Color(0xffD3D3D3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffF8F9FA),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.2.h),
                        child: Row(
                          children: [
                            Text("Search players",style: fontRegular.copyWith(
                              fontSize: 12.sp,
                              color: const Color(0xff707B81),
                            ),),
                            const Spacer(),
                            SvgPicture.asset(Images.searchIcon)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text('$selectedBTeamName',style: fontMedium.copyWith(
                        fontSize:14.sp,
                        color: AppColor.pri
                    ),),
                  ),
                  SizedBox(height: 1.5.h,),
                  Expanded(
                    child: ListView.builder(
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
                          child:PlayerListItem(index, localBowlerIndex, itemsBowler![index].playerName, itemsBowler![index].bowlingStyle),

                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
                    decoration: const BoxDecoration(
                      color: AppColor.lightColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CancelBtn("Cancel"),
                        SizedBox(width: 2.w,),
                        GestureDetector(onTap:()async {
                          Navigator.pop(context);
                        },child: const OkBtn("Ok")),
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
