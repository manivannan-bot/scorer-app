import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/models/all_matches_model.dart';
import 'package:scorer/provider/scoring_provider.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/widgets/do_scoring_btn.dart';
import 'package:sizer/sizer.dart';

import '../models/scoring_detail_response_model.dart';
import '../pages/score_update_screen.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import 'do_scoring.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {

  ScoringDetailResponseModel? scoringData;

  List<Matches>? matchlist=[];
  void initState() {
    super.initState();
   ScoringProvider().getAllMatches().then((value) {
     setState(() {
       matchlist=[];
       matchlist=value.matches;
     });
     _refreshData();
   } );
  }
  void _refreshData() {
    ScoringProvider().getScoringDetail(matchlist!.first.matchId.toString()).then((value) async {
      setState(() {
        scoringData = value;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    if(scoringData==null || scoringData!.data ==null|| matchlist!.isEmpty){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }

    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, _) {
          return Padding(
            padding: EdgeInsets.only(bottom: 2.h),
          );
        },
        itemCount:matchlist!.length ,
        itemBuilder: (context, int index) {
          final item = matchlist![index];
          return Padding(
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
                                     matchlist![index].team1Name??'',
                                       style: fontMedium.copyWith(
                                     fontSize: 13.sp,
                                     color: AppColor.pri,
                                   )
                                   ),
                                    SizedBox(width: 2.w,),
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: ('${matchlist![index].teams!.first.totalRuns??''}'),
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
                                              text: ("${matchlist![index].teams!.first.totalWickets??''}"),
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: AppColor.pri
                                              )),
                                        ])),
                                    SizedBox(width: 2.w,),
                                    RichText(text: TextSpan(children: [
                                          TextSpan(
                                              text: ("${matchlist![index].teams!.first.overNumber??''}.${matchlist![index].teams!.first.ballNumber??''}"),
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
                                              text: ("${matchlist![index].overs}"),
                                              style: fontMedium.copyWith(
                                                  fontSize: 13.sp,
                                                  color: const Color(0xff444444)
                                              )),
                                        ])),
                                    SizedBox(width: 1.w,),
                                    (matchlist![index].currentInnings==1)?SvgPicture.asset(Images.batIcon,width: 5.w,):const Text(''),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 2.w,top: 1.h),
                                child: Row(
                                  children: [
                                    Image.asset(Images.teamblogo,width: 10.w,fit: BoxFit.fill,),
                                    SizedBox(width: 2.w,),
                                    Text(" ${matchlist![index].team2Name??''}", style: fontMedium.copyWith(
                                      fontSize: 13.sp,
                                      color:const Color(0xff555555),
                                    ),),
                                    SizedBox(width: 2.w,),
                                    (matchlist![index].currentInnings==2)?
                                    Row(children: [
                                      RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: ('${matchlist![index].teams![1].totalRuns??''}'),
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
                                                text: ("${matchlist![index].teams![1].totalWickets??''}"),
                                                style: fontMedium.copyWith(
                                                    fontSize: 13.sp,
                                                    color: AppColor.pri
                                                )),
                                          ])),
                                      SizedBox(width: 2.w,),
                                      RichText(text: TextSpan(children: [
                                        TextSpan(
                                            text: ("${matchlist![index].teams![1].currentOverDetails??'0'}"),
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
                                            text: ("${matchlist![index].overs}"),
                                            style: fontMedium.copyWith(
                                                fontSize: 13.sp,
                                                color: const Color(0xff444444)
                                            )),
                                      ])),
                                      SizedBox(width: 1.w,),
                                    ],):Text("Yet to bat", style: fontRegular.copyWith(
                                      fontSize: 12.sp,
                                      color:const Color(0xff666666),
                                    ),),
                                    (matchlist![index].currentInnings==2)?SvgPicture.asset(Images.batIcon,width: 5.w,):const Text(''),
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
                                      if(matchlist!.first.currentInnings==1 ){
                                          if(((scoringData!.data!.batting!.length<2) || scoringData!.data!.bowling==null)){
                                                    if(matchlist!.first.wonBy==matchlist![index].team1Id && matchlist!.first.choseTo=='Bat' ) {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DOScoring(matchlist![index].matchId.toString(), matchlist![index].team1Id.toString(), matchlist![index].team2Id.toString())));
                                                    }else{
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DOScoring(matchlist![index].matchId.toString(), matchlist![index].team2Id.toString(),matchlist![index].team1Id.toString())));

                                                    }
                                              }else{
                                                if(matchlist!.first.wonBy==matchlist![index].team1Id && matchlist!.first.choseTo=='Bat' ) {

                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScoreUpdateScreen(matchlist!.first.matchId.toString(),matchlist!.first.team1Id.toString())));
                                                }else{
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScoreUpdateScreen(matchlist!.first.matchId.toString(),matchlist!.first.team2Id.toString())));

                                                }
                                            }
                                      }else if(matchlist!.first.currentInnings==2){
                                          if(((scoringData!.data!.batting!.length<2) || scoringData!.data!.bowling==null)){
                                            if(matchlist!.first.wonBy==matchlist![index].team1Id && matchlist!.first.choseTo=='Bat' ) {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => DOScoring(matchlist![index].matchId.toString(), matchlist![index].team1Id.toString(), matchlist![index].team2Id.toString())));
                                            }else{
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => DOScoring(matchlist![index].matchId.toString(), matchlist![index].team2Id.toString(),matchlist![index].team1Id.toString())));

                                            }
                                          }else{
                                            if(matchlist!.first.wonBy==matchlist![index].team1Id && matchlist!.first.choseTo=='Bat' ) {

                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ScoreUpdateScreen(matchlist!.first.matchId.toString(),matchlist!.first.team1Id.toString())));
                                            }else{
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ScoreUpdateScreen(matchlist!.first.matchId.toString(),matchlist!.first.team2Id.toString())));

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
                        child: Text('${matchlist![index].tossWinnerName} won the toss choose to ${matchlist![index].choseTo}',style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.pri
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
