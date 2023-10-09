import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/all_matches_model.dart';
import '../utils/app_constants.dart';

class ScoringProvider extends ChangeNotifier{

  AllMatchesModel allMatchesModel =AllMatchesModel();

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



}