import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:scorer/provider/scoring_provider.dart';
import 'package:scorer/widgets/cancel_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../models/score_update_request_model.dart';
import '../utils/colours.dart';
import '../utils/sizes.dart';
import '../widgets/ok_btn.dart';


class UndoScreen extends StatefulWidget {
  const UndoScreen({super.key});

  @override
  State<UndoScreen> createState() => _UndoScreenState();
}

class _UndoScreenState extends State<UndoScreen> {
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        height: 18.h,
        width: 80.w,
        decoration: BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("Undo",style: fontMedium.copyWith(
                fontSize: 17.sp,
                color: AppColor.blackColour,
              ),),
            ),
            SizedBox(height: 1.5.h,),
            Text("Are you sure ?",style: fontRegular.copyWith(
                fontSize: 11.sp,
                color: Color(0xff808080)
            ),),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CancelBtn("Cancel"),
                  SizedBox(width: 4.w,),
                  GestureDetector(onTap: ()async{
                    ScoreUpdateRequestModel? scoreUpdate = await retrieveScoreUpdateFromSharedPreferences();
                          if (scoreUpdate != null) {
                            scoreUpdate.ballTypeId = 31;
                            ScoringProvider().scoreUpdate(scoreUpdate).then((value)async {

                              ScoreUpdateRequestModel? scoreUpdate = await retrieveScoreUpdateFromSharedPreferences();
                              if(scoreUpdate!=null) {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                await prefs.setInt('over_number', scoreUpdate.overNumber??0);
                                await prefs.setInt('ball_number', scoreUpdate.ballNumber??0);
                                await prefs.setInt('striker_id', scoreUpdate.strikerId ?? 0);
                                await prefs.setInt('non_striker_id', scoreUpdate.nonStrikerId ?? 0);
                                await prefs.setInt('bowler_id', scoreUpdate.bowlerId ?? 0);
                                await prefs.setInt('wicket_keeper_id', scoreUpdate.wicketKeeperId ?? 0);
                                await prefs.setInt('bowlerPosition', 0);
                              }

                              Navigator.pop(context);
                            });
                          }
                    },
                      child: OkBtn("ok")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<ScoreUpdateRequestModel?> getOldScoreUpdateFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final oldScoreUpdateJson = prefs.getString('oldScoreUpdate');

    if (oldScoreUpdateJson != null) {
      final Map<String, dynamic> scoreData = json.decode(oldScoreUpdateJson);
      return ScoreUpdateRequestModel.fromJson(scoreData);
    } else {
      return null; // Handle the case where there is no old scoreUpdate in SharedPreferences.
    }
  }
  Future<ScoreUpdateRequestModel?> retrieveScoreUpdateFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final scoreUpdateJson = prefs.getString('scoreUpdate');

    if (scoreUpdateJson != null) {
      final Map<String, dynamic> scoreData = json.decode(scoreUpdateJson);
      return ScoreUpdateRequestModel.fromJson(scoreData);
    } else {
      return null;
    }
  }
}
