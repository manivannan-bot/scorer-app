import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:scorer/models/match_info_model.dart';
import 'package:scorer/models/matches/completed_matches_model.dart';
import '../utils/app_constants.dart';
import 'package:http/http.dart' as http;

class MatchProvider extends ChangeNotifier{
  MatchInfoModel matchInfoModel=MatchInfoModel();
  CompletedMatchesModel completedMatchesModel=CompletedMatchesModel();


  Future<CompletedMatchesModel> getCompletedMatches() async {

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? accToken = preferences.getString("access_token");
    try {
      final response = await http.get(
        Uri.parse(AppConstants.completedMatches),
        // headers: {
        //   // 'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $accToken',
        // },
      );
      var decodedJson = json.decode(response.body);
      print(decodedJson);
      if (response.statusCode == 200) {
        completedMatchesModel = CompletedMatchesModel.fromJson(decodedJson);

        notifyListeners();
      } else {
        throw const HttpException('Failed to load data');
      }
    } on SocketException {
      print('No internet connection');
    } on HttpException {
      print('Failed to load data');
    } on FormatException {
      print('Completed Matches  - Invalid data format');
    } catch (e) {
      print(e);
    }
    return completedMatchesModel;
  }

}