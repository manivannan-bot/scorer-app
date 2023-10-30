import 'dart:async';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scorer/models/scoring_detail_response_model.dart';
import 'package:scorer/view/widgets/scorer_grid_four.dart';
import 'package:scorer/view/widgets/scorer_grid_item.dart';
import 'package:scorer/view/widgets/scorer_grid_out.dart';
import 'package:scorer/widgets/custom_vertical_dottedLine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Scoring screens/wicket_options_bottom_sheet.dart';
import '../models/player_list_model.dart';
import '../models/save_batsman_request_model.dart';
import '../models/score_update_request_model.dart';
import '../models/score_update_response_model.dart';
import '../out_screens/undo_screen.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/custom_horizondal_dottedLine.dart';
import '../widgets/dialog_others.dart';
import '../widgets/ok_btn.dart';
import 'score_update_bottom_sheet.dart';

class ScoringTab extends StatefulWidget {
  final String matchId;
  final String team1Id;
  final String team2Id;

  final VoidCallback fetchData;
  const ScoringTab(this.matchId, this.team1Id, this.team2Id, this.fetchData, {super.key});

  @override
  State<ScoringTab> createState() => _ScoringTabState();
}

class _ScoringTabState extends State<ScoringTab> {

  ScoringDetailResponseModel? scoringData;
  int index1=0;
  int index2=1;
  int totalBallId = 0;

  List<BowlingPlayers>? itemsBowler= [];
  List<BattingPlayers>? itemsBatsman = [];
  int? selectedBowler;
  String? selectedBTeamName ="";
  String selectedBowlerName = "";
  String? selectedTeamName ="";
  int? selectedBatsman;
  String selectedBatsmanName = "";
  bool showError=false;
  int bowlerPosition=0;

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";
  TextEditingController searchController = TextEditingController();
  List<BowlingPlayers> searchedList = [];
  List<BattingPlayers>? searchedBatsman = [];

  ScoringDetailResponseModel scoringDetailResponseModel=ScoringDetailResponseModel();
  ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();

  ScoreUpdateResponseModel scoreUpdateResponseModel=ScoreUpdateResponseModel();

  void receiveDataFromScoreBottomSheet(ScoreUpdateResponseModel data1) {
    setState(() {
      scoreUpdateResponseModel = data1;
    });
  }

  RefreshController refreshController = RefreshController();
  String eventData = 'No event received yet';

  @override
  void initState() {
    scoringData=null;
    super.initState();
    _refreshData();
    //setUpServices();
  }

  void setUpServices() {
    var options = PusherOptions(
        host: '64.227.139.48', port: 6001, encrypted: false, cluster: 'mt1');

    LaravelFlutterPusher pusher =
    LaravelFlutterPusher('app-key', options, enableLogging: true);
    pusher.subscribe('public.match.list').bind('matches', (event){

      setState(() {
        eventData = 'Event Data: $event';
      });
      print(eventData);

    });
  }

  void _refreshData() {
    widget.fetchData();
    ScoringProvider().getScoringDetail(widget.matchId).then((value) async {
      setState(() {
        scoringData = value;
        selectedBowlerName=scoringData!.data!.bowling!.playerName.toString();
      });
      refreshController.refreshCompleted();
    });
  }

