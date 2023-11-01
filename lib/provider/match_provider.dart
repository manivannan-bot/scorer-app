import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:scorer/models/commentary/commentary_wicket_model.dart';
import 'package:scorer/models/match_info_model.dart';

import '../models/commentary/commentary_four_six_model.dart';
import '../models/commentary/commentary_overs_model.dart';
import '../models/matches/match_players_model.dart';
import '../models/matches/match_players_model.dart';
import '../utils/app_constants.dart';
import 'package:http/http.dart' as http;

class MatchProvider extends ChangeNotifier{
  MatchInfoModel matchInfoModel=MatchInfoModel();
  MatchPlayersModel matchPlayersModel=MatchPlayersModel();
  CommentaryOversModel commentaryOversModel=CommentaryOversModel();
  CommentaryWicketModel commentaryWicketModel=CommentaryWicketModel();
  CommentaryFourSixModel commentaryFoursSixesModel =CommentaryFourSixModel();


  Future<MatchInfoModel> getMatchInfo(String matchId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.matchInfo}/$matchId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        matchInfoModel = MatchInfoModel.fromJson(decodedJson);

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
    return matchInfoModel;
  }
  Future<MatchPlayersModel> getMatchPlayers(String matchId,String teamId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.matchPlayers}/$matchId/$teamId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        matchPlayersModel = MatchPlayersModel.fromJson(decodedJson);

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
    return matchPlayersModel;
  }
  Future<CommentaryOversModel> getCommentaryOvers(String matchId,String teamId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.commentaryOvers}/$matchId/$teamId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        commentaryOversModel = CommentaryOversModel.fromJson(decodedJson);

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
    return commentaryOversModel;
  }
  Future<CommentaryWicketModel> getCommentaryWickets(String matchId,String teamId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.commentaryWickets}/$matchId/$teamId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        commentaryWicketModel = CommentaryWicketModel.fromJson(decodedJson);

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
    return commentaryWicketModel;
  }

  Future<CommentaryFourSixModel> getCommentaryFoursSixes(String matchId,String teamId) async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.commentaryFoursSixes}/$matchId/$teamId'),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        commentaryFoursSixesModel = CommentaryFourSixModel.fromJson(decodedJson);

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
    return commentaryFoursSixesModel;
  }


}