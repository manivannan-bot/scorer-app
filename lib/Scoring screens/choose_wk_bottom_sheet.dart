import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorer/provider/player_selection_provider.dart';
import 'package:scorer/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';

import '../models/player_list_model.dart';
import '../provider/scoring_provider.dart';
import '../utils/colours.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';
import '../view/widgets/player_list_item.dart';
import '../widgets/cancel_btn.dart';
import '../widgets/ok_btn.dart';

class ChooseWicketKeeperBottomSheet extends StatefulWidget {
  final String matchId, teamId, teamName;
  const ChooseWicketKeeperBottomSheet(this.matchId, this.teamId, this.teamName, {super.key});

  @override
  State<ChooseWicketKeeperBottomSheet> createState() => _ChooseWicketKeeperBottomSheetState();
}

class _ChooseWicketKeeperBottomSheetState extends State<ChooseWicketKeeperBottomSheet> {

  List<WkPlayers> wkPlayers = [];
  Future<List<WkPlayers>?>? futureData;
  String teamName = "";

  bool searching = false;
  bool isResultEmpty = false;
  String searchedText = "";
  TextEditingController searchController = TextEditingController();
  List<WkPlayers>? searchedWicketKeeper = [];

  int localSelectedIndex = -1;
  String playerId = "", playerName = "";

  onSearchWicketKeeper(String search) {
    setState(() {
      searching = true;
      searchedText = search;
      searchedWicketKeeper = wkPlayers.where((player) => player.playerName!.toLowerCase().toString().contains(search.toLowerCase())).toList();
      if (searchedWicketKeeper!.isEmpty) {
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

  getData(){
    futureData = ScoringProvider()
        .getPlayerList(
        widget.matchId, widget.teamId, 'wk')
        .then((value) {
      setState(() {
        wkPlayers = value.wkPlayers!;
        teamName = value.team!.teamName.toString();
      });
      return value.wkPlayers;
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
                          onSearchWicketKeeper(value);
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
                          hintText: "Search for wicket keeper",
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
                          onSearchWicketKeeper(" ");
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
              widget.teamName,
              style: fontMedium.copyWith(
                  fontSize: 14.sp, color: AppColor.pri),
            ),
          ),
          // const Divider(
          //   thickness: 0.5,
          //   color: Color(0xffD3D3D3),
          // ),
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
            child: FadeIn(
              child: ListView.builder(
                itemCount: searchedWicketKeeper!.length,
                itemBuilder: (context, index) {
                  final player = searchedWicketKeeper![index];
                  return Consumer<PlayerSelectionProvider>(
                    builder: (context, id, child) {
                      if(id.selectedBowlerId == player.playerId.toString()){
                        return const SizedBox();
                      } else {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              playerId = player.playerId.toString();
                              playerName = player.playerName.toString();
                              if (localSelectedIndex == index) {
                                localSelectedIndex = 0; // Deselect the item if it's already selected
                              } else {
                                localSelectedIndex = index; // Select the item if it's not selected
                              }
                            });
                          },
                          child: PlayerListItem(
                              index,
                              localSelectedIndex,
                              searchedWicketKeeper![index].playerName,
                              searchedWicketKeeper![index].battingStyle
                          )
                        );
                      }
                    }
                  );
                },
              ),
            ),
          ),]
          else if(isResultEmpty || !searching)...[
            Expanded(
              child: FutureBuilder(
                future: futureData,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.connectionState == ConnectionState.done){
                    return FadeIn(
                      child: ListView.builder(
                        itemCount: wkPlayers.length,
                        itemBuilder: (context, index) {
                          final player = wkPlayers[index];
                          return Consumer<PlayerSelectionProvider>(
                            builder: (context, id, child) {
                              if(id.selectedBowlerId == player.playerId.toString()){
                                return const SizedBox();
                              } else {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      playerId = player.playerId.toString();
                                      playerName = player.playerName.toString();
                                      if (localSelectedIndex == index) {
                                        localSelectedIndex = 0; // Deselect the item if it's already selected
                                      } else {
                                        localSelectedIndex = index; // Select the item if it's not selected
                                      }
                                    });
                                  },
                                  child: PlayerListItem(
                                      index,
                                      localSelectedIndex,
                                      wkPlayers[index].playerName,
                                      wkPlayers[index].battingStyle
                                  )
                                );
                              }
                            }
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }
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
                      if (playerId != "") {
                        //setting wicket keeper id when starting innings
                        Provider.of<PlayerSelectionProvider>(context, listen: false).setWicketKeeperId(playerId.toString(), playerName.toString());
                        Navigator.pop(context);
                      } else {
                        Dialogs.snackBar("Choose a wicket keeper", context, isError: true);
                        // displayError();
                      }
                    },
                    child: const OkBtn("Ok")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
