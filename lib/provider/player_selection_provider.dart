import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerSelectionProvider extends ChangeNotifier {

  String selectedStrikerId = "";
  String selectedStrikerName = "";

  String selectedNonStrikerId = "";
  String selectedNonStrikerName = "";

  String selectedBowlerId = "";
  String selectedBowlerName = "";

  String selectedWicketKeeperId = "";
  String selectedWicketKeeperName = "";

  bool firstInningsIdsCleared = false;


  setStrikerId(String id, String name){
    selectedStrikerId = id;
    selectedStrikerName = name;
    notifyListeners();
    print("updated striker id $selectedStrikerId");
  }

  setNonStrikerId(String id, String name){
    selectedNonStrikerId = id;
    selectedNonStrikerName = name;
    notifyListeners();
    print("updated non-striker id $selectedNonStrikerId");
  }

  setBowlerId(String id, String name){
    selectedBowlerId = id;
    selectedBowlerName = name;
    notifyListeners();
    print("updated bowler id $selectedBowlerId");
  }

  setWicketKeeperId(String id, String name){
    selectedWicketKeeperId = id;
    selectedWicketKeeperName = name;
    notifyListeners();
    print("updated wicket keeper id $selectedWicketKeeperId");
  }

  clearAllSelectedIds(){
    selectedStrikerId = "";
    selectedStrikerName = "";
    selectedNonStrikerId = "";
    selectedNonStrikerName = "";
    selectedBowlerId = "";
    selectedBowlerName = "";
    selectedWicketKeeperId = "";
    selectedWicketKeeperName = "";
    notifyListeners();
  }

  clearAllSelectedIdsAfter1stInnings(){
    selectedStrikerId = "";
    selectedStrikerName = "";
    selectedNonStrikerId = "";
    selectedNonStrikerName = "";
    selectedBowlerId = "";
    selectedBowlerName = "";
    selectedWicketKeeperId = "";
    selectedWicketKeeperName = "";
    firstInningsIdsCleared = true;
    notifyListeners();
  }

  setPlayerSelectionValueToPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("current_striker_id", selectedStrikerId);
    preferences.setString("current_non_striker_id", selectedNonStrikerId);
    preferences.setString("current_bowler_id", selectedBowlerId);
    preferences.setString("current_wicket_keeper_id", selectedWicketKeeperId);
    preferences.setString("current_striker_name", selectedStrikerName);
    preferences.setString("current_non_striker_name", selectedNonStrikerName);
    preferences.setString("current_bowler_name", selectedBowlerName);
    preferences.setString("current_wicket_keeper_name", selectedWicketKeeperName);
    preferences.setBool("first_innings_id_cleared", firstInningsIdsCleared);
    print("setting striker id to prefs $selectedStrikerId");
  }

  getPlayerSelectionValueFromPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    selectedStrikerId = preferences.getString("current_striker_id") ?? "";
    selectedNonStrikerId = preferences.getString("current_non_striker_id") ?? "";
    selectedBowlerId = preferences.getString("current_bowler_id") ?? "";
    selectedWicketKeeperId = preferences.getString("current_wicket_keeper_id") ?? "";
    selectedStrikerName = preferences.getString("current_striker_name") ?? "";
    selectedNonStrikerName = preferences.getString("current_non_striker_name") ?? "";
    selectedBowlerName = preferences.getString("current_bowler_name") ?? "";
    selectedWicketKeeperName = preferences.getString("current_wicket_keeper_name") ?? "";
    firstInningsIdsCleared = preferences.getBool("first_innings_id_cleared") ?? false;
    print("getting striker id from prefs $selectedStrikerId");
    notifyListeners();
  }


}