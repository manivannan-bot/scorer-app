import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:scorer/provider/scoring_provider.dart';
import 'package:scorer/scorecardScreens/scorecard_one.dart';
import 'package:scorer/scorecardScreens/scorecard_two.dart';
import 'package:scorer/utils/colours.dart';
import 'package:scorer/utils/sizes.dart';
import 'package:sizer/sizer.dart';

import '../Scoring screens/home_tab.dart';
import '../models/get_live_score_model.dart';
import '../models/score_card_response_model.dart';


class ScorecardScreen extends StatefulWidget {
  final String matchId;
  final String team1Id;
  final String team2Id;
  final String currentInning;
  final VoidCallback fetchData;
  const ScorecardScreen(this.matchId,this.team1Id,this.team2Id,this.currentInning,this.fetchData,{super.key});

  @override
  State<ScorecardScreen> createState() => _ScorecardScreenState();
}

class _ScorecardScreenState extends State<ScorecardScreen>with SingleTickerProviderStateMixin{
  late TabController tabController;
   ScoreCardResponseModel? scoreCardResponseModel;
  ScoreCardResponseModel? scoreCardResponseModel1;
  Matches? matchlist;
  List<TeamsName>?teams;
  int? batTeamId;
  int? bowlTeamId;
  int currentInning=1;
  var CRR;
  var RRR;
  var TARGET;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

  void fetchData()async{
                await ScoringProvider().getLiveScore(widget.matchId, widget.team1Id).then((data) async{
                  if(mounted){
                    setState(() {
                      matchlist = data.matches;

                      if(matchlist!.currentInnings==1){
                        if(matchlist!.tossWonBy==int.parse(widget.team1Id) && matchlist!.choseTo=='Bat' ) {
                          batTeamId=data.matches!.team1Id;
                          bowlTeamId=data.matches!.team2Id;
                        }else{
                          batTeamId=data.matches!.team2Id;
                          bowlTeamId=data.matches!.team1Id;
                        }
                      }else if(matchlist!.currentInnings==2){
                        if(matchlist!.tossWonBy==int.parse(widget.team2Id) && matchlist!.choseTo=='Bat' ) {
                          batTeamId=data.matches!.team2Id;
                          bowlTeamId=data.matches!.team1Id;
                        }else{
                          batTeamId=data.matches!.team1Id;
                          bowlTeamId=data.matches!.team2Id;
                        }
                      }
                    });
                  }
                });

        ScoringProvider().getScoreCard(widget.matchId, widget.team1Id).then((value){
          setState(() {
            scoreCardResponseModel=value;
          });

             if(widget.currentInning=='2'){
               ScoringProvider().getScoreCard(widget.matchId, widget.team2Id).then((value) {
                 setState(() {
                   scoreCardResponseModel1=value;
                 });
               });
             }

        });
  }

  @override
  Widget build(BuildContext context) {
    if(scoreCardResponseModel==null){
      return const SizedBox(
          height: 100,
          width: 100,
          child: Center(child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          )));
    }
    if(scoreCardResponseModel!.data==null){
      return const Center(child: Text('No data found'),);
    }
    if(scoreCardResponseModel!=null){
       teams= scoreCardResponseModel!.data!.teamsName;
       if(scoreCardResponseModel!.data!.currRunRate!=null){
         CRR=scoreCardResponseModel!.data!.currRunRate!.runRate;
         RRR=scoreCardResponseModel!.data!.currRunRate!.reqRunRate;
         TARGET=scoreCardResponseModel!.data!.currRunRate!.targetScore;
         if(tabController.index==1){
           setState(() {
             CRR=scoreCardResponseModel1!.data!.currRunRate!.runRate;
             RRR=scoreCardResponseModel1!.data!.currRunRate!.reqRunRate;
           });

         }

       }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 6.w),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
              color: AppColor.blackColour,
            ),
            child: (scoreCardResponseModel!.data!.currRunRate!=null)?Row(
              children:[
                Text("CRR: ${CRR??'-'}",style: fontMedium.copyWith(
                fontSize: 10.sp,
                color: AppColor.lightColor,
              ),),
                (teams!.first.currentInnings==2)?Row(children: [
                  SizedBox(width: 2.w,),
                  Text("RRR: ${RRR??'-'}",style: fontMedium.copyWith(
                    fontSize: 10.sp,
                    color: AppColor.lightColor,
                  ),),
                  SizedBox(width: 40.w,),
                  Text("Target: ${TARGET??'-'}",style: fontMedium.copyWith(
                    fontSize: 10.sp,
                    color: AppColor.lightColor,
                  ),),],):const Text('')
              ]
            ):Text(''),
          ),
          SizedBox(height: 1.h,),
          TabBar(
              labelPadding: EdgeInsets.symmetric(vertical: 0.1.h,horizontal: 5.w),
              labelColor: Colors.white,
              isScrollable: true,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColor.primaryColor
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: tabController,
              tabs: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 04.w,vertical: 0.4.h),
                  child: Text('${teams!.first.team1Name}',style: fontMedium.copyWith(fontSize: 13.sp,color: AppColor.blackColour),),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text('${teams!.first.team2Name} ${teams!.first.currentInnings==1?'Yet to bat':''}',style: fontMedium.copyWith(fontSize: 13.sp,color: AppColor.blackColour),),
                ),
              ]
          ),
          SizedBox(height: 1.h,),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children:  [
                  ScoreCardOne(scoreCardResponseModel!.data!),
                  if(teams!.first.currentInnings==1)...[
                    ScoreCardTwo(widget.matchId,bowlTeamId.toString()),]
                  else if(scoreCardResponseModel1!=null)...[
                       if(scoreCardResponseModel1!.data!=null)...[
                         ScoreCardOne(scoreCardResponseModel1!.data!),
                       ]else...[
                         ScoreCardTwo(widget.matchId,bowlTeamId.toString()),
                       ]
                  ]else...[
                    ScoreCardTwo(widget.matchId,bowlTeamId.toString()),
                  ]

                ]),
          ),
        ],
      ),
    );
  }
}