  onSearchCategory(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedList = itemsBowler!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
      if (searchedList.isEmpty) {
        setState(() {
          isResultEmpty = true;
        });
      } else {
        setState(() {
          isResultEmpty = false;
        });
      }
      searching = false;
    });
  }
  onSearchBatsman(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedBatsman = itemsBatsman!.where((player) =>
          player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
      if (searchedBatsman!.isEmpty) {
        setState(() {
          isResultEmpty = true;
        });
      } else {
        setState(() {
          isResultEmpty = false;
        });
      }
      searching = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(scoringData==null || scoringData!.data ==null){
      return const Center(child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ));
    }
    if(scoringData!.data!.batting!.isEmpty || scoringData!.data!.bowling==null){
      return scoringData!.data!.batting!.isEmpty
          ? const Center(child: Text('Please Select Batsman'))
          : const Center(child: Text('Please Select Bowler'));
    }
    if(scoringData!.data!.batting!.length<2){
      // var player=scoringData!.data!.batting!.first.striker==1?'non_striker_id':'striker_id';
     // changeBatsman(player);
      return const Center(child: Text('Please Select Batsman'));
    }
    int totalBallId = 0;
    showError=false;
    for (int index = 0; index < scoringData!.data!.over!.length; index++) {
      totalBallId += int.parse(scoringData!.data!.over![index].runsScored==null?'0':scoringData!.data!.over![index].runsScored.toString()); // Sum the ballIds
    }

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      onRefresh: _refreshData,
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:EdgeInsets.only(bottom: 2.h),
                          child: Row(children: [
                            Text(
                              'Batsman',
                              style: fontMedium.copyWith(color: const Color(0xffD78108),fontSize: 16.sp),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            GestureDetector(onTap:()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var strikerId=prefs.getInt('striker_id')??0;
                              var nonStrikerId=prefs.getInt('non_striker_id')??0;
                              await prefs.setInt('non_striker_id',strikerId);
                              await prefs.setInt('striker_id',nonStrikerId);
                              setState(() {
                                if(index1==1){
                                  index2=1;
                                  index1=0;
                                }else{
                                  index2=0;
                                  index1=1;
                                }
                              });
                            },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    shape: BoxShape.rectangle,
                                    color: Colors.black

                                ),
                                padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.5.h),
                                child: Text('swap',style: fontMedium.copyWith(color: Colors.white,fontSize: 10.sp),),),
                            ),
                          ]),
                        ),
                        Row(
                          children: [
                            Text('${scoringData!.data!.batting![index1].playerName??'-'}',
                                style:  fontRegular.copyWith(
                                    color: Colors.black, fontSize: 10.sp)),
                            scoringData!.data!.batting![index1].striker == 1
                                ? SvgPicture.asset(Images.batIcon) :  SizedBox(width:1.w),
                            Text('${scoringData!.data!.batting![index1].runsScored??'0'}(${scoringData!.data!.batting![index1].ballsFaced??'0'})',
                                style:  fontRegular.copyWith(
                                    color: Colors.black, fontSize: 10.sp)),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Text((scoringData!.data!.batting?[index2]!=null)?'${scoringData!.data!.batting![index2].playerName??'-'} ':'-',
                                style:  fontRegular.copyWith(
                                    color: Colors.black, fontSize: 10.sp)),
                            scoringData!.data!.batting![index2].striker == 1
                                ? SvgPicture.asset(Images.batIcon) :  SizedBox(width:1.w),
                            Text((scoringData!.data!.batting?[index2]!=null)?
                            '  ${scoringData!.data!.batting![index2].runsScored??'0'}(${scoringData!.data!.batting![index2].ballsFaced??'0'})':'-',
                                style:  fontRegular.copyWith(
                                    color: Colors.black, fontSize: 10.sp)),
                          ],
                        ),
                      ],
                    ),
                    const CustomVerticalDottedLine(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: EdgeInsets.only(left:4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:EdgeInsets.only(bottom: 2.h),
                              child: Row(children: [
                                Text('Bowler',
                                    style: fontMedium.copyWith(
                                        color: const Color(0xffD78108),
                                        fontSize: 16.sp)),
                                SizedBox(
                                  width: 4.w,
                                ),
                                GestureDetector(onTap:()async{
                                  changeBowler();
                                },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        shape: BoxShape.rectangle,
                                        color: Colors.black

                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 0.5.h),
                                    child: Text('Change',style: fontMedium.copyWith(color: Colors.white,fontSize: 10.sp),),),
                                )
                              ]),
                            ),
                            //over data
                            Text('${selectedBowlerName.isEmpty?scoringData!.data!.bowling!.playerName??'-':selectedBowlerName}  '
                                '  ${scoringData!.data!.bowling!.totalBalls??'0'}-'
                                '${scoringData!.data!.bowling!.maiden??'0'}-'
                                '${scoringData!.data!.bowling!.runsConceded??'0'}-'
                                '${scoringData!.data!.bowling!.wickets??'0'}',
                                style:  fontRegular.copyWith(
                                    color: Colors.black, fontSize: 10.sp)),
                            SizedBox(height:0.8.h),
                            //bowler position
                            Row(
                                children:[
                              GestureDetector(
                                onTap:()async{
                                setState(() {
                                  bowlerPosition=0;
                                });
                                SharedPreferences pref=await SharedPreferences.getInstance();
                                await pref.setInt('bowlerPosition', 0);
                              },
                                child: Row(children:[
                                  SvgPicture.asset(Images.stumpIcon1,width:3.w,height: 3.h,),
                                  Padding(padding: EdgeInsets.only(left: 2.w,),
                                      child:  Text('OW',style: fontRegular.copyWith(fontSize: 10.sp),)),
                                ]),
                              ),
                              SizedBox(width:8.w),
                              GestureDetector(
                                onTap:()async{
                                  setState(() {
                                    bowlerPosition=1;
                                  });
                                  SharedPreferences pref=await SharedPreferences.getInstance();
                                  await pref.setInt('bowlerPosition', 1);
                                },
                                child: Row(children:[
                                  Padding(padding: EdgeInsets.only(right: 2.w,),
                                      child:  Text('RW',style: fontRegular.copyWith(fontSize: 10.sp),)),
                                  SvgPicture.asset(Images.stumpIcon2,width:3.w,height: 3.h,)
                                ]),
                              ),
                            ]),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: const Color(0xffF9D700),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 3.w, vertical: 2.h),
                  child: Column(
                    children: [
                      Text(
                        'over ${(scoringData!.data!.over!.isNotEmpty)?scoringData!.data!.over!.first.overNumber:'0'}',
                        style: fontRegular.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: (scoringData!.data!.over!.isNotEmpty)
                            ? SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              for (int index = 0; index < scoringData!.data!.over!.length; index++)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    (scoringData!.data!.over![index].runsScored==4 || scoringData!.data!.over![index].runsScored==6)?
                                    (scoringData!.data!.over![index].runsScored==4)
                                        ? Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child:  CircleAvatar(
                                          radius: 4.w, // Adjust the radius as needed for the circle size
                                          backgroundColor: Colors.white,
                                          child: Image.asset(Images.four)
                                      ),
                                    ):Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child:  CircleAvatar(
                                          radius: 4.w, // Adjust the radius as needed for the circle size
                                          backgroundColor: Colors.white,
                                          child: Image.asset(Images.six)
                                      ),
                                    ):
                                    Container(
                                      width: 40,
                                      height: 40,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          scoringData!.data!.over![index].slug.toString(),
                                          style:  fontRegular.copyWith(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('=',
                                    style: fontRegular.copyWith(
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(totalBallId.toString() ?? 'N/A',
                                    style: fontRegular.copyWith(
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                            :const Text(''),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        children:[
                          GestureDetector(
                            onTap:() async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var overNumber= prefs.getInt('over_number');
                              var ballNumber= prefs.getInt('ball_number');
                              var strikerId=prefs.getInt('striker_id')??0;
                              var nonStrikerId=prefs.getInt('non_striker_id')??0;
                              var bowlerId=prefs.getInt('bowler_id')??0;
                              var keeperId=prefs.getInt('wicket_keeper_id')??0;

                              scoreUpdateRequestModel.ballTypeId=0;
                              scoreUpdateRequestModel.matchId=int.parse(widget.matchId);
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
                              scoreUpdateRequestModel.dismissalType=0;
                              scoreUpdateRequestModel.commentary=0;
                              scoreUpdateRequestModel.innings=1;
                              scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![index1].teamId??0;
                              scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                              scoreUpdateRequestModel.overBowled=overNumber;
                              scoreUpdateRequestModel.totalOverBowled=0;
                              scoreUpdateRequestModel.outByPlayer=0;
                              scoreUpdateRequestModel.outPlayer=0;
                              scoreUpdateRequestModel.totalWicket=0;
                              scoreUpdateRequestModel.fieldingPositionsId=0;
                              scoreUpdateRequestModel.endInnings=false;
                              scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                              ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value)async {
                                setState(() {
                                  scoreUpdateResponseModel=value;
                                });
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setInt('over_number', value.data!.overNumber??0);
                                await prefs.setInt('ball_number', value.data!.ballNumber??0);
                                await prefs.setInt('striker_id', value.data!.strikerId??0);
                                await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                                await prefs.setInt('bowler_change', value.data!.bowlerChange??0);
                                await prefs.setInt('bowlerPosition', 0);
                                if(value.data!.strikerId==0 || value.data!.nonStrikerId==0){
                                  String player=(value.data!.strikerId==0)?'striker_id':'non_striker_id';
                                  changeBatsman(player);
                                }

                              });
                              },
                              child: const ScorerGridItem('0','DOT')),

                          const CustomHorizantalDottedLine(),]),
                    const CustomVerticalDottedLine(),
                    Column(
                        children:[
                          GestureDetector(onTap:()async {
                            bool continueOperations = await isBatsman();
                            if (!continueOperations) {
                              return;
                            }
                            _displayBottomSheet(1,scoringData);
                          }, child: const ScorerGridItem('1','')),

                          const CustomHorizantalDottedLine(),]),
                    const CustomVerticalDottedLine(),
                    Column(
                        children:[
                          GestureDetector(onTap:()async{
                            bool continueOperations =  await isBatsman();
                            if (!continueOperations) {
                              return;
                            }
                            _displayBottomSheet(2,scoringData);
                          }, child: const ScorerGridItem('2','')),
                          const CustomHorizantalDottedLine(),]),
                    const CustomVerticalDottedLine(),
                    Column(
                        children:[
                          GestureDetector(onTap:()async{
                            bool continueOperations = await isBatsman();
                            if (!continueOperations) {
                              return;
                            }
                            _displayBottomSheet(3,scoringData);
                          }, child: const ScorerGridItem('3','')),
                          const CustomHorizantalDottedLine(),]),
                    const CustomVerticalDottedLine(),
                    Column(
                        children:[
                          GestureDetector(onTap:()async{
                            bool continueOperations = await isBatsman();
                            if (!continueOperations) {
                              return;
                            }
                            _displayBottomSheet(4,scoringData);
                          }, child:const ScorerGridFour(Images.four,'FOUR')),
                          const CustomHorizantalDottedLine(),]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        children:[  GestureDetector(onTap:()async{
                          bool continueOperations = await isBatsman();
                          if (!continueOperations) {
                            return;
                          }
                          _displayBottomSheet(6,scoringData);
                        }, child:const ScorerGridFour(Images.six,'SIX')),
                          const CustomHorizantalDottedLine(),]),
                    const CustomVerticalDottedLine(),
                    Column(
                        children:[ GestureDetector(
                          onTap: ()async{
                            bool continueOperations = await isBatsman();
                            if (!continueOperations) {
                              return;
                            }
                            _displayBottomSheetWide(7,scoringData);
                          },
                            child: const ScorerGridItem('WD','WIDE')),
                          const CustomHorizantalDottedLine(),]),
                    const CustomVerticalDottedLine(),
                    Column(
                        children:[ GestureDetector(
                          onTap: ()async{
                            bool continueOperations = await isBatsman();
                            if (!continueOperations) {
                              return;
                            }
                            _displayBottomSheetNoBall(8,scoringData);
                          },
                            child: const ScorerGridItem('NB','NO BALL')),
                          const CustomHorizantalDottedLine(),]),
                    const CustomVerticalDottedLine(),
                    Column(
                        children:[ GestureDetector(
                          onTap:()async{
                            bool continueOperations = await isBatsman();
                            if (!continueOperations) {
                              return;
                            }
                            _displayBottomSheetLegBye(9,scoringData);
                          },
                            child: const ScorerGridItem('LB','LEG-BYE')),
                          const CustomHorizantalDottedLine(),]),
                    const CustomVerticalDottedLine(),
                    Column(
                        children:[ GestureDetector(
                          onTap: ()async{
                            bool continueOperations = await isBatsman();
                            if (!continueOperations) {
                              return;
                            }
                            _displayBottomSheetByes(10,scoringData);
                          },
                            child: const ScorerGridItem('BYE','')),
                          const CustomHorizantalDottedLine(),]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(onTap:()async{
                      bool continueOperations = await isBatsman();
                      if (!continueOperations) {
                        return;
                      }
                      _displayBottomSheetBonus(11,scoringData);
                    },
                        child: const ScorerGridItem('B/P','B/P')),
                    const CustomVerticalDottedLine(),
                    GestureDetector(onTap: ()async{
                      bool continueOperations =  await isBatsman();
                      if (!continueOperations) {
                        return;
                      }
                      _displayBottomSheetMoreRuns(5,scoringData);
                    },
                        child: const ScorerGridItem('5,7..','RUNS')),
                    const CustomVerticalDottedLine(),
                    GestureDetector(
                        onTap: ()async {
                          bool continueOperations =  await isBatsman();
                          if (!continueOperations) {
                            return;
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const UndoScreen();
                              },
                            );
                            });
                        },
                        child: const ScorerGridItem('','UNDO')),
                    const CustomVerticalDottedLine(),
                    GestureDetector(
                        onTap: ()async{
                          bool continueOperations = await isBatsman();
                          if (!continueOperations) {
                            return;
                          }
                          _displayBottomSheetOther();},
                        child: const ScorerGridItem('','OTHER')),
                    const CustomVerticalDottedLine(),
                    GestureDetector(
                        onTap: ()async{
                          bool continueOperations = await isBatsman();
                          if (!continueOperations) {
                            return;
                          }
                      _displayBottomOut(scoringData);
                          },
                        child: const ScorerGridOut('OUT','')),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

   isBatsman()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var strikerId=prefs.getInt('striker_id')??0;
    var nonStrikerId=prefs.getInt('non_striker_id')??0;
    var isBowlerChange=prefs.getInt('bowler_change')??0;
    if(strikerId==0 || nonStrikerId==0 ) {
      String player=(strikerId==0)?'striker_id':'non_striker_id';
      changeBatsman(player);
      return false;
    }
    if(isBowlerChange==1){
      changeBowler();
      return false;
    }
    return true;
  }

  void changeBatsman(String player) async{
     await ScoringProvider().getPlayerList(widget.matchId,widget.team1Id,'bat').then((value) {
       setState(() {
         itemsBatsman = [];
         searchedBatsman=value.battingPlayers!;
         itemsBatsman = value.battingPlayers;
         selectedTeamName= value.team!.teamName;
       });

       _displayBatsmanBottomSheet (selectedBatsman,(bowlerIndex) {
         setState(() {
           selectedBatsman = bowlerIndex;
           if (selectedBatsman != null) {
             selectedBatsmanName = itemsBatsman![selectedBatsman!].playerName ?? "";
           }
         });
       },player);


     });



  }

  void changeBowler() {

    ScoringProvider().getPlayerList(widget.matchId,widget.team2Id,'bowl').then((value) {
        setState(() {
          itemsBowler=[];
          searchedList=value.bowlingPlayers!;
          itemsBowler = value.bowlingPlayers;
          selectedBTeamName= value.team!.teamName;
        });
            _displayBowlerBottomSheet (selectedBowler,(bowlerIndex) {
              setState(() {
                selectedBowler = bowlerIndex;
                if (selectedBowler != null) {
                  selectedBowlerName = itemsBowler![selectedBowler!].playerName ?? "";
                }
              });
            });
    });
  }

  Future<ScoreUpdateResponseModel?> _displayBottomSheet(int run, ScoringDetailResponseModel? scoringData) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double sheetHeight = screenHeight * 0.9;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {

        return SizedBox(height: sheetHeight,
          child: ScoreBottomSheet(run,scoringData!,onSave: (value){
            setState(() {
              scoreUpdateResponseModel=value;
            });

          },),
        );
      },
    ).then((value) {
      _refreshData();
    });
    return null;
  }

  _displayBowlerBottomSheet (int? selectedBowler,Function(int?) onItemSelected) async{

    int? localBowlerIndex ;
    isResultEmpty=true;
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
                        Text("Select Bowler",style: fontMedium.copyWith(
                          fontSize: 18.sp,
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
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                cursorColor: AppColor.secondaryColor,
                                onChanged: (value) {
                                  onSearchCategory(value);
                                  setState(() {
                                    if (value.isEmpty) {
                                      searching = false;
                                    }
                                    else{
                                      searching = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Search for bowlers",
                                  hintStyle: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textMildColor
                                  ),),
                              ),
                            ),
                            searching
                                ? InkWell(
                                onTap: (){
                                  setState(() {
                                    searchController.clear();
                                    searching = false;
                                  });
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  onSearchCategory(" ");
                                },
                                child: Icon(Icons.close, color: AppColor.iconColour, size: 5.w,))
                                : SvgPicture.asset(Images.searchIcon, color: AppColor.iconColour, width: 3.5.w,),
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
                  const Divider(
                    thickness: 0.5,
                    color: Color(0xffD3D3D3),
                  ),
                  if(isResultEmpty && searching)...[
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        "No players found",
                        style: fontBold.copyWith(
                            color: AppColor.redColor, fontSize: 14.sp),
                      ),
                    )
                  ]
                  else if(!isResultEmpty&&searching)...[
                    Expanded(
                      child:   ListView.separated(
                        separatorBuilder:(context ,_) {
                          return const Divider(
                            thickness: 0.6,
                          );
                        },
                        itemCount: searchedList!.length,
                        itemBuilder: (context, index) {
                          final isActive=searchedList![index].active??0;
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
                            child:Opacity(opacity: isActive==1?0.5:1,
                              child: Padding(
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
                                        Text("${searchedList![index].playerName??'-'}",style: fontMedium.copyWith(
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
                                            Text(searchedList![index].bowlingStyle??'-',style: fontMedium.copyWith(
                                                fontSize: 11.sp,
                                                color: const Color(0xff555555)
                                            ),),
                                          ],
                                        ),

                                      ],
                                    ),
                                    const Spacer(),

                                  ],
                                ),
                              ),
                            ),

                          );
                        },
                      ),
                    ),
                  ]
                  else...[
                      Expanded(
                        child:   ListView.separated(
                          separatorBuilder:(context ,_) {
                            return const Divider(
                              thickness: 0.6,
                            );
                          },
                          itemCount: searchedList!.length,
                          itemBuilder: (context, index) {
                            final isActive=searchedList![index].active??0;
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
                              child:Opacity(opacity: isActive==1?0.5:1,
                                child: Padding(
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
                                          Text("${searchedList![index].playerName??'-'}",style: fontMedium.copyWith(
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
                                              Text(searchedList![index].bowlingStyle??'-',style: fontMedium.copyWith(
                                                  fontSize: 11.sp,
                                                  color: const Color(0xff555555)
                                              ),),
                                            ],
                                          ),

                                        ],
                                      ),
                                      const Spacer(),

                                    ],
                                  ),
                                ),
                              ),

                            );
                          },
                        ),
                      ),
                  ],


                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
                    decoration: const BoxDecoration(
                      color: AppColor.lightColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(visible:showError,
                          child: Text('Please Select one Player',style: fontMedium.copyWith(color: Colors.red),),

                        ),
                        GestureDetector(onTap:(){
                          Navigator.pop(context);
                        },
                            child: const CancelBtn("Cancel")),
                        SizedBox(width: 2.w,),
                        GestureDetector(onTap:()async {

                          if(localBowlerIndex!=null){
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('bowler_id', searchedList![localBowlerIndex!].playerId!);
                          await prefs.setInt('bowler_change', 0);
                          Navigator.pop(context);
                          }else{
                            setState(() {showError=true;});
                             Timer(const Duration(seconds: 4), () {setState(() {showError = false;});});
                          }

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

  Future<void> _displayBatsmanBottomSheet (int? selectedBatsman,Function(int?) onItemSelected,String player) async{
    int? localBowlerIndex = selectedBatsman;
    isResultEmpty=true;
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
                        Text("Select Batsman",style: fontMedium.copyWith(
                          fontSize: 18.sp,
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
                            Expanded(
                              child: TextFormField(
                                controller: searchController,
                                cursorColor: AppColor.secondaryColor,
                                onChanged: (value) {
                                  onSearchBatsman(value);
                                  setState(() {
                                    if (value.isEmpty) {
                                      searching = false;
                                    }
                                    else{
                                      searching = true;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Search for bowlers",
                                  hintStyle: fontRegular.copyWith(
                                      fontSize: 10.sp,
                                      color: AppColor.textMildColor
                                  ),),
                              ),
                            ),
                            searching
                                ? InkWell(
                                onTap: (){
                                  setState(() {
                                    searchController.clear();
                                    searching = false;
                                  });
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  onSearchBatsman(" ");
                                },
                                child: Icon(Icons.close, color: AppColor.iconColour, size: 5.w,))
                                : SvgPicture.asset(Images.searchIcon, color: AppColor.iconColour, width: 3.5.w,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text('$selectedTeamName',style: fontMedium.copyWith(
                        fontSize:14.sp,
                        color: AppColor.pri
                    ),),
                  ),
                  // Divider(
                  //   color: Color(0xffD3D3D3),
                  // ),
                  const Divider(
                    thickness: 0.5,
                    color: Color(0xffD3D3D3),
                  ),
                  if(isResultEmpty && searching)...[
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        "No players found",
                        style: fontBold.copyWith(
                            color: AppColor.redColor, fontSize: 14.sp),
                      ),
                    )
                  ]
                  else if(!isResultEmpty && searching)...[
                    Expanded(
                      child:   ListView.separated(
                          separatorBuilder:(context ,_) {
                            return const Divider(
                              thickness: 0.6,
                            );
                          },
                          itemCount: searchedBatsman!.length,
                          itemBuilder: (context, index) {
                            final isPlayerOut = searchedBatsman![index].isOut == 1 || searchedBatsman![index].isOut == 0;

                            return GestureDetector(
                              onTap: () {
                                if (isPlayerOut) {

                                } else {
                                  setState(() {
                                    if (localBowlerIndex == index) {
                                      localBowlerIndex = null;
                                    } else {
                                      localBowlerIndex = index;
                                    }
                                    onItemSelected(localBowlerIndex);
                                  });
                                }
                              },
                              child: Opacity(
                                opacity: isPlayerOut?0.5:1.0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w, vertical: 1.h),
                                  child: Row(
                                    children: [
                                      //circular button
                                      Container(
                                        height: 20.0, // Adjust the height as needed
                                        width: 20.0, // Adjust the width as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: localBowlerIndex == index ? Colors
                                              .blue : Colors
                                              .grey, // Change colors based on selected index
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.circle_outlined,
                                            color: Colors.white, // Icon color
                                            size: 20.0, // Icon size
                                          ),
                                        ),
                                      ), SizedBox(width: 3.w,),
                                      Image.asset(
                                        Images.playersImage, width: 10.w,),
                                      SizedBox(width: 2.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            searchedBatsman![index].playerName ?? '-',
                                            style: fontMedium.copyWith(
                                              fontSize: 12.sp,
                                              color: AppColor.blackColour,
                                            ),),
                                          Row(
                                            children: [
                                              Container(
                                                height: 1.h,
                                                width: 2.w,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(50),
                                                  color: AppColor.pri,
                                                ),
                                              ),
                                              SizedBox(width: 2.w,),
                                              Text(
                                                searchedBatsman![index].battingStyle ??
                                                    '-', style: fontMedium.copyWith(
                                                  fontSize: 11.sp,
                                                  color: const Color(0xff555555)
                                              ),),
                                            ],
                                          ),

                                        ],
                                      ),
                                      const Spacer(),

                                    ],
                                  ),
                                ),
                              ),

                            );
                          }

                      ),
                    ),
                  ]
                  else...[
                      Expanded(
                        child:   ListView.separated(
                            separatorBuilder:(context ,_) {
                              return const Divider(
                                thickness: 0.6,
                              );
                            },
                            itemCount: searchedBatsman!.length,
                            itemBuilder: (context, index) {
                              final isPlayerOut = searchedBatsman![index].isOut == 1 || searchedBatsman![index].isOut == 0;

                              return GestureDetector(
                                onTap: () {
                                  if (isPlayerOut) {

                                  } else {
                                    setState(() {
                                      if (localBowlerIndex == index) {
                                        localBowlerIndex = null;
                                      } else {
                                        localBowlerIndex = index;
                                      }
                                      onItemSelected(localBowlerIndex);
                                    });
                                  }
                                },
                                child: Opacity(
                                  opacity: isPlayerOut?0.5:1.0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.5.w, vertical: 1.h),
                                    child: Row(
                                      children: [
                                        //circular button
                                        Container(
                                          height: 20.0, // Adjust the height as needed
                                          width: 20.0, // Adjust the width as needed
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: localBowlerIndex == index ? Colors
                                                .blue : Colors
                                                .grey, // Change colors based on selected index
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.circle_outlined,
                                              color: Colors.white, // Icon color
                                              size: 20.0, // Icon size
                                            ),
                                          ),
                                        ), SizedBox(width: 3.w,),
                                        Image.asset(
                                          Images.playersImage, width: 10.w,),
                                        SizedBox(width: 2.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              searchedBatsman![index].playerName ?? '-',
                                              style: fontMedium.copyWith(
                                                fontSize: 12.sp,
                                                color: AppColor.blackColour,
                                              ),),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 1.h,
                                                  width: 2.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(50),
                                                    color: AppColor.pri,
                                                  ),
                                                ),
                                                SizedBox(width: 2.w,),
                                                Text(
                                                  searchedBatsman![index].battingStyle ??
                                                      '-', style: fontMedium.copyWith(
                                                    fontSize: 11.sp,
                                                    color: const Color(0xff555555)
                                                ),),
                                              ],
                                            ),

                                          ],
                                        ),
                                        const Spacer(),

                                      ],
                                    ),
                                  ),
                                ),

                              );
                            }

                        ),
                      ),
                    ],


                  Visibility(visible:showError,
                    child: Text('Please Select one Player',style: fontMedium.copyWith(color: Colors.red),),

                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
                    decoration: const BoxDecoration(
                      color: AppColor.lightColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap:(){
                              Navigator.pop(context);
                            },child: const CancelBtn("Cancel")),
                        SizedBox(width: 2.w,),
                        GestureDetector(onTap:()async {
                          if(localBowlerIndex!=null){
                            bool striker=(player=='striker_id')?true:false;
                            SaveBatsmanDetailRequestModel requestModel = SaveBatsmanDetailRequestModel(
                              batsman: [
                                Batsman(
                                    matchId:int.parse(widget.matchId),
                                    teamId: int.parse(widget.team1Id),
                                    playerId: searchedBatsman![localBowlerIndex!].playerId,
                                    striker: striker
                                ),
                              ],
                            );

                            await ScoringProvider().saveBatsman(requestModel);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt(player, searchedBatsman![localBowlerIndex!].playerId!);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                              });
                          }else{
                            setState(() {showError=true;});
                            Timer(const Duration(seconds: 4), () {setState(() {showError = false;});});
                          }


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

//Out
  Future<void> _displayBottomOut (ScoringDetailResponseModel? scoringData) async {

    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return WicketOptionsBottomSheet(scoringData);
        })
    ).then((value)async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var strikerId=prefs.getInt('striker_id')??0;
      var nonStrikerId=prefs.getInt('non_striker_id')??0;
      widget.fetchData();
      if(strikerId==0 || nonStrikerId==0 ) {
        String player=(strikerId==0)?'striker_id':'non_striker_id';
        changeBatsman(player);
      }
    });
  }

  Future<void> _displayBottomSheetOther () async{
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
    showModalBottomSheet(context: context,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return Container(
            height: 40.h,
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
                                return EndInnings(widget.matchId,);
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
        })
    );
  }

