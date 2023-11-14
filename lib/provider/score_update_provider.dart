import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreUpdateProvider extends ChangeNotifier {

  int overNumberInnings = 0;
  int ballNumberInnings = 0;
  int bowlerChange = 0;
  int? oversBowled;
  int? bowlerPosition;
  List<String> overFollowup = [];

  int ow = 1;
  int rw = 0;

  int innings = 1;

  bool inningsCompleted = false;
  bool firstInningsOverDataCleared = false;

  setBowlerPosition(int? value, int over, int round){
    bowlerPosition = value;
    ow = over;
    rw = round;
    notifyListeners();
    debugPrint("updated bowler position");
  }

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
    ow = 0;
    rw = 0;
    bowlerPosition = -1;
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
    preferences.setInt("round_the_wicket", rw);
    preferences.setInt("over_the_wicket", ow);
    preferences.setInt("bowler_position", bowlerPosition!);
  }

  getOverAndBallNumberFromPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    overNumberInnings = preferences.getInt("over_number_innings") ?? 0;
    ballNumberInnings = preferences.getInt("ball_number_innings") ?? 0;
    bowlerChange = preferences.getInt("bowler_change") ?? 0;
    oversBowled = preferences.getInt("overs_bowled") ?? 0;
    inningsCompleted = preferences.getBool("innings_completed") ?? false;
    firstInningsOverDataCleared = preferences.getBool("first_innings_cleared") ?? false;
    rw = preferences.getInt("round_the_wicket") ?? 0;
    ow = preferences.getInt("over_the_wicket") ?? 0;
    bowlerPosition = preferences.getInt("bowler_position") ?? 0;
  }

}