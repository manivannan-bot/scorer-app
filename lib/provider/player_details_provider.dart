import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/players/player_stats_model.dart';
import '../models/players/players_overview_model.dart';
import '../utils/app_constants.dart';
import 'package:http/http.dart' as http;

class PlayerDetailsProvider extends ChangeNotifier{
  PlayerOverview playerOverview=PlayerOverview();
  PlayerStatsModel playerStatsModel=PlayerStatsModel();


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

}