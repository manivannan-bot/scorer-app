import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:scorer/models/user_profile_model.dart';

import '../models/players/player_info_model.dart';
import '../models/players/player_matches_model.dart';
import '../models/players/player_stats_model.dart';
import '../models/players/player_team_info_model.dart';
import '../models/players/players_overview_model.dart';
import '../utils/app_constants.dart';
import 'package:http/http.dart' as http;

class PlayerDetailsProvider extends ChangeNotifier{
  PlayerOverview playerOverview=PlayerOverview();
  PlayerStatsModel playerStatsModel=PlayerStatsModel();
  PlayerMatchesModel playerMatchesModel=PlayerMatchesModel();
  PlayerTeamInfoModel playerTeamInfoModel=PlayerTeamInfoModel();
  PlayerInfoModel playerInfoModel=PlayerInfoModel();
  UserProfileModel userProfileModel=UserProfileModel();

  Future<PlayerOverview> getPlayerOverView(String playerId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.playerOverview}/$playerId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        playerOverview = PlayerOverview.fromJson(decodedJson);

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
    return playerOverview;
  }
  Future<PlayerStatsModel> getPlayerStats(String playerId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.playerStats}/$playerId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        playerStatsModel = PlayerStatsModel.fromJson(decodedJson);

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
    return playerStatsModel;
  }
  Future<PlayerMatchesModel> getPlayerMatches(String playerId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.playerMatches}/$playerId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        playerMatchesModel = PlayerMatchesModel.fromJson(decodedJson);

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
    return playerMatchesModel;
  }
  Future<PlayerTeamInfoModel> getPlayerTeamInfo(String playerId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.playerTeamInfo}/$playerId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        playerTeamInfoModel = PlayerTeamInfoModel.fromJson(decodedJson);

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
    return playerTeamInfoModel;
  }
  Future<PlayerInfoModel> getPlayerInfo(String playerId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.playerInfo}/$playerId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        playerInfoModel = PlayerInfoModel.fromJson(decodedJson);

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
    return playerInfoModel;
  }
  Future<UserProfileModel> getUserProfile(String userId) async {
    var body = json.encode({
      "user_id":userId
    });
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.userProfile}'),
        body: body,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //'Authorization': 'Bearer $accToken',
        },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        userProfileModel = UserProfileModel.fromJson(decodedJson);

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
    return userProfileModel;
  }

}