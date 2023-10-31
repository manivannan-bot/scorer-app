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


  setStrikerId(String id, String name){
    selectedStrikerId = id;
    selectedStrikerName = name;
    notifyListeners();
  }

  setNonStrikerId(String id, String name){
    selectedNonStrikerId = id;
    selectedNonStrikerName = name;
    notifyListeners();
  }

  setBowlerId(String id, String name){
    selectedBowlerId = id;
    selectedBowlerName = name;
    notifyListeners();
  }

  setWicketKeeperId(String id, String name){
    selectedWicketKeeperId = id;
    selectedWicketKeeperName = name;
    notifyListeners();
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

  setPlayerSelectionValueToPrefs() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }


}