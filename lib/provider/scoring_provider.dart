import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/all_matches_model.dart';
import '../models/end_innings_response_model.dart';
import '../models/get_ball_type_response_model.dart';
import '../models/get_live_score_model.dart';
import '../models/player_list_model.dart';
import '../models/save_batsman_request_model.dart';
import '../models/save_batsman_response_model.dart';
import '../models/save_bowler_response_model.dart';
import '../models/score_card_response_model.dart';
import '../models/score_update_request_model.dart';
import '../models/score_update_response_model.dart';
import '../models/scoring_detail_response_model.dart';
import '../utils/app_constants.dart';

class ScoringProvider extends ChangeNotifier{

  AllMatchesModel allMatchesModel =AllMatchesModel();

  PlayerListModel playerListModel = PlayerListModel();
  SaveBatsmanResponseModel saveBatsmanResponseModel =SaveBatsmanResponseModel();

  SaveBowlerResponseModel saveBowlerResponseModel = SaveBowlerResponseModel();

  GetLiveScoreResponseModel getLiveScoreResponseModel=GetLiveScoreResponseModel();

  ScoringDetailResponseModel scoringDetailResponseModel=ScoringDetailResponseModel();

  ScoreUpdateResponseModel scoreUpdateResponseModel=ScoreUpdateResponseModel();

  GetBallTypeResponseModel getBallTypeResponseModel=GetBallTypeResponseModel();

  EndInningsResponseModel endInningsResponseModel=EndInningsResponseModel();

  ScoreCardResponseModel scoreCardResponseModel=ScoreCardResponseModel();

  String overNumber = "";

  storeOverNumber(String value){
    overNumber = value;
    notifyListeners();
  }

  Future<AllMatchesModel> getAllMatches() async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.Allmatches),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        allMatchesModel = AllMatchesModel.fromJson(decodedJson);

        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('All Matches  - Invalid data format');
    } catch (e) {
      print(e);
    }
    return allMatchesModel;
  }


  Future<GetLiveScoreResponseModel> getLiveScore(String matchId,String teamId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.getLiveScore}/$matchId/$teamId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        getLiveScoreResponseModel = GetLiveScoreResponseModel.fromJson(decodedJson);

        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('All Matches  - Invalid data format');
    } catch (e) {
      print(e);
    }
    return getLiveScoreResponseModel;
  }


  Future<PlayerListModel> getPlayerList(String matchid,String teamid,String option) async{
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    // print("usertoken $accToken");
    playerListModel = PlayerListModel();
    notifyListeners();
    try {
      final String baseUrl = "${AppConstants.getPlayerList}/$matchid/$teamid/$option";
      // final Map<String, String> queryParams = {
      //   'api_token': accToken.toString(),
      // };
      final Uri uri = Uri.parse(baseUrl);
      final response = await http.get(uri);
      // final response = await http.get(
      //   Uri.parse(AppConstants.getUserData),
      //   headers: {
      //     'Content-Type': 'application/json; charset=UTF-8',
      //     'Authorization': 'Bearer $accToken',
      //   },
      // );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        playerListModel = PlayerListModel.fromJson(decodedJson);

        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Acceptorders - Invalid data format');
    } catch (e) {
      print(e);
    }
    return playerListModel ;
  }

  //save batsman

  Future<SaveBatsmanResponseModel> saveBatsman( SaveBatsmanDetailRequestModel batsman) async {
    var body = json.encode(batsman);
    print('${batsman.batsman},${batsman.batsman!.first.matchId},${batsman.batsman!.first.teamId}');
    try {
      final response = await http.post(
        Uri.parse(AppConstants.saveBatsman),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        saveBatsmanResponseModel = SaveBatsmanResponseModel.fromJson(decodedJson);
        // token = loginModel.token.toString();
        // saveUserData(true, token);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Batsman save- Invalid data format');
    } catch (e) {
      print(e);
    }
    return saveBatsmanResponseModel;
  }


  //save bowler

  Future<SaveBowlerResponseModel> saveBowler(String matchid, String teamid, String playerid) async {
    var body = jsonEncode({
      'match_id':matchid ,
      'team_id': teamid,
      "player_id":playerid,
    });
    try {
      final response = await http.post(
        Uri.parse(AppConstants.saveBowler),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        saveBowlerResponseModel = SaveBowlerResponseModel.fromJson(decodedJson);
        // token = loginModel.token.toString();
        // saveUserData(true, token);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('organizer login- Invalid data format');
    } catch (e) {
      print(e);
    }
    return saveBowlerResponseModel;
  }

  Future<ScoringDetailResponseModel> getScoringDetail(String matchId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.scoringDetail}/$matchId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        scoringDetailResponseModel = ScoringDetailResponseModel.fromJson(decodedJson);

        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('All Matches  - Invalid data format');
    } catch (e) {
      print(e);
    }
    return scoringDetailResponseModel;
  }

