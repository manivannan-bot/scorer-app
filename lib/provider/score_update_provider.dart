import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreUpdateProvider extends ChangeNotifier {

  int overNumberInnings = 0;
  int ballNumberInnings = 0;

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
  }

  setBallNumber(int value){
    ballNumberInnings = value;
    notifyListeners();
  }

  clearOverAndBallNumber(){
    overNumberInnings = 0;
    ballNumberInnings = 0;
    notifyListeners();
  }

  setOverAndBallNumberToPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("over_number_innings", overNumberInnings);
    preferences.setInt("ball_number_innings", ballNumberInnings);
  }

  getOverAndBallNumberFromPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    overNumberInnings = preferences.getInt("over_number_innings") ?? 0;
    ballNumberInnings = preferences.getInt("ball_number_innings") ?? 0;
  }

}