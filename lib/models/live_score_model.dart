class LiveScoreCardModel {
  bool? status;
  dynamic message;
  Data? data;

  LiveScoreCardModel({this.status, this.message, this.data});

  LiveScoreCardModel.fromJson(Map<String, dynamic> json) {
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
  List<TeamsName>? teamsName;
  CurrRunRate? currRunRate;
  List<Batting>? batting;
  Bowling? bowling;

  Data({this.teamsName, this.currRunRate, this.batting, this.bowling});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['teamsName'] != null) {
      teamsName = <TeamsName>[];
      json['teamsName'].forEach((v) {
        teamsName!.add(new TeamsName.fromJson(v));
      });
    }
    currRunRate = json['currRunRate'] != null
        ? new CurrRunRate.fromJson(json['currRunRate'])
        : null;
    if (json['batting'] != null) {
      batting = <Batting>[];
      json['batting'].forEach((v) {
        batting!.add(new Batting.fromJson(v));
      });
    }
    bowling =
    json['bowling'] != null ? new Bowling.fromJson(json['bowling']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamsName != null) {
      data['teamsName'] = this.teamsName!.map((v) => v.toJson()).toList();
    }
    if (this.currRunRate != null) {
      data['currRunRate'] = this.currRunRate!.toJson();
    }
    if (this.batting != null) {
      data['batting'] = this.batting!.map((v) => v.toJson()).toList();
    }
    if (this.bowling != null) {
      data['bowling'] = this.bowling!.toJson();
    }
    return data;
  }
}

class TeamsName {
  dynamic team1Name;
  dynamic team2Name;
  dynamic currentInnings;

  TeamsName({this.team1Name, this.team2Name, this.currentInnings});

  TeamsName.fromJson(Map<String, dynamic> json) {
    team1Name = json['team1_name'];
    team2Name = json['team2_name'];
    currentInnings = json['current_innings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team1_name'] = this.team1Name;
    data['team2_name'] = this.team2Name;
    data['current_innings'] = this.currentInnings;
    return data;
  }
}

class CurrRunRate {
  dynamic runRate;
  dynamic reqRunRate;
  dynamic targetScore;

  CurrRunRate({this.runRate, this.reqRunRate, this.targetScore});

  CurrRunRate.fromJson(Map<String, dynamic> json) {
    runRate = json['run_rate'];
    reqRunRate = json['req_run_rate'];
    targetScore = json['target_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['run_rate'] = this.runRate;
    data['req_run_rate'] = this.reqRunRate;
    data['target_score'] = this.targetScore;
    return data;
  }
}

class Batting {
  dynamic runsScored;
  dynamic ballsFaced;
  dynamic fours;
  dynamic sixes;
  dynamic strikeRate;
  dynamic isOut;
  dynamic stricker;
  dynamic outType;
  dynamic outName;
  dynamic wicketBowlerName;
  dynamic wicketerName;
  dynamic playerName;

  Batting(
      {this.runsScored,
        this.ballsFaced,
        this.fours,
        this.sixes,
        this.strikeRate,
        this.isOut,
        this.stricker,
        this.outType,
        this.outName,
        this.wicketBowlerName,
        this.wicketerName,
        this.playerName});

  Batting.fromJson(Map<String, dynamic> json) {
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    fours = json['fours'];
    sixes = json['sixes'];
    strikeRate = json['strike_rate'];
    isOut = json['is_out'];
    stricker = json['stricker'];
    outType = json['out_type'];
    outName = json['out_name'];
    wicketBowlerName = json['wicket_bowler_name'];
    wicketerName = json['wicketer_name'];
    playerName = json['player_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['fours'] = this.fours;
    data['sixes'] = this.sixes;
    data['strike_rate'] = this.strikeRate;
    data['is_out'] = this.isOut;
    data['stricker'] = this.stricker;
    data['out_type'] = this.outType;
    data['out_name'] = this.outName;
    data['wicket_bowler_name'] = this.wicketBowlerName;
    data['wicketer_name'] = this.wicketerName;
    data['player_name'] = this.playerName;
    return data;
  }
}

class Bowling {
  dynamic overBall;
  dynamic maiden;
  dynamic economy;
  dynamic runsConceded;
  dynamic wickets;
  dynamic active;
  dynamic playerName;

  Bowling(
      {this.overBall,
        this.maiden,
        this.economy,
        this.runsConceded,
        this.wickets,
        this.active,
        this.playerName});

  Bowling.fromJson(Map<String, dynamic> json) {
    overBall = json['over_ball'];
    maiden = json['maiden'];
    economy = json['economy'];
    runsConceded = json['runs_conceded'];
    wickets = json['wickets'];
    active = json['active'];
    playerName = json['player_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over_ball'] = this.overBall;
    data['maiden'] = this.maiden;
    data['economy'] = this.economy;
    data['runs_conceded'] = this.runsConceded;
    data['wickets'] = this.wickets;
    data['active'] = this.active;
    data['player_name'] = this.playerName;
    return data;
  }
}