//score update
  Future<ScoreUpdateResponseModel> scoreUpdate( ScoreUpdateRequestModel scoreUpdate) async {
    var body = json.encode(scoreUpdate);
    // final firestoreInstance = FirebaseFirestore.instance;
    // await firestoreInstance.collection('scores').doc('model').set(scoreUpdate.toJson());
    final realTimeDatabaseInstance = FirebaseDatabase.instance;
    await realTimeDatabaseInstance.ref('scores/model').set(scoreUpdate.toJson());

    print(json.decode(body));
    try {


      final response = await http.post(
        Uri.parse(AppConstants.scoreUpdate),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        scoreUpdateResponseModel = ScoreUpdateResponseModel.fromJson(decodedJson);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Batsman save- Invalid data format');
    } catch (e) {
      print(e);
    }
    return scoreUpdateResponseModel;
  }

  Future<GetBallTypeResponseModel> getBallType() async {

    try {
      final response = await http.get(
        Uri.parse(AppConstants.getBallType),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        getBallTypeResponseModel = GetBallTypeResponseModel.fromJson(decodedJson);

        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('All Matches  - Invalid data format');
    } catch (e) {
      print(e);
    }
    return getBallTypeResponseModel;
  }

  Future<EndInningsResponseModel> endInnings(int matchId,int innings) async {
    var body = json.encode({
      'match_id':matchId,
      'innings':innings
    });
    print(body);
    try {
      final response = await http.post(
        Uri.parse(AppConstants.endInnings),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        endInningsResponseModel = EndInningsResponseModel.fromJson(decodedJson);
        // token = loginModel.token.toString();
        // saveUserData(true, token);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Batsman save- Invalid data format');
    } catch (e) {
      print(e);
    }
    return endInningsResponseModel;
  }

  Future<ScoreCardResponseModel> getScoreCard(String matchId,String teamId) async {

    try {
      final response = await http.get(
        Uri.parse('${AppConstants.scoreCardDetail}/$matchId/$teamId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        scoreCardResponseModel = ScoreCardResponseModel.fromJson(decodedJson);

        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('All Matches  - Invalid data format');
    } catch (e) {
      print(e);
    }
    return scoreCardResponseModel;
  }

  Future<EndInningsResponseModel> matchBreak(int matchId,int teamId,int breakTypeId) async {
    var body = json.encode({
      'match_id':matchId,
      'team_id':teamId,
      'break_type_id':breakTypeId,
    });
    print(body);
    try {
      final response = await http.post(
        Uri.parse(AppConstants.matchBreak),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        endInningsResponseModel = EndInningsResponseModel.fromJson(decodedJson);
        // token = loginModel.token.toString();
        // saveUserData(true, token);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Batsman save- Invalid data format');
    } catch (e) {
      print(e);
    }
    return endInningsResponseModel;
  }

  Future<EndInningsResponseModel> dlMethod(int matchId,int innings,int totalOvers,int targetScore) async {
    var body = json.encode({
      'match_id':matchId,
      'innings':innings,
      'total_overs':totalOvers,
      'target_score':targetScore
    });
    print(body);
    try {
      final response = await http.post(
        Uri.parse(AppConstants.dlMethod),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        endInningsResponseModel = EndInningsResponseModel.fromJson(decodedJson);
        // token = loginModel.token.toString();
        // saveUserData(true, token);
        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Batsman save- Invalid data format');
    } catch (e) {
      print(e);
    }
    return endInningsResponseModel;
  }



}