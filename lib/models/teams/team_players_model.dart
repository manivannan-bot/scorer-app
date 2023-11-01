class TeamPlayersModel {
  bool? status;
  String? message;
  Data? data;

  TeamPlayersModel({this.status, this.message, this.data});

  TeamPlayersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Batsman>? batsman;
  List<Bowler>? bowler;
  List<AllRounder>? allRounder;

  Data({this.batsman, this.bowler, this.allRounder});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['batsman'] != null) {
      batsman = <Batsman>[];
      json['batsman'].forEach((v) {
        batsman!.add(new Batsman.fromJson(v));
      });
    }
    if (json['bowler'] != null) {
      bowler = <Bowler>[];
      json['bowler'].forEach((v) {
        bowler!.add(new Bowler.fromJson(v));
      });
    }
    if (json['allRounder'] != null) {
      allRounder = <AllRounder>[];
      json['allRounder'].forEach((v) {
        allRounder!.add(new AllRounder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.batsman != null) {
      data['batsman'] = this.batsman!.map((v) => v.toJson()).toList();
    }
    if (this.bowler != null) {
      data['bowler'] = this.bowler!.map((v) => v.toJson()).toList();
    }
    if (this.allRounder != null) {
      data['allRounder'] = this.allRounder!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batsman {
  int? playerId;
  String? playerName;
  String? battingStyle;

  Batsman({this.playerId, this.playerName, this.battingStyle});

  Batsman.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    battingStyle = json['batting_style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['batting_style'] = this.battingStyle;
    return data;
  }
}

class Bowler {
  int? playerId;
  String? playerName;
  String? bowlingAction;
  String? battingStyle;

  Bowler(
      {this.playerId, this.playerName, this.bowlingAction, this.battingStyle});

  Bowler.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    bowlingAction = json['bowling_action'];
    battingStyle = json['batting_style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['bowling_action'] = this.bowlingAction;
    data['batting_style'] = this.battingStyle;
    return data;
  }
}

class AllRounder {
  int? playerId;
  String? playerName;
  String? allRounderType;

  AllRounder({this.playerId, this.playerName, this.allRounderType});

  AllRounder.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    allRounderType = json['all_rounder_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['all_rounder_type'] = this.allRounderType;
    return data;
  }
}
