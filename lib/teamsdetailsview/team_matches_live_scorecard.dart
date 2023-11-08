import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorer/models/score_card_response_model.dart';
import 'package:scorer/utils/colours.dart';
import 'package:sizer/sizer.dart';

import '../provider/scoring_provider.dart';
import '../utils/images.dart';
import '../utils/sizes.dart';

class TeamLiveScoreCard extends StatefulWidget {
  final String matchId;
  final String team1Id;
  final String team2Id;
  const TeamLiveScoreCard(this.matchId,this.team1Id,this.team2Id, {super.key});

  @override
  State<TeamLiveScoreCard> createState() => _TeamLiveScoreCardState();
}

class _TeamLiveScoreCardState extends State<TeamLiveScoreCard> {

  Data? scoreCardData;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  fetchData() async {
     await ScoringProvider().getScoreCard(widget.matchId, widget.team1Id).then((data) async{

      setState(() {
       scoreCardData =data.data;
      });
  });
         }

  @override
  Widget build(BuildContext context) {
    if(scoreCardData==null){
      // return const SizedBox(height: 100,width: 100,
      //     child: Center(child: CircularProgressIndicator(),));
      return const Center(child: Text('No data found'),);
    }
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 4.w),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 6.w),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
              color: AppColor.blackColour,
            ),
            child: Text("CRR: ${scoreCardData!.currRunRate!.runRate??'-'}",style: fontMedium.copyWith(
              fontSize: 10.sp,
              color: AppColor.lightColor,
            ),),
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              Text("Batting",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(width: 1.w,),
              SvgPicture.asset(Images.batIcon,width: 5.w,),
            ],
          ),
          SizedBox(height: 2.h,),
          Row(
            children: [
              SizedBox(
                width: 35.w,
                child: Text("Batsman",style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.pri,
                ),),
              ),
              SizedBox(width: 5.w,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("R",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("B",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("4s",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("6s",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("SR",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          (scoreCardData!.batting!.isNotEmpty)?ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                );
              },
              itemCount: scoreCardData!.batting!.length,
              itemBuilder: (context, int index) {
                final item = scoreCardData!.batting![index];
                if(item.isOut!=1){
                return Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${item.playerName}",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              SizedBox(width: 1.w,),
                              (item.isOut!=1)?
                              SvgPicture.asset(Images.batIcon,width: 4.w,color: AppColor.blackColour,):Text(''),
                            ],
                          ),
                          SizedBox(height: 0.5.h,),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: ("c ${item.wicketerName}\n"),
                                    style: fontRegular.copyWith(
                                      fontSize: 11.sp,
                                      color: const Color(0xff777777),
                                    )),
                                TextSpan(
                                    text: "b ${item.wicketBowlerName}",
                                    style: fontRegular.copyWith(
                                        fontSize: 11.sp,
                                        color: const Color(0xff777777)
                                    )),
                              ])),
                          SizedBox(height: 1.h,),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${item.runsScored}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("${item.ballsFaced}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("${item.fours}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("${item.sixes}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("${item.strikeRate}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                        ],
                      ),
                    ),
                  ],
                );}
              }):const Text('No data found'),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          Row(
            children: [
              SizedBox(
                width: 35.w,
                child: Text("Extras:",style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.blackColour,
                ),),
              ),
              const Spacer(),
              Row(
                children: [
                  Text("${scoreCardData!.bowlingExtras!.totalExtras}",style: fontMedium.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.blackColour,
                  ),),
                  SizedBox(width: 2.w,),
                  Text("${scoreCardData!.bowlingExtras!.legByes}lb,",style: fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff777777),
                  ),),
                  SizedBox(width: 2.w,),
                  Text("${scoreCardData!.bowlingExtras!.wides}w,",style: fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff777777),
                  ),),
                  SizedBox(width: 2.w,),
                  Text("${scoreCardData!.bowlingExtras!.noBalls}nb",style: fontRegular.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff777777),
                  ),),
                ],
              ),
            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 1.h,),



          //yet to bat
          Row(
            children: [
              Text("Yet to bat",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(width: 1.w,),
              SvgPicture.asset(Images.helmetIcon,width: 5.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 1 column
              childAspectRatio: 2.5, // Adjust the aspect ratio as needed
            ),
            itemCount: scoreCardData!.yetToBatPlayers!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {

              final item = scoreCardData!.yetToBatPlayers![index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(child: Image.asset(Images.profileImage,width: 12.w,)),
                  SizedBox(width: 2.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 30.w,
                        child: Text("${item.playerName}",style: fontRegular.copyWith(
                          fontSize: 12.sp,
                          color: AppColor.blackColour,
                        ),),
                      ),
                      (item.battingStyle!=null)?Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.pri,
                            radius: 4,
                          ),
                          SizedBox(width: 1.w,),
                          Text("${item.battingStyle}",style: fontRegular.copyWith(
                              fontSize: 11.sp,
                              color: Color(0xff666666)
                          ),),
                        ],
                      ):Text('')
                    ],
                  ),

                ],
              );
            },
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 2.h,),



          //bowling
          Row(
            children: [
              Text("Bowling",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(width: 1.w,),
              SvgPicture.asset(Images.ballIcon,width: 5.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              SizedBox(
                width: 35.w,
                child: Text("Bowling",style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.pri,
                ),),
              ),
              SizedBox(width: 5.w,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("O",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("M",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("R",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("W",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("Eco",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                );
              },
              itemCount: scoreCardData!.bowling!.length,
              itemBuilder: (BuildContext, int index) {

                final item = scoreCardData!.bowling![index];
                return Row(
                  children: [
                    SizedBox(
                      width: 35.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.5.h),
                                child: Text("${item.playerName}",style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                              ),
                              SizedBox(width: 1.w,),
                              (item.active==1)?
                              SvgPicture.asset(Images.ballBlackIcon,width: 4.w,color: AppColor.blackColour,):Text(''),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${item.overBall}",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                          Text("${item.maiden}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("${item.runsConceded}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                          Text("${item.wickets}",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                          Text("${item.economy}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 2.h,),



          //fall of wickets
          Row(
            children: [
              Text("Fall of wickets",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(width: 1.w,),
              SvgPicture.asset(Images.stupmsIconss,width: 5.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              SizedBox(
                width: 50.w,
                child: Text("Bowling",style: fontRegular.copyWith(
                  fontSize: 12.sp,
                  color: AppColor.pri,
                ),),
              ),
              SizedBox(width: 5.w,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Score",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                    Text("Over",style: fontRegular.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xff777777),
                    ),),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                );
              },
              itemCount: scoreCardData!.fallOfWicket!.length,
              itemBuilder: (BuildContext, int index) {
                if(scoreCardData!.fallOfWicket!.isEmpty){
                  return Text('No data found');
                }
                final item =scoreCardData!.fallOfWicket![index];
                return Row(
                  children: [
                    SizedBox(
                      width: 50.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: 0.5.h,bottom: 0.5.h),
                                child: Text("${item.playerOutName}",style: fontRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor.blackColour,
                                ),),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${item.teamScore}",style: fontMedium.copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackColour,
                          ),),
                          Text("${item.over}",style: fontRegular.copyWith(
                            fontSize: 12.sp,
                            color: const Color(0xff777777),
                          ),),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          SizedBox(height: 2.h,),


          //patrnership
          Row(
            children: [
              Text("Partnerships",style: fontMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor.blackColour,
              ),),
              SizedBox(width: 1.w,),
              SvgPicture.asset(Images.partnerShipIcon,width: 5.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          Row(
            children: [
              Text("Batsman 1",style: fontRegular.copyWith(
                fontSize: 12.sp,
                color: AppColor.pri,
              ),),
              Spacer(),
              Text("Batsman 2",style: fontRegular.copyWith(
                fontSize: 12.sp,
                color: AppColor.pri,
              ),),


            ],
          ),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const DottedLine(
                    dashColor: Color(0xffD2D2D2),
                  ),
                );
              },
              itemCount: scoreCardData!.partnerships!.length,
              itemBuilder: (BuildContext, int index) {
                if(scoreCardData!.partnerships!.isEmpty){
                  return Text('No data found');
                }
                final item = scoreCardData!.partnerships![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 0.5.h,bottom: 1.h),
                      child: Row(
                        children: [
                          Text("1st",style: fontRegular.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          ),),
                          SizedBox(width: 1.w,),
                          Text("Wicket",style: fontRegular.copyWith(
                              fontSize: 12.sp,
                              color: Color(0xff666666)
                          ),),

                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 0.5.h,bottom: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("${item.player1Name}",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              SizedBox(height: 0.5.h),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ("${item.player1BallsFaced}"),
                                        style: fontMedium.copyWith(
                                            fontSize: 11.sp,
                                            color: AppColor.blackColour
                                        )),
                                    TextSpan(
                                        text: "(${item.player1RunsScored})",
                                        style: fontRegular.copyWith(
                                            fontSize: 11.sp,
                                            color: const Color(0xff666666)
                                        )),
                                  ])),
                            ],
                          ),
                          Column(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ("${item.totalRunsScored}"),
                                        style: fontMedium.copyWith(
                                            fontSize: 11.sp,
                                            color: AppColor.blackColour
                                        )),
                                    TextSpan(
                                        text: "(${item.totalBallsFaced})",
                                        style: fontRegular.copyWith(
                                            fontSize: 11.sp,
                                            color: const Color(0xff666666)
                                        )),
                                  ])),
                              SizedBox(height: 0.5.h),
                              Container(
                                height:1.h,
                                width:10.w,
                                decoration: BoxDecoration(
                                  color: AppColor.pri,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text("${item.player2Name}",style: fontRegular.copyWith(
                                fontSize: 12.sp,
                                color: AppColor.blackColour,
                              ),),
                              SizedBox(height: 0.5.h),
                              RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: ("${item.player2BallsFaced}"),
                                        style: fontMedium.copyWith(
                                            fontSize: 11.sp,
                                            color: AppColor.blackColour
                                        )),
                                    TextSpan(
                                        text: "(${item.player2RunsScored})",
                                        style: fontRegular.copyWith(
                                            fontSize: 11.sp,
                                            color: const Color(0xff666666)
                                        )),
                                  ])),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                );
              }),
          const Divider(
            color: Color(0xffD3D3D3),
          ),
        ],
      ),
    );
  }
}