Future<void> _displayBottomSheetWide (int ballType, ScoringDetailResponseModel? scoringData) async{
  int? isOffSideSelected =0;
  int? isWideSelected ;
  bool showError =false;
  List<Map<String, dynamic>> chipData =[
    {
      'label': 'Wd',
    },
    {
      'label': '1 + Wd',
    },
    {
      'label': '2 + Wd',
    },
    {
      'label': '3 + Wd',
    },
    {
      'label': '4 + Wd',
    },
    {
      'label': '5 + Wd',
    },
    {
      'label': '6 + Wd',
    },
  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 45.h,
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
                    Text("Wide",style: fontMedium.copyWith(
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
                padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                child: Center(
                  child: Wrap(
                    spacing: 2.5.w, // Horizontal spacing between items
                    runSpacing: 0.5.h, // Vertical spacing between lines
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
                          padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
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
              ),
              SizedBox(height: 1.h,),
              const DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              SizedBox(height: 1.5.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text("Which side?",style: fontMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.blackColour,
                ),),
              ),
              SizedBox(height: 1.5.h,),
              //offside leg side
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xffDADADA),
                          ),
                          color: isOffSideSelected==0 ? AppColor.primaryColor : null,
                        ),
                        child: Text("Off side",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: isOffSideSelected==1?AppColor.primaryColor:null,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffDADADA),
                            )
                        ),
                        child: Text("Leg side",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: showError,
                        child: Text(
                          'Please Select One Option',
                          style: fontMedium.copyWith(color: AppColor.redColor),
                        ),
                      ),
                      GestureDetector(
                          onTap:()async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var overNumber= prefs.getInt('over_number');
                            var ballNumber= prefs.getInt('ball_number');
                            var strikerId=prefs.getInt('striker_id')??0;
                            var nonStrikerId=prefs.getInt('non_striker_id')??0;
                            var bowlerId=prefs.getInt('bowler_id')??0;
                            var keeperId=prefs.getInt('wicket_keeper_id')??0;
                            var bowlerPosition=prefs.getInt('bowlerPosition')??0;
                            var wideRun=prefs.getInt('wideRun');



                            if(isWideSelected!=null) {
                              ScoreUpdateRequestModel scoreUpdateRequestModel = ScoreUpdateRequestModel();
                              scoreUpdateRequestModel.ballTypeId = ballType;
                              scoreUpdateRequestModel.matchId = scoringData!.data!.batting![0].matchId;
                              scoreUpdateRequestModel.scorerId = 1;
                              scoreUpdateRequestModel.strikerId = strikerId;
                              scoreUpdateRequestModel.nonStrikerId = nonStrikerId;
                              scoreUpdateRequestModel.wicketKeeperId = keeperId;
                              scoreUpdateRequestModel.bowlerId = bowlerId;
                              scoreUpdateRequestModel.overNumber = overNumber;
                              scoreUpdateRequestModel.ballNumber = ballNumber;

                              scoreUpdateRequestModel.runsScored =
                                  1 + (isWideSelected ?? 0);
                              scoreUpdateRequestModel.extras = (wideRun==1)?1:0;
                              scoreUpdateRequestModel.wicket = 0;
                              scoreUpdateRequestModel.dismissalType = 0;
                              scoreUpdateRequestModel.commentary = 0;
                              scoreUpdateRequestModel.innings = 1;
                              scoreUpdateRequestModel.battingTeamId =
                                  scoringData!.data!.batting![0].teamId ?? 0;
                              scoreUpdateRequestModel.bowlingTeamId =
                                  scoringData!.data!.bowling!.teamId ?? 0;
                              scoreUpdateRequestModel.overBowled=overNumber ;
                              scoreUpdateRequestModel.totalOverBowled = 0;
                              scoreUpdateRequestModel.outByPlayer = 0;
                              scoreUpdateRequestModel.outPlayer = 0;
                              scoreUpdateRequestModel.totalWicket = 0;
                              scoreUpdateRequestModel.fieldingPositionsId = 0;
                              scoreUpdateRequestModel.endInnings = false;
                              scoreUpdateRequestModel.bowlerPosition = bowlerPosition;
                              scoreUpdateRequestModel.wideType = isOffSideSelected;
                              ScoringProvider().scoreUpdate(
                                  scoreUpdateRequestModel).then((value) async {
                                SharedPreferences prefs = await SharedPreferences
                                    .getInstance();
                                await prefs.setInt(
                                    'over_number', value.data!.overNumber ?? 0);
                                await prefs.setInt(
                                    'ball_number', value.data!.ballNumber ?? 1);
                                await prefs.setInt(
                                    'striker_id', value.data!.strikerId ?? 0);
                                await prefs.setInt('non_striker_id', value.data!.nonStrikerId ?? 0);
                                await prefs.setInt('bowler_change', value.data!.bowlerChange ?? 0);
                                await prefs.setInt('bowlerPosition',0);
                                Navigator.pop(context);
                              });
                            }else{
                              setState(() {
                                showError = true;
                              });
                              if (showError) {
                                Timer(const Duration(seconds: 4), () {
                                  setState(() {
                                    showError = false;
                                  });
                                });
                              }
                            }
                          },
                          child: const OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetNoBall (int ballType,ScoringDetailResponseModel? scoringData) async{
  int? isOffSideSelected=0 ;
  int? isWideSelected ;
  bool showError =false;
  List<Map<String, dynamic>> chipData =[
    {
      'label': 'NB',
    },
    {
      'label': '1 + NB',
    },
    {
      'label': '2 + NB',
    },
    {
      'label': '3 + NB',
    },
    {
      'label': '4 + NB',
    },
    {
      'label': '5 + NB',
    },
    {
      'label': '6 + NB',
    },
    {
      'label': '7 + NB',
    },
  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 45.h,
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
                    Text("No ball",style: fontMedium.copyWith(
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
                padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                child: Wrap(
                  spacing: 2.5.w, // Horizontal spacing between items
                  runSpacing: 0.5.h, // Vertical spacing between lines
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
                        padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 0.5.h),
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
              SizedBox(height: 1.h,),
              const DottedLine(
                dashColor: Color(0xffD2D2D2),
              ),
              SizedBox(height: 1.5.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text("Type of No ball?",style: fontMedium.copyWith(
                  fontSize: 16.sp,
                  color: AppColor.blackColour,
                ),),
              ),
              SizedBox(height: 1.5.h,),
              //offside leg side
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xffDADADA),
                          ),
                          color: isOffSideSelected==0 ? AppColor.primaryColor : const Color(0xffF8F9FA),
                        ),
                        child: Text("Grease",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: isOffSideSelected==1?AppColor.primaryColor:const Color(0xffF8F9FA),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffDADADA),
                            )
                        ),
                        child: Text("Waist",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isOffSideSelected=2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: isOffSideSelected==2?AppColor.primaryColor:const Color(0xffF8F9FA),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffDADADA),
                            )
                        ),
                        child: Text("Shoulder",style: fontMedium.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: showError,
                        child: Text(
                          'Please Select One Option',
                          style: fontMedium.copyWith(color: AppColor.redColor),
                        ),
                      ),
                      GestureDetector(onTap:()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number');
                        var ballNumber= prefs.getInt('ball_number');
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;
                        var bowlerId=prefs.getInt('bowler_id')??0;
                        var keeperId=prefs.getInt('wicket_keeper_id')??0;
                        var bowlerPosition=prefs.getInt('bowlerPosition')??0;
                        var noBallRun=prefs.getInt('noBallRun');

                        if(isWideSelected!=null) {
                          ScoreUpdateRequestModel scoreUpdateRequestModel = ScoreUpdateRequestModel();
                          scoreUpdateRequestModel.ballTypeId = ballType ?? 0;
                          scoreUpdateRequestModel.matchId =
                              scoringData!.data!.batting![0].matchId;
                          scoreUpdateRequestModel.scorerId = 1;
                          scoreUpdateRequestModel.strikerId = strikerId;
                          scoreUpdateRequestModel.nonStrikerId = nonStrikerId;
                          scoreUpdateRequestModel.wicketKeeperId = keeperId;
                          scoreUpdateRequestModel.bowlerId = bowlerId;
                          scoreUpdateRequestModel.overNumber = overNumber;
                          scoreUpdateRequestModel.ballNumber = ballNumber;
                          scoreUpdateRequestModel.runsScored =
                              1 + (isWideSelected ?? 0);
                          scoreUpdateRequestModel.extras = (noBallRun==1)?1:0;
                          scoreUpdateRequestModel.wicket = 0;
                          scoreUpdateRequestModel.dismissalType = 0;
                          scoreUpdateRequestModel.commentary = 0;
                          scoreUpdateRequestModel.innings = 1;
                          scoreUpdateRequestModel.battingTeamId =
                              scoringData!.data!.batting![0].teamId ?? 0;
                          scoreUpdateRequestModel.bowlingTeamId =
                              scoringData!.data!.bowling!.teamId ?? 0;
                          scoreUpdateRequestModel.overBowled=overNumber ;
                          scoreUpdateRequestModel.totalOverBowled = 0;
                          scoreUpdateRequestModel.outByPlayer = 0;
                          scoreUpdateRequestModel.outPlayer = 0;
                          scoreUpdateRequestModel.totalWicket = 0;
                          scoreUpdateRequestModel.fieldingPositionsId = 0;
                          scoreUpdateRequestModel.endInnings = false;
                          scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                          scoreUpdateRequestModel.noBallsType=isOffSideSelected;
                          ScoringProvider()
                              .scoreUpdate(scoreUpdateRequestModel)
                              .then((value) async {
                            SharedPreferences prefs = await SharedPreferences
                                .getInstance();
                            await prefs.setInt(
                                'over_number', value.data!.overNumber ?? 0);
                            await prefs.setInt(
                                'ball_number', value.data!.ballNumber ?? 1);
                            await prefs.setInt(
                                'striker_id', value.data!.strikerId ?? 0);
                            await prefs.setInt('non_striker_id', value.data!.nonStrikerId ?? 0);
                            await prefs.setInt('bowler_change', value.data!.bowlerChange ?? 0);
                            await prefs.setInt('bowlerPosition',0);

                            Navigator.pop(context);
                          });
                        }else{
                                setState(() {
                                  showError = true;
                                });
                                if (showError) {
                                  Timer(const Duration(seconds: 4), () {
                                    setState(() {
                                      showError = false;
                                    });
                                  });
                                }
                        }
                      },child: const OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetLegBye (int ballType,ScoringDetailResponseModel? scoringData) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': '1LB',
    },
    {
      'label': '2LB',
    },
    {
      'label': '3LB',
    },
    {
      'label': '4LB',
    },
    {
      'label': '5LB',
    },
    {
      'label': '6LB',
    },
    {
      'label': '7LB',
    },
  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 33.h,
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
                    Text("Leg Byes",style: fontMedium.copyWith(
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
                padding:  EdgeInsets.only(left: 5.w,right: 8.w),
                child: Wrap(
                  spacing: 6.w, // Horizontal spacing between items
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
                        padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 0.5.h),
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
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:()async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number');
                        var ballNumber= prefs.getInt('ball_number');
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;
                        var bowlerId=prefs.getInt('bowler_id')??0;
                        var keeperId=prefs.getInt('wicket_keeper_id')??0;
                        var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                        ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                        scoreUpdateRequestModel.ballTypeId=ballType??0;
                        scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=strikerId;
                        scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                        scoreUpdateRequestModel.wicketKeeperId=keeperId;
                        scoreUpdateRequestModel.bowlerId=bowlerId;
                        scoreUpdateRequestModel.overNumber=overNumber;
                        scoreUpdateRequestModel.ballNumber=ballNumber;
                        scoreUpdateRequestModel.runsScored=isWideSelected??0;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=overNumber;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=0;
                        scoreUpdateRequestModel.endInnings=false;
                        scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('over_number', value.data!.overNumber??0);
                          await prefs.setInt('ball_number', value.data!.ballNumber??0);
                          await prefs.setInt('striker_id', value.data!.strikerId??0);
                          await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                          await prefs.setInt('bowler_change', value.data!.bowlerChange ?? 0);
                          await prefs.setInt('bowlerPosition', 0);
                          if(value.data!.strikerId==0 || value.data!.nonStrikerId==0){
                            String player=(value.data!.strikerId==0)?'striker_id':'non_striker_id';
                            changeBatsman(player);
                          }

                          Navigator.pop(context);
                        });
                      },child: const OkBtn("Save")),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetByes (int ballType,ScoringDetailResponseModel? scoringData) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  List<Map<String, dynamic>> chipData =[
    {
      'label': '1 B',
    },
    {
      'label': '2 B',
    },
    {
      'label': '3 B',
    },
    {
      'label': '4 B',
    },
    {
      'label': '5 B',
    },
    {
      'label': '6 B',
    },
    {
      'label': '7 B',
    },

  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 35.h,
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
                    Text("Byes",style: fontMedium.copyWith(
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
                padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                child: Wrap(
                  spacing: 4.w, // Horizontal spacing between items
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
                        padding: EdgeInsets.symmetric(horizontal: 1.5.w,vertical: 0.5.h),
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
              SizedBox(height: 1.5.h,),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(onTap:()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number');
                        var ballNumber= prefs.getInt('ball_number');
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;
                        var bowlerId=prefs.getInt('bowler_id')??0;
                        var keeperId=prefs.getInt('wicket_keeper_id')??0;
                        var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                        ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                        scoreUpdateRequestModel.ballTypeId=ballType??0;
                        scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                        scoreUpdateRequestModel.scorerId=1;
                        scoreUpdateRequestModel.strikerId=strikerId;
                        scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                        scoreUpdateRequestModel.wicketKeeperId=keeperId;
                        scoreUpdateRequestModel.bowlerId=bowlerId;
                        scoreUpdateRequestModel.overNumber=overNumber;
                        scoreUpdateRequestModel.ballNumber=ballNumber;

                        scoreUpdateRequestModel.runsScored=isWideSelected??0;
                        scoreUpdateRequestModel.extras=0;
                        scoreUpdateRequestModel.wicket=0;
                        scoreUpdateRequestModel.dismissalType=0;
                        scoreUpdateRequestModel.commentary=0;
                        scoreUpdateRequestModel.innings=1;
                        scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                        scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                        scoreUpdateRequestModel.overBowled=overNumber;
                        scoreUpdateRequestModel.totalOverBowled=0;
                        scoreUpdateRequestModel.outByPlayer=0;
                        scoreUpdateRequestModel.outPlayer=0;
                        scoreUpdateRequestModel.totalWicket=0;
                        scoreUpdateRequestModel.fieldingPositionsId=0;
                        scoreUpdateRequestModel.endInnings=false;
                        scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                        ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value)async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('over_number', value.data!.overNumber??0);
                          await prefs.setInt('ball_number', value.data!.ballNumber??0);
                          await prefs.setInt('striker_id', value.data!.strikerId??0);
                          await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                          await prefs.setInt('bowler_change', value.data!.bowlerChange ?? 0);
                          await prefs.setInt('bowlerPosition', 0);
                          if(value.data!.strikerId==0 || value.data!.nonStrikerId==0){
                            String player=(value.data!.strikerId==0)?'striker_id':'non_striker_id';
                            changeBatsman(player);
                          }
                          Navigator.pop(context);
                        });
                      },child: const OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}

Future<void> _displayBottomSheetBonus (int? ballType, ScoringDetailResponseModel? scoringData) async{
  int? isOffSideSelected=1 ;
  int? isWideSelected ;
  bool showError=false;
  List<Map<String, dynamic>> chipData=[
    {
      'label': "+ 1",
    },
    {
      'label': '+ 2',
    },
    {
      'label': '+ 3',
    },
    {
      'label': '+ 4',
    },
    {
      'label': '+ 5',
    },
    {
      'label': '+ 6',
    },
    {
      'label': '+ 7',
    },
  ];
  List<Map<String, dynamic>> displayedChipData = chipData;
  List<Map<String, dynamic>> chipData2 =[
    {
      'label': "- 1",
    },
    {
      'label': '- 2',
    },
    {
      'label': '- 3',
    },
    {
      'label': '- 4',
    },
    {
      'label': '- 5',
    },
    {
      'label': '- 6',
    },
    {
      'label': '- 7',
    },

  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 35.h,
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
                    Text("Bonus/Penalty",style: fontMedium.copyWith(
                      fontSize: 17.sp,
                      color: AppColor.blackColour,
                    ),),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              displayedChipData = chipData;
                              ballType=11;
                              isOffSideSelected=1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColor.blackColour),
                              color: isOffSideSelected==1?AppColor.blackColour:AppColor.lightColor,
                            ),
                            child: Icon(Icons.add,color: isOffSideSelected==1?AppColor.lightColor:AppColor.blackColour,size: 30,),
                          ),
                        ),
                        SizedBox(width: 2.w,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              displayedChipData = chipData2;
                              ballType=12;
                              isOffSideSelected=2;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppColor.blackColour),
                              color: isOffSideSelected==2?AppColor.blackColour:AppColor.lightColor,
                            ),
                            child: Icon(Icons.remove,color: isOffSideSelected==2?AppColor.lightColor:AppColor.blackColour,size:30,),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 1.h,),
              const Divider(
                color: Color(0xffD3D3D3),
              ),
              SizedBox(height: 1.h,),
              Padding(
                padding:  EdgeInsets.only(left: 5.w,right: 4.w),
                child: Wrap(
                  spacing: 5.w, // Horizontal spacing between items
                  runSpacing: 0.5.h, // Vertical spacing between lines
                  alignment: WrapAlignment.center, // Alignment of items
                  children:displayedChipData.map((data) {
                    final index = displayedChipData.indexOf(data);
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
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.5.h,),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: showError,
                        child: Text(
                          'Please Select One Option',
                          style: fontMedium.copyWith(color: AppColor.redColor),
                        ),
                      ),
                      GestureDetector(onTap:()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number');
                        var ballNumber= prefs.getInt('ball_number');
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;
                        var bowlerId=prefs.getInt('bowler_id')??0;
                        var keeperId=prefs.getInt('wicket_keeper_id')??0;
                        var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                        if(isWideSelected!=null){
                          ScoreUpdateRequestModel scoreUpdateRequestModel=ScoreUpdateRequestModel();
                          scoreUpdateRequestModel.ballTypeId=ballType??0;
                          scoreUpdateRequestModel.matchId=scoringData!.data!.batting![0].matchId;
                          scoreUpdateRequestModel.scorerId=1;
                          scoreUpdateRequestModel.strikerId=strikerId;
                          scoreUpdateRequestModel.nonStrikerId=nonStrikerId;
                          scoreUpdateRequestModel.wicketKeeperId=keeperId;
                          scoreUpdateRequestModel.bowlerId=bowlerId;
                          scoreUpdateRequestModel.overNumber=overNumber;
                          scoreUpdateRequestModel.ballNumber=ballNumber;
                          scoreUpdateRequestModel.runsScored=(isWideSelected==null)?0:(isWideSelected??0)+1;
                          scoreUpdateRequestModel.extras=(isWideSelected==null)?0:(isWideSelected??0)+1;
                          scoreUpdateRequestModel.wicket=0;
                          scoreUpdateRequestModel.dismissalType=0;
                          scoreUpdateRequestModel.commentary=0;
                          scoreUpdateRequestModel.innings=1;
                          scoreUpdateRequestModel.battingTeamId=scoringData!.data!.batting![0].teamId??0;
                          scoreUpdateRequestModel.bowlingTeamId=scoringData!.data!.bowling!.teamId??0;
                          scoreUpdateRequestModel.overBowled=overNumber;
                          scoreUpdateRequestModel.totalOverBowled=0;
                          scoreUpdateRequestModel.outByPlayer=0;
                          scoreUpdateRequestModel.outPlayer=0;
                          scoreUpdateRequestModel.totalWicket=0;
                          scoreUpdateRequestModel.fieldingPositionsId=0;
                          scoreUpdateRequestModel.endInnings=false;
                          scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                          ScoringProvider().scoreUpdate(scoreUpdateRequestModel).then((value) async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('over_number', value.data!.overNumber??0);
                            await prefs.setInt('ball_number', value.data!.ballNumber??0);
                            await prefs.setInt('striker_id', value.data!.strikerId??0);
                            await prefs.setInt('non_striker_id', value.data!.nonStrikerId??0);
                            await prefs.setInt('bowler_change', value.data!.bowlerChange ?? 0);
                            await prefs.setInt('bowlerPosition',0);
                            Navigator.pop(context);
                          });

                        }else{
                          setState(() {
                            showError = true;
                          });
                          if (showError) {
                            Timer(const Duration(seconds: 4), () {
                              setState(() {
                                showError = false;
                              });
                            });
                          }

                        }
                      },child: const OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );

}

Future<void> _displayBottomSheetMoreRuns (int ballType,ScoringDetailResponseModel? scoringData) async{
  int? isOffSideSelected ;
  int? isWideSelected ;
  bool showError =false;
  List<Map<String, dynamic>> chipData =[
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
    },
    {
      'label': '6',
    },
    {
      'label': '7',
    },

  ];
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
        return Container(
          height: 35.h,
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
                    Text("More Runs",style: fontMedium.copyWith(
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
                padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                child: Wrap(
                  spacing: 10.w, // Horizontal spacing between items
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
                        backgroundColor: isWideSelected==index? AppColor.primaryColor : const Color(0xffF8F9FA),
                        // backgroundColor:AppColor.lightColor
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 1.5.h,),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: showError,
                        child: Text(
                          'Please Select One Option',
                          style: fontMedium.copyWith(color: AppColor.redColor),
                        ),
                      ),
                      GestureDetector(onTap:()async{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var overNumber= prefs.getInt('over_number');
                        var ballNumber= prefs.getInt('ball_number');
                        var strikerId=prefs.getInt('striker_id')??0;
                        var nonStrikerId=prefs.getInt('non_striker_id')??0;
                        var bowlerId=prefs.getInt('bowler_id')??0;
                        var keeperId=prefs.getInt('wicket_keeper_id')??0;
                        var bowlerPosition=prefs.getInt('bowlerPosition')??0;

                        if(isWideSelected !=null) {
                          ScoreUpdateRequestModel scoreUpdateRequestModel = ScoreUpdateRequestModel();
                          scoreUpdateRequestModel.ballTypeId = ballType ?? 0;
                          scoreUpdateRequestModel.matchId =
                              scoringData!.data!.batting![0].matchId;
                          scoreUpdateRequestModel.scorerId = 1;
                          scoreUpdateRequestModel.strikerId = strikerId;
                          scoreUpdateRequestModel.nonStrikerId = nonStrikerId;
                          scoreUpdateRequestModel.wicketKeeperId = keeperId;
                          scoreUpdateRequestModel.bowlerId = bowlerId;
                          scoreUpdateRequestModel.overNumber = overNumber;
                          scoreUpdateRequestModel.ballNumber = ballNumber;

                          scoreUpdateRequestModel.runsScored =
                          (isWideSelected == null) ? 0 : isWideSelected ??
                              0 + 1;
                          scoreUpdateRequestModel.extras =
                          (isWideSelected == null) ? 0 : isWideSelected ??
                              0 + 1;
                          scoreUpdateRequestModel.wicket = 0;
                          scoreUpdateRequestModel.dismissalType = 0;
                          scoreUpdateRequestModel.commentary = 0;
                          scoreUpdateRequestModel.innings = 1;
                          scoreUpdateRequestModel.battingTeamId =
                              scoringData!.data!.batting![0].teamId ?? 0;
                          scoreUpdateRequestModel.bowlingTeamId =
                              scoringData!.data!.bowling!.teamId ?? 0;
                          scoreUpdateRequestModel.overBowled=overNumber ;
                          scoreUpdateRequestModel.totalOverBowled = 0;
                          scoreUpdateRequestModel.outByPlayer = 0;
                          scoreUpdateRequestModel.outPlayer = 0;
                          scoreUpdateRequestModel.totalWicket = 0;
                          scoreUpdateRequestModel.fieldingPositionsId = 0;
                          scoreUpdateRequestModel.endInnings = false;
                          scoreUpdateRequestModel.bowlerPosition=bowlerPosition;
                          ScoringProvider()
                              .scoreUpdate(scoreUpdateRequestModel)
                              .then((value) async {
                            SharedPreferences prefs = await SharedPreferences
                                .getInstance();
                            await prefs.setInt(
                                'over_number', value.data!.overNumber ?? 0);
                            await prefs.setInt(
                                'ball_number', value.data!.ballNumber ?? 1);
                            await prefs.setInt(
                                'striker_id', value.data!.strikerId ?? 0);
                            await prefs.setInt('non_striker_id', value.data!.nonStrikerId ?? 0);
                            await prefs.setInt('bowler_change', value.data!.bowlerChange ?? 0);
                            await prefs.setInt('bowlerPosition',0);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
                              });
                          });
                        }else{
                                setState(() {
                                  showError = true;
                                });
                                if (showError) {
                                  Timer(const Duration(seconds: 4), () {
                                    setState(() {
                                      showError = false;
                                    });
                                  });
                                }
                        }

                      },child: const OkBtn("Save")),
                    ],
                  ),
                ),
              )

            ],
          ),
        );
      })
  );
}


Future<void> _displayBottomSheetSettings () async{
  bool value1=false;
  bool value2=false;
  bool value3=false;
  bool value4=false;
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

  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (context)=> StatefulBuilder(builder: (context, setState){
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
      })
  );

}

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


}


