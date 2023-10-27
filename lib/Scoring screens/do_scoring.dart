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
  final String team2id; // Add team1id as a parameter
  const DOScoring(this.matchId, this.team1id, this.team2id, {super.key});

  @override
  State<DOScoring> createState() => _DOScoringState();
}

class _DOScoringState extends State<DOScoring> {
  List<BattingPlayers>? itemsBatsman = [];
  List<BowlingPlayers>? itemsBowler = [];
  List<WkPlayers>? itemsKeeper = [];
  List<BattingPlayers>? searchedBatsman = [];
  List<BowlingPlayers>? searchedBowler = [];
  List<WkPlayers>? searchedKeeper = [];
  int? selectedPlayer1;
  int? selectedBowler;
  int? selectedWicketKeeper;
  int? selectedPlayer2;
  String selectedPlayer1Name = "";
  String? selectedTeamName = "";
  String? selectedBTeamName = "";
  String selectedBowlerName = "";
  String? selectedPlayer2Name = '';
  String selectedWicketKeeperName = "";
  bool showError = false;

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedPlayer1 = null;
    selectedBowler = null;
    selectedPlayer2 = null;
    selectedWicketKeeper = null;
    _fetchPlayers(widget.matchId, widget.team1id, widget.team2id);
  }

  Future<void> _fetchPlayers(
      String matchId, String team1id, String team2id) async {
    // final response = await ScoringProvider().getPlayerList(matchId, team1id,'bat');
    // setState(() {
    //   items = response.battingPlayers;
    //   selectedTeamName= response.team!.teamName;
    //
    // });
  }
  onSearchBatsman(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedBatsman = itemsBatsman!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
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
  onSearchBowler(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedBowler = itemsBowler!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
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
  onSearchKeeper(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedKeeper = itemsKeeper!.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
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

  displayError() {
    setState(() {
      showError = true;
    });
    Timer(const Duration(seconds: 4), () {
      setState(() {
        showError = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8F9FA),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 7.w,
                        )),
                    Text(
                      "Start Innings",
                      style: fontMedium.copyWith(
                        fontSize: 18.sp,
                        color: AppColor.blackColour,
                      ),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ) +
                      EdgeInsets.only(top: 2.h, bottom: 3.h),
                  decoration: BoxDecoration(
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Batsman*",
                        style: fontMedium.copyWith(
                          fontSize: 16.sp,
                          color: AppColor.blackColour,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                ScoringProvider()
                                    .getPlayerList(
                                        widget.matchId, widget.team1id, 'bat')
                                    .then((value) {
                                  setState(() {
                                    searchedBatsman= value.battingPlayers;
                                    itemsBatsman = value.battingPlayers;
                                    selectedTeamName = value.team!.teamName;
                                  });
                                  _displayBottomSheet(context, selectedPlayer1,
                                      (newIndex) async {
                                    setState(() {
                                      selectedPlayer1 = newIndex;
                                      if (selectedPlayer1 != null) {
                                        selectedPlayer1Name =
                                            itemsBatsman![selectedPlayer1!].playerName ??
                                                "";
                                      }
                                    });
                                  });
                                });
                              },
                              child: ChooseContainer(selectedPlayer1 != null
                                  ? selectedPlayer1Name
                                  : "Striker")),
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                ScoringProvider()
                                    .getPlayerList(
                                        widget.matchId, widget.team1id, 'bat')
                                    .then((value) {
                                  setState(() {
                                    searchedBatsman= value.battingPlayers;
                                    itemsBatsman = value.battingPlayers;
                                    selectedTeamName = value.team!.teamName;
                                  });
                                  _displayPlayer2BottomSheet(
                                      context, selectedPlayer2, (newIndex) async {
                                    setState(() {
                                      selectedPlayer2 = newIndex;
                                      if (selectedPlayer2 != null) {
                                        selectedPlayer2Name =
                                            itemsBatsman![selectedPlayer2!].playerName ??
                                                "";
                                      }
                                    });
                                  });
                                });
                              },
                              child: ChooseContainer(selectedPlayer2 == null
                                  ? "Non-Stricker"
                                  : selectedPlayer2Name!)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ) +
                      EdgeInsets.only(top: 2.h, bottom: 3.h),
                  decoration: BoxDecoration(
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Bowler*",
                            style: fontMedium.copyWith(
                              fontSize: 16.sp,
                              color: AppColor.blackColour,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            "Wicket Keeper*",
                            style: fontMedium.copyWith(
                              fontSize: 16.sp,
                              color: AppColor.blackColour,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                ScoringProvider()
                                    .getPlayerList(
                                        widget.matchId, widget.team2id, 'bowl')
                                    .then((value) {
                                  setState(() {
                                    searchedBowler=value.bowlingPlayers;
                                    itemsBowler = value.bowlingPlayers;
                                    selectedBTeamName = value.team!.teamName;
                                  });
                                  _displayBowlerBottomSheet(
                                      context, selectedBowler,
                                      (bowlerIndex) async {
                                    setState(() {
                                      selectedBowler = bowlerIndex;
                                      if (selectedBowler != null) {
                                        selectedBowlerName =
                                            itemsBowler![selectedBowler!]
                                                    .playerName ??
                                                "";
                                      }
                                    });
                                  });
                                });
                              },
                              child: ChooseContainer(selectedBowler == null
                                  ? "Bowler"
                                  : selectedBowlerName)),
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                              onTap: () async {
                                await ScoringProvider()
                                    .getPlayerList(
                                        widget.matchId, widget.team2id, 'wk')
                                    .then((value) {
                                  setState(() {
                                    searchedKeeper=value.wkPlayers;
                                    itemsKeeper = value.wkPlayers;
                                    selectedBTeamName = value.team!.teamName;
                                  });
                                  _displayKeeperBottomSheet(
                                      context, selectedWicketKeeper,
                                      (bowlerIndex) async {
                                    setState(() {
                                      selectedWicketKeeper = bowlerIndex;
                                      if (selectedWicketKeeper != null) {
                                        selectedWicketKeeperName =
                                            itemsKeeper![selectedWicketKeeper!]
                                                    .playerName ??
                                                "";
                                      }
                                    });
                                  });
                                });
                              },
                              child: ChooseContainer(
                                  selectedWicketKeeper == null
                                      ? "Wicket Keeper"
                                      : selectedWicketKeeperName)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //cancel bt
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                decoration: const BoxDecoration(
                  color: AppColor.lightColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: showError,
                      child: Text(
                        'Please Select All Option',
                        style: fontMedium.copyWith(color: AppColor.redColor),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CancelBtn("Cancel")),
                    SizedBox(
                      width: 2.w,
                    ),
                    GestureDetector(
                        child: const OkBtn("Ok"),
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var strikerId = prefs.getInt('striker_id') ?? 0;
                          var nonStrikerId =
                              prefs.getInt('non_striker_id') ?? 0;
                          var bowlerId = prefs.getInt('bowler_id') ?? 0;
                          var keeperId = prefs.getInt('wicket_keeper_id') ?? 0;
                          if (strikerId == 0 ||
                              nonStrikerId == 0 ||
                              bowlerId == 0 ||
                              keeperId == 0) {
                            displayError();
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScoreUpdateScreen(
                                        widget.matchId, widget.team1id)));
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _displayBottomSheet(BuildContext context, int? initialSelectedIndex,
      Function(int?) onItemSelected) async {
    int? localSelectedIndex = initialSelectedIndex;
    isResultEmpty=true;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 90.h,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: const BoxDecoration(
                      color: AppColor.lightColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 7.w,
                                )),
                            Text(
                              "Select Striker",
                              style: fontMedium.copyWith(
                                fontSize: 18.sp,
                                color: AppColor.blackColour,
                              ),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffD3D3D3),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffF8F9FA),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.2.h),
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
                                      hintText: "Search for player",
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
                        child: Text(
                          '${selectedTeamName}',
                          style: fontMedium.copyWith(
                              fontSize: 14.sp, color: AppColor.pri),
                        ),
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
                      else if(!isResultEmpty && searching)...[Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, _) {
                            return const Divider(
                              thickness: 0.6,
                            );
                          },
                          itemCount: searchedBatsman!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (localSelectedIndex == index) {
                                    localSelectedIndex =
                                    null; // Deselect the item if it's already selected
                                  } else {
                                    localSelectedIndex =
                                        index; // Select the item if it's not selected
                                  }
                                  onItemSelected(localSelectedIndex);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.5.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    //circular button
                                    Container(
                                      height:
                                      20.0, // Adjust the height as needed
                                      width: 20.0, // Adjust the width as needed
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: localSelectedIndex == index
                                            ? Colors.blue
                                            : Colors
                                            .grey, // Change colors based on selected index
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons
                                              .circle_outlined, // You can change the icon as needed
                                          color: Colors.white, // Icon color
                                          size: 20.0, // Icon size
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Image.asset(
                                      Images.playersImage,
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${searchedBatsman![index].playerName ?? '-'}",
                                          style: fontMedium.copyWith(
                                            fontSize: 12.sp,
                                            color: AppColor.blackColour,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 1.h,
                                              width: 2.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                color: AppColor.pri,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              searchedBatsman![index].battingStyle ?? '-',
                                              style: fontMedium.copyWith(
                                                  fontSize: 11.sp,
                                                  color:
                                                  const Color(0xff555555)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),]
                      else...[Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, _) {
                              return const Divider(
                                thickness: 0.6,
                              );
                            },
                            itemCount: searchedBatsman!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (localSelectedIndex == index) {
                                      localSelectedIndex =
                                      null; // Deselect the item if it's already selected
                                    } else {
                                      localSelectedIndex =
                                          index; // Select the item if it's not selected
                                    }
                                    onItemSelected(localSelectedIndex);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w, vertical: 1.h),
                                  child: Row(
                                    children: [
                                      //circular button
                                      Container(
                                        height:
                                        20.0, // Adjust the height as needed
                                        width: 20.0, // Adjust the width as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: localSelectedIndex == index
                                              ? Colors.blue
                                              : Colors
                                              .grey, // Change colors based on selected index
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons
                                                .circle_outlined, // You can change the icon as needed
                                            color: Colors.white, // Icon color
                                            size: 20.0, // Icon size
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Image.asset(
                                        Images.playersImage,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${searchedBatsman![index].playerName ?? '-'}",
                                            style: fontMedium.copyWith(
                                              fontSize: 12.sp,
                                              color: AppColor.blackColour,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 1.h,
                                                width: 2.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  color: AppColor.pri,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                searchedBatsman![index].battingStyle ?? '-',
                                                style: fontMedium.copyWith(
                                                    fontSize: 11.sp,
                                                    color:
                                                    const Color(0xff555555)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),],

                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 5.w),
                        decoration: const BoxDecoration(
                          color: AppColor.lightColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const CancelBtn("Cancel")),
                            SizedBox(
                              width: 2.w,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (localSelectedIndex != null) {
                                    SaveBatsmanDetailRequestModel requestModel =
                                        SaveBatsmanDetailRequestModel(
                                      batsman: [
                                        Batsman(
                                            matchId: int.parse(widget.matchId),
                                            teamId: int.parse(widget.team1id),
                                            playerId:
                                            searchedBatsman![localSelectedIndex!]
                                                    .playerId,
                                            striker: true),
                                      ],
                                    );

                                    await ScoringProvider()
                                        .saveBatsman(requestModel);
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt('striker_id',
                                        searchedBatsman![selectedPlayer1!].playerId!);

                                    Navigator.pop(context);
                                  } else {
                                    displayError();
                                  }
                                },
                                child: const OkBtn("Ok")),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ));
  }

  _displayBowlerBottomSheet(BuildContext context, int? selectedBowler,
      Function(int?) onItemSelected) async {
    isResultEmpty=true;
    int? localBowlerIndex;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 90.h,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: const BoxDecoration(
                      color: AppColor.lightColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 7.w,
                                )),
                            Text(
                              "Select Bowler",
                              style: fontMedium.copyWith(
                                fontSize: 18.sp,
                                color: AppColor.blackColour,
                              ),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffD3D3D3),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffF8F9FA),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.2.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: searchController,
                                    cursorColor: AppColor.secondaryColor,
                                    onChanged: (value) {
                                      onSearchBowler(value);
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
                                      onSearchBowler(" ");
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
                        child: Text(
                          '${selectedBTeamName}',
                          style: fontMedium.copyWith(
                              fontSize: 14.sp, color: AppColor.pri),
                        ),
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
                      else if(!isResultEmpty && searching)...[Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, _) {
                            return const Divider(
                              thickness: 0.6,
                            );
                          },
                          itemCount: searchedBowler!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (localBowlerIndex == index) {
                                    localBowlerIndex =
                                    null; // Deselect the item if it's already selected
                                  } else {
                                    localBowlerIndex =
                                        index; // Select the item if it's not selected
                                  }
                                  onItemSelected(localBowlerIndex);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.5.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    //circular button
                                    Container(
                                      height:
                                      20.0, // Adjust the height as needed
                                      width: 20.0, // Adjust the width as needed
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: localBowlerIndex == index
                                            ? Colors.blue
                                            : Colors
                                            .grey, // Change colors based on selected index
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons
                                              .circle_outlined, // You can change the icon as needed
                                          color: Colors.white, // Icon color
                                          size: 20.0, // Icon size
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Image.asset(
                                      Images.playersImage,
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${searchedBowler![index].playerName ?? '-'}",
                                          style: fontMedium.copyWith(
                                            fontSize: 12.sp,
                                            color: AppColor.blackColour,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 1.h,
                                              width: 2.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                color: AppColor.pri,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              searchedBowler![index]
                                                  .battingStyle ??
                                                  '-',
                                              style: fontMedium.copyWith(
                                                  fontSize: 11.sp,
                                                  color:
                                                  const Color(0xff555555)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
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
                      ),]
                      else...[Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, _) {
                              return const Divider(
                                thickness: 0.6,
                              );
                            },
                            itemCount: searchedBowler!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (localBowlerIndex == index) {
                                      localBowlerIndex =
                                      null; // Deselect the item if it's already selected
                                    } else {
                                      localBowlerIndex =
                                          index; // Select the item if it's not selected
                                    }
                                    onItemSelected(localBowlerIndex);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w, vertical: 1.h),
                                  child: Row(
                                    children: [
                                      //circular button
                                      Container(
                                        height:
                                        20.0, // Adjust the height as needed
                                        width: 20.0, // Adjust the width as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: localBowlerIndex == index
                                              ? Colors.blue
                                              : Colors
                                              .grey, // Change colors based on selected index
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons
                                                .circle_outlined, // You can change the icon as needed
                                            color: Colors.white, // Icon color
                                            size: 20.0, // Icon size
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Image.asset(
                                        Images.playersImage,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${searchedBowler![index].playerName ?? '-'}",
                                            style: fontMedium.copyWith(
                                              fontSize: 12.sp,
                                              color: AppColor.blackColour,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 1.h,
                                                width: 2.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  color: AppColor.pri,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                searchedBowler![index]
                                                    .battingStyle ??
                                                    '-',
                                                style: fontMedium.copyWith(
                                                    fontSize: 11.sp,
                                                    color:
                                                    const Color(0xff555555)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
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
                        ),],

                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 5.w),
                        decoration: const BoxDecoration(
                          color: AppColor.lightColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const CancelBtn("Cancel")),
                            SizedBox(
                              width: 2.w,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (localBowlerIndex != null) {
                                    ScoringProvider().saveBowler(
                                        widget.matchId,
                                        widget.team2id,
                                        searchedBowler![localBowlerIndex!]
                                            .playerId
                                            .toString());
                                    Navigator.pop(context);
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt(
                                        'bowler_id',
                                        searchedBowler![localBowlerIndex!]
                                            .playerId!);
                                  } else {
                                    displayError();
                                  }
                                },
                                child: const OkBtn("Ok")),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ));
  }

  _displayKeeperBottomSheet(BuildContext context, int? selectedBowler,
      Function(int?) onItemSelected) async {
    int? localBowlerIndex;
    isResultEmpty=true;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 90.h,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: const BoxDecoration(
                      color: AppColor.lightColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 7.w,
                                )),
                            Text(
                              "Select Wicket Keeper",
                              style: fontMedium.copyWith(
                                fontSize: 18.sp,
                                color: AppColor.blackColour,
                              ),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffD3D3D3),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffF8F9FA),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.2.h),
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
                                      hintText: "Search for keeper",
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
                        child: Text(
                          '${selectedBTeamName}',
                          style: fontMedium.copyWith(
                              fontSize: 14.sp, color: AppColor.pri),
                        ),
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
                      else if(!isResultEmpty && searching)...[ Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, _) {
                            return const Divider(
                              thickness: 0.6,
                            );
                          },
                          itemCount: searchedKeeper!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (localBowlerIndex == index) {
                                    localBowlerIndex =
                                    null; // Deselect the item if it's already selected
                                  } else {
                                    localBowlerIndex =
                                        index; // Select the item if it's not selected
                                  }
                                  onItemSelected(localBowlerIndex);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.5.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    //circular button
                                    Container(
                                      height:
                                      20.0, // Adjust the height as needed
                                      width: 20.0, // Adjust the width as needed
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: localBowlerIndex == index
                                            ? Colors.blue
                                            : Colors
                                            .grey, // Change colors based on selected index
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons
                                              .circle_outlined, // You can change the icon as needed
                                          color: Colors.white, // Icon color
                                          size: 20.0, // Icon size
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Image.asset(
                                      Images.playersImage,
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${searchedKeeper![index].playerName ?? '-'}",
                                          style: fontMedium.copyWith(
                                            fontSize: 12.sp,
                                            color: AppColor.blackColour,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 1.h,
                                              width: 2.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                color: AppColor.pri,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              searchedKeeper![index]
                                                  .battingStyle ??
                                                  '-',
                                              style: fontMedium.copyWith(
                                                  fontSize: 11.sp,
                                                  color:
                                                  const Color(0xff555555)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),]
                      else...[ Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, _) {
                              return const Divider(
                                thickness: 0.6,
                              );
                            },
                            itemCount: searchedKeeper!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (localBowlerIndex == index) {
                                      localBowlerIndex =
                                      null; // Deselect the item if it's already selected
                                    } else {
                                      localBowlerIndex =
                                          index; // Select the item if it's not selected
                                    }
                                    onItemSelected(localBowlerIndex);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w, vertical: 1.h),
                                  child: Row(
                                    children: [
                                      //circular button
                                      Container(
                                        height:
                                        20.0, // Adjust the height as needed
                                        width: 20.0, // Adjust the width as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: localBowlerIndex == index
                                              ? Colors.blue
                                              : Colors
                                              .grey, // Change colors based on selected index
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons
                                                .circle_outlined, // You can change the icon as needed
                                            color: Colors.white, // Icon color
                                            size: 20.0, // Icon size
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Image.asset(
                                        Images.playersImage,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${searchedKeeper![index].playerName ?? '-'}",
                                            style: fontMedium.copyWith(
                                              fontSize: 12.sp,
                                              color: AppColor.blackColour,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 1.h,
                                                width: 2.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  color: AppColor.pri,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                searchedKeeper![index]
                                                    .battingStyle ??
                                                    '-',
                                                style: fontMedium.copyWith(
                                                    fontSize: 11.sp,
                                                    color:
                                                    const Color(0xff555555)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),],
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, _) {
                            return const Divider(
                              thickness: 0.6,
                            );
                          },
                          itemCount: searchedKeeper!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (localBowlerIndex == index) {
                                    localBowlerIndex =
                                        null; // Deselect the item if it's already selected
                                  } else {
                                    localBowlerIndex =
                                        index; // Select the item if it's not selected
                                  }
                                  onItemSelected(localBowlerIndex);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.5.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    //circular button
                                    Container(
                                      height:
                                          20.0, // Adjust the height as needed
                                      width: 20.0, // Adjust the width as needed
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: localBowlerIndex == index
                                            ? Colors.blue
                                            : Colors
                                                .grey, // Change colors based on selected index
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons
                                              .circle_outlined, // You can change the icon as needed
                                          color: Colors.white, // Icon color
                                          size: 20.0, // Icon size
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Image.asset(
                                      Images.playersImage,
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${searchedKeeper![index].playerName ?? '-'}",
                                          style: fontMedium.copyWith(
                                            fontSize: 12.sp,
                                            color: AppColor.blackColour,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 1.h,
                                              width: 2.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColor.pri,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              searchedKeeper![index]
                                                      .battingStyle ??
                                                  '-',
                                              style: fontMedium.copyWith(
                                                  fontSize: 11.sp,
                                                  color:
                                                      const Color(0xff555555)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 5.w),
                        decoration: const BoxDecoration(
                          color: AppColor.lightColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: showError,
                              child: Text(
                                'Please Select One Option',
                                style: fontMedium.copyWith(
                                    color: AppColor.redColor),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const CancelBtn("Cancel")),
                            SizedBox(
                              width: 2.w,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (localBowlerIndex != null) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt(
                                        'wicket_keeper_id',
                                        searchedKeeper![localBowlerIndex!]
                                            .playerId!);
                                    Navigator.pop(context);
                                  } else {
                                    displayError();
                                  }
                                },
                                child: const OkBtn("Ok")),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ));
  }

  _displayPlayer2BottomSheet(BuildContext context, int? initialSelectedIndex,
      Function(int?) onItemSelected) async {
    int? localSelectedIndex;
    isResultEmpty=true;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 90.h,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  decoration: const BoxDecoration(
                      color: AppColor.lightColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 7.w,
                                )),
                            Text(
                              "Select Non Striker",
                              style: fontMedium.copyWith(
                                fontSize: 18.sp,
                                color: AppColor.blackColour,
                              ),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffD3D3D3),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffF8F9FA),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.2.h),
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
                                      hintText: "Search for player",
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
                        child: Text(
                          '${selectedTeamName}',
                          style: fontMedium.copyWith(
                              fontSize: 14.sp, color: AppColor.pri),
                        ),
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
                          child: ListView.separated(
                            separatorBuilder: (context, _) {
                              return const Divider(
                                thickness: 0.6,
                              );
                            },
                            itemCount: searchedBatsman!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (localSelectedIndex == index) {
                                      localSelectedIndex =
                                      null; // Deselect the item if it's already selected
                                    } else {
                                      localSelectedIndex =
                                          index; // Select the item if it's not selected
                                    }
                                    onItemSelected(localSelectedIndex);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w, vertical: 1.h),
                                  child: Row(
                                    children: [
                                      //circular button
                                      Container(
                                        height:
                                        20.0, // Adjust the height as needed
                                        width: 20.0, // Adjust the width as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: localSelectedIndex == index
                                              ? Colors.blue
                                              : Colors
                                              .grey, // Change colors based on selected index
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons
                                                .circle_outlined, // You can change the icon as needed
                                            color: Colors.white, // Icon color
                                            size: 20.0, // Icon size
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Image.asset(
                                        Images.playersImage,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${searchedBatsman![index].playerName ?? '-'}",
                                            style: fontMedium.copyWith(
                                              fontSize: 12.sp,
                                              color: AppColor.blackColour,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 1.h,
                                                width: 2.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  color: AppColor.pri,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                searchedBatsman![index].battingStyle ?? '-',
                                                style: fontMedium.copyWith(
                                                    fontSize: 11.sp,
                                                    color:
                                                    const Color(0xff555555)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]else...[
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, _) {
                              return const Divider(
                                thickness: 0.6,
                              );
                            },
                            itemCount: searchedBatsman!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (localSelectedIndex == index) {
                                      localSelectedIndex =
                                      null; // Deselect the item if it's already selected
                                    } else {
                                      localSelectedIndex =
                                          index; // Select the item if it's not selected
                                    }
                                    onItemSelected(localSelectedIndex);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.5.w, vertical: 1.h),
                                  child: Row(
                                    children: [
                                      //circular button
                                      Container(
                                        height:
                                        20.0, // Adjust the height as needed
                                        width: 20.0, // Adjust the width as needed
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: localSelectedIndex == index
                                              ? Colors.blue
                                              : Colors
                                              .grey, // Change colors based on selected index
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons
                                                .circle_outlined, // You can change the icon as needed
                                            color: Colors.white, // Icon color
                                            size: 20.0, // Icon size
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Image.asset(
                                        Images.playersImage,
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${searchedBatsman![index].playerName ?? '-'}",
                                            style: fontMedium.copyWith(
                                              fontSize: 12.sp,
                                              color: AppColor.blackColour,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 1.h,
                                                width: 2.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(50),
                                                  color: AppColor.pri,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                searchedBatsman![index].battingStyle ?? '-',
                                                style: fontMedium.copyWith(
                                                    fontSize: 11.sp,
                                                    color:
                                                    const Color(0xff555555)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, _) {
                            return const Divider(
                              thickness: 0.6,
                            );
                          },
                          itemCount: searchedBatsman!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (localSelectedIndex == index) {
                                    localSelectedIndex =
                                        null; // Deselect the item if it's already selected
                                  } else {
                                    localSelectedIndex =
                                        index; // Select the item if it's not selected
                                  }
                                  onItemSelected(localSelectedIndex);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.5.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    //circular button
                                    Container(
                                      height:
                                          20.0, // Adjust the height as needed
                                      width: 20.0, // Adjust the width as needed
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: localSelectedIndex == index
                                            ? Colors.blue
                                            : Colors
                                                .grey, // Change colors based on selected index
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons
                                              .circle_outlined, // You can change the icon as needed
                                          color: Colors.white, // Icon color
                                          size: 20.0, // Icon size
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Image.asset(
                                      Images.playersImage,
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${searchedBatsman![index].playerName ?? '-'}",
                                          style: fontMedium.copyWith(
                                            fontSize: 12.sp,
                                            color: AppColor.blackColour,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 1.h,
                                              width: 2.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: AppColor.pri,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              searchedBatsman![index].battingStyle ?? '-',
                                              style: fontMedium.copyWith(
                                                  fontSize: 11.sp,
                                                  color:
                                                      const Color(0xff555555)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 5.w),
                        decoration: const BoxDecoration(
                          color: AppColor.lightColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: showError,
                              child: Text(
                                'Please Select One Option',
                                style: fontMedium.copyWith(
                                    color: AppColor.redColor),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const CancelBtn("Cancel")),
                            SizedBox(
                              width: 2.w,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (localSelectedIndex != null) {
                                    SaveBatsmanDetailRequestModel requestModel =
                                        SaveBatsmanDetailRequestModel(
                                      batsman: [
                                        Batsman(
                                            matchId: int.parse(widget.matchId),
                                            teamId: int.parse(widget.team1id),
                                            playerId:
                                                searchedBatsman![localSelectedIndex!]
                                                    .playerId,
                                            striker: false),
                                      ],
                                    );
                                    await ScoringProvider()
                                        .saveBatsman(requestModel);
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt('non_striker_id',
                                        searchedBatsman![localSelectedIndex!].playerId!);

                                    Navigator.pop(context);
                                  } else {
                                    displayError();
                                  }
                                },
                                child: const OkBtn("Ok")),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ));
  }


}
