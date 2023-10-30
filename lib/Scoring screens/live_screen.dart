import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/widgets/fading_entrances/fade_in.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scorer/models/all_matches_model.dart';
import 'package:scorer/provider/scoring_provider.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/widgets/do_scoring_btn.dart';
import 'package:sizer/sizer.dart';

import '../models/scoring_detail_response_model.dart';
import '../provider/player_selection_provider.dart';
import '../view/score_update_screen.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import 'do_scoring.dart';
import 'match_preview_bottom_sheet.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {

  ScoringDetailResponseModel? scoringData;

  List<Matches>? matchList=[];
  Future<List<Matches>?>? futureData;

  getData(){
    futureData = ScoringProvider().getAllMatches().then((value) {
      setState(() {
        matchList=[];
        matchList=value.matches;
      });
      _refreshData();
      return matchList;
    } );
  }

  void _refreshData() {
    ScoringProvider().getScoringDetail(matchList!.first.matchId.toString()).then((value) async {
      setState(() {
        scoringData = value;
      });

    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if(scoringData==null || scoringData!.data ==null){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }
    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return matchList!.isEmpty
          ? Text("No Live matches found",
          style: fontMedium.copyWith(
            color: AppColor.textColor,
            fontSize: 13.sp
          ),)
          : FadeIn(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                  );
                },
                itemCount:matchList!.length ,
                itemBuilder: (context, int index) {
                  final item = matchList![index];
                  return InkWell(
                    onTap: (){
                      _displayMatchPreviewBottomSheet(context);
                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 3.w),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.lightColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(left: 2.w,top: 1.h),
                                          child: Row(
                                            children: [
                                              Image.asset(Images.teamaLogo,width: 10.w,),
                                              SizedBox(width: 2.w,),
                                              Text(
                                                  matchList![index].team1Name??'',
                                                  style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: AppColor.pri,
                                                  )
                                              ),
                                              SizedBox(width: 2.w,),
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: ('${matchList![index].teams!.first.totalRuns??''}'),
                                                        style: fontMedium.copyWith(
                                                          fontSize: 13.sp,
                                                          color: AppColor.pri,
                                                        )),
                                                    TextSpan(
                                                        text: "/",
                                                        style: fontMedium.copyWith(
                                                            fontSize: 13.sp,
                                                            color: AppColor.pri
                                                        )),
                                                    TextSpan(
                                                        text: ("${matchList![index].teams!.first.totalWickets??''}"),
                                                        style: fontMedium.copyWith(
                                                            fontSize: 13.sp,
                                                            color: AppColor.pri
                                                        )),
                                                  ])),
                                              SizedBox(width: 2.w,),
                                              RichText(text: TextSpan(children: [
                                                TextSpan(
                                                    text: ("${matchList![index].teams!.first.overNumber??''}.${matchList![index].teams!.first.ballNumber??''}"),
                                                    style: fontMedium.copyWith(
                                                        fontSize: 13.sp,
                                                        color: const Color(0xff444444)
                                                    )),
                                                TextSpan(
                                                    text: "/",
                                                    style: fontMedium.copyWith(
                                                        fontSize: 13.sp,
                                                        color: const Color(0xff444444)
                                                    )),
                                                TextSpan(
                                                    text: matchList![index].overs,
                                                    style: fontMedium.copyWith(
                                                        fontSize: 13.sp,
                                                        color: const Color(0xff444444)
                                                    )),
                                              ])),
                                              SizedBox(width: 1.w,),
                                              if(matchList![index].currentInnings==1)...[
                                                SvgPicture.asset(Images.batIcon,width: 5.w,)
                                              ] else ...[
                                                const SizedBox()
                                              ],
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.w,top: 1.h),
                                          child: Row(
                                            children: [
                                              Image.asset(Images.teamblogo,width: 10.w,fit: BoxFit.fill,),
                                              SizedBox(width: 2.w,),
                                              Text(" ${matchList![index].team2Name??''}", style: fontMedium.copyWith(
                                                fontSize: 13.sp,
                                                color:const Color(0xff555555),
                                              ),),
                                              SizedBox(width: 2.w,),
                                              if(matchList![index].currentInnings==2) ...[
                                                Row(children: [
                                                  RichText(
                                                      text: TextSpan(children: [
                                                        TextSpan(
                                                            text: ('${matchList![index].teams!.last.totalRuns??''}'),
                                                            style: fontMedium.copyWith(
                                                              fontSize: 13.sp,
                                                              color: AppColor.pri,
                                                            )),
                                                        TextSpan(
                                                            text: "/",
                                                            style: fontMedium.copyWith(
                                                                fontSize: 13.sp,
                                                                color: AppColor.pri
                                                            )),
                                                        TextSpan(
                                                            text: ("${matchList![index].teams!.last.totalWickets??''}"),
                                                            style: fontMedium.copyWith(
                                                                fontSize: 13.sp,
                                                                color: AppColor.pri
                                                            )),
                                                      ])),
                                                  SizedBox(width: 2.w,),
                                                  RichText(text: TextSpan(children: [
                                                    TextSpan(
                                                        text: ("${matchList![index].teams!.last.currentOverDetails??'0'}"),
                                                        style: fontMedium.copyWith(
                                                            fontSize: 13.sp,
                                                            color: const Color(0xff444444)
                                                        )),
                                                    TextSpan(
                                                        text: "/",
                                                        style: fontMedium.copyWith(
                                                            fontSize: 13.sp,
                                                            color: const Color(0xff444444)
                                                        )),
                                                    TextSpan(
                                                        text: ("${matchList![index].overs}"),
                                                        style: fontMedium.copyWith(
                                                            fontSize: 13.sp,
                                                            color: const Color(0xff444444)
                                                        )),
                                                  ])),
                                                  SizedBox(width: 1.w,),
                                                ],)
                                              ] else ...[
                                                Text("Yet to bat", style: fontRegular.copyWith(
                                                  fontSize: 12.sp,
                                                  color:const Color(0xff666666),
                                                ),),
                                              ],
                                              if(matchList![index].currentInnings==2)...[
                                                SvgPicture.asset(Images.batIcon,width: 5.w,)
                                              ] else ...[
                                                const SizedBox()
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(top: 2.h),
                                      child: Dash(
                                          direction: Axis.vertical,
                                          length: 6.h,
                                          dashGap: 1,
                                          dashLength: 5,
                                          dashColor: const Color(0xffEFEAEA)),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 0.2.h
                                          ),
                                          decoration: const BoxDecoration(
                                              color: AppColor.primaryColor,
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(20))
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(Images.liveIcon,width: 2.5.w,),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text("Live",style: fontRegular.copyWith(
                                                fontSize: 10.5.sp,
                                                color: const Color(0xff444444),
                                              ),)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 1.w)+EdgeInsets.only(top: 2.h),
                                          child: GestureDetector(
                                              onTap: (){
                                                //if innings 1
                                                if(matchList!.first.currentInnings==1 ){
                                                  // if either striker or non striker or bowler is missing - select player screen
                                                  if(((scoringData!.data!.batting!.length<2) || scoringData!.data!.bowling==null)){
                                                    //if team 1 won the toss & chose to bat
                                                    if(matchList!.first.tossWonBy==matchList![index].team1Id && matchList!.first.choseTo=='Bat' ) {
                                                      Provider.of<PlayerSelectionProvider>(context, listen: false).clearAllSelectedIds();
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                          DOScoring(matchList![index].matchId.toString(),
                                                              matchList![index].team1Id.toString(),
                                                              matchList![index].team2Id.toString())))
                                                          .then((value) {getData();});
                                                    }else{ //if team 2 won the toss & chose to bat
                                                      Provider.of<PlayerSelectionProvider>(context, listen: false).clearAllSelectedIds();
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                          DOScoring(matchList![index].matchId.toString(),
                                                              matchList![index].team2Id.toString(),
                                                              matchList![index].team1Id.toString())))
                                                          .then((value) {getData();});
                                                    }
                                                  }
                                                  // if no striker or non striker or bowler is missing - all are there - directly score update screen
                                                  else{
                                                    //if team 1 won the toss & chose to bat
                                                    if(matchList!.first.tossWonBy==matchList![index].team1Id && matchList!.first.choseTo=='Bat' ) {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                          ScoreUpdateScreen(matchList!.first.matchId.toString(),
                                                              matchList!.first.team1Id.toString(),
                                                              matchList!.first.team2Id.toString()
                                                          )))
                                                          .then((value) {getData();});
                                                    }
                                                    //if team 2 won the toss & chose to bat
                                                    else{
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                          ScoreUpdateScreen(matchList!.first.matchId.toString(),
                                                              matchList!.first.team2Id.toString(),
                                                              matchList!.first.team1Id.toString()
                                                          )))
                                                          .then((value) {getData();});

                                                    }
                                                  }
                                                }
                                                //if innings 2 - same conditions as above
                                                else if(matchList!.first.currentInnings==2){
                                                  if(((scoringData!.data!.batting!.length<2) || scoringData!.data!.bowling==null)){
                                                    if(matchList!.first.tossWonBy==matchList![index].team1Id && matchList!.first.choseTo=='Bat' ) {
                                                      Provider.of<PlayerSelectionProvider>(context, listen: false).clearAllSelectedIds();
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                          DOScoring(matchList![index].matchId.toString(),
                                                              matchList![index].team1Id.toString(),
                                                              matchList![index].team2Id.toString())))
                                                          .then((value) {getData();});
                                                    }else{
                                                      Provider.of<PlayerSelectionProvider>(context, listen: false).clearAllSelectedIds();
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                          DOScoring(matchList![index].matchId.toString(),
                                                              matchList![index].team2Id.toString(),
                                                              matchList![index].team1Id.toString())))
                                                          .then((value) {getData();});
                                                    }
                                                  }else{
                                                    if(matchList!.first.tossWonBy==matchList![index].team1Id && matchList!.first.choseTo=='Bat' ) {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                          ScoreUpdateScreen(matchList!.first.matchId.toString(),
                                                              matchList!.first.team1Id.toString(),
                                                              matchList!.first.team2Id.toString()
                                                          )
                                                      ))
                                                          .then((value) {getData();});
                                                    }else{
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                          ScoreUpdateScreen(matchList!.first.matchId.toString(),
                                                              matchList!.first.team2Id.toString(),
                                                              matchList!.first.team1Id.toString()
                                                          )
                                                      ))
                                                          .then((value) {getData();});

                                                    }
                                                  }
                                                }

                                              },
                                              child: const DoScoringBtn()),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h,),
                                const DottedLine(
                                  dashColor: Color(0xffD2D2D2),
                                ),
                                SizedBox(height: 1.h,),
                                //toss line
                                Padding(
                                  padding:  EdgeInsets.only(left: 2.w,bottom: 1.h),
                                  child: Text('${matchList![index].tossWinnerName} won the toss choose to ${matchList![index].choseTo}',style: fontRegular.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColor.pri
                                  ),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

      }
    );
  }

  Future<void> _displayMatchPreviewBottomSheet (BuildContext context) async{
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context)=> StatefulBuilder(builder: (context, setState){
          return const MatchPreviewBottomSheet();
        })
    );
  }
}
