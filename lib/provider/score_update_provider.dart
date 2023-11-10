import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreUpdateProvider extends ChangeNotifier {

  int overNumberInnings = 0;
  int ballNumberInnings = 0;
  int bowlerChange = 0;
  int? oversBowled;
  List<String> overFollowup = [];

  int innings = 1;

  bool inningsCompleted = false;
  bool firstInningsOverDataCleared = false;

  completeInnings(){
    inningsCompleted = true;
    notifyListeners();
  }

  setInnings(int value){
    innings = value;
    notifyListeners();
    print("setting innings value $value");
  }

  trackOvers(int overNumber, int ballNumber){
    overFollowup.add("$overNumber - $ballNumber");
    notifyListeners();
    print("over followup ${overFollowup.toString()}");
  }

  incrementOverNumber(){
    overNumberInnings = overNumberInnings + 1;
    notifyListeners();
  }

  incrementBallNumber(){
    ballNumberInnings = ballNumberInnings + 1;
    notifyListeners();
  }

  setOverNumber(int value){
    overNumberInnings = value;
    notifyListeners();
    print("updated over number $overNumberInnings");
  }

  setBallNumber(int value){
    ballNumberInnings = value;
    notifyListeners();
    print("updated ball number $ballNumberInnings");
  }

  setBowlerChangeValue(int value){
    bowlerChange = value;
    notifyListeners();
    print("updated bowler change $bowlerChange");
  }

  setOversBowledValue(int? value){
    oversBowled = value;
    notifyListeners();
  }

  clearOverAndBallNumber(){
    overNumberInnings = 0;
    ballNumberInnings = 0;
    bowlerChange = 0;
    oversBowled = 0;
    notifyListeners();
  }

  clearOverAndBallNumberAfterFirstInnings(){
    overNumberInnings = 0;
    ballNumberInnings = 0;
    bowlerChange = 0;
    oversBowled = 0;
    firstInningsOverDataCleared = true;
    notifyListeners();
  }

  setOverAndBallNumberToPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("over_number_innings", overNumberInnings);
    preferences.setInt("ball_number_innings", ballNumberInnings);
    preferences.setInt("bowler_change", bowlerChange);
    preferences.setInt("overs_bowled", oversBowled ?? 0);
    preferences.setBool("innings_completed", inningsCompleted);
    preferences.setBool("first_innings_cleared", firstInningsOverDataCleared);
  }

  getOverAndBallNumberFromPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    overNumberInnings = preferences.getInt("over_number_innings") ?? 0;
    ballNumberInnings = preferences.getInt("ball_number_innings") ?? 0;
    bowlerChange = preferences.getInt("bowler_change") ?? 0;
    oversBowled = preferences.getInt("overs_bowled") ?? 0;
    inningsCompleted = preferences.getBool("innings_completed") ?? false;
    firstInningsOverDataCleared = preferences.getBool("first_innings_cleared") ?? false;
  }

}