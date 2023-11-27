class ScoreCardResponseModel {
  bool? status;
  dynamic message;
  Data? data;

  ScoreCardResponseModel({this.status, this.message, this.data});

  ScoreCardResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<YetToBatPlayers>? yetToBatPlayers;
  List<Bowling>? bowling;
  BowlingExtras? bowlingExtras;
  List<FallOfWicket>? fallOfWicket;
  List<Partnerships>? partnerships;

  Data(
      {this.teamsName,
        this.currRunRate,
        this.batting,
        this.yetToBatPlayers,
        this.bowling,
        this.bowlingExtras,
        this.fallOfWicket,
        this.partnerships});

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
    if (json['yetToBatPlayers'] != null) {
      yetToBatPlayers = <YetToBatPlayers>[];
      json['yetToBatPlayers'].forEach((v) {
        yetToBatPlayers!.add(new YetToBatPlayers.fromJson(v));
      });
    }
    if (json['bowling'] != null) {
      bowling = <Bowling>[];
      json['bowling'].forEach((v) {
        bowling!.add(new Bowling.fromJson(v));
      });
    }
    bowlingExtras = json['bowlingExtras'] != null
        ? new BowlingExtras.fromJson(json['bowlingExtras'])
        : null;
    if (json['fallOfWicket'] != null) {
      fallOfWicket = <FallOfWicket>[];
      json['fallOfWicket'].forEach((v) {
        fallOfWicket!.add(new FallOfWicket.fromJson(v));
      });
    }
    if (json['partnerships'] != null) {
      partnerships = <Partnerships>[];
      json['partnerships'].forEach((v) {
        partnerships!.add(new Partnerships.fromJson(v));
      });
    }
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
    if (this.yetToBatPlayers != null) {
      data['yetToBatPlayers'] =
          this.yetToBatPlayers!.map((v) => v.toJson()).toList();
    }
    if (this.bowling != null) {
      data['bowling'] = this.bowling!.map((v) => v.toJson()).toList();
    }
    if (this.bowlingExtras != null) {
      data['bowlingExtras'] = this.bowlingExtras!.toJson();
    }
    if (this.fallOfWicket != null) {
      data['fallOfWicket'] = this.fallOfWicket!.map((v) => v.toJson()).toList();
    }
    if (this.partnerships != null) {
      data['partnerships'] = this.partnerships!.map((v) => v.toJson()).toList();
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

class YetToBatPlayers {
  dynamic playerId;
  dynamic playerName;
  dynamic battingStyle;

  YetToBatPlayers({this.playerId, this.playerName, this.battingStyle});

  YetToBatPlayers.fromJson(Map<String, dynamic> json) {
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

class BowlingExtras {
  dynamic totalExtras;
  dynamic wides;
  dynamic noBalls;
  dynamic byes;
  dynamic legByes;

  BowlingExtras(
      {this.totalExtras, this.wides, this.noBalls, this.byes, this.legByes});

  BowlingExtras.fromJson(Map<String, dynamic> json) {
    totalExtras = json['total_extras'];
    wides = json['wides'];
    noBalls = json['no_balls'];
    byes = json['byes'];
    legByes = json['leg_byes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_extras'] = this.totalExtras;
    data['wides'] = this.wides;
    data['no_balls'] = this.noBalls;
    data['byes'] = this.byes;
    data['leg_byes'] = this.legByes;
    return data;
  }
}

class FallOfWicket {
  dynamic wicketNumber;
  dynamic teamScore;
  dynamic over;
  dynamic playerOutName;

  FallOfWicket(
      {this.wicketNumber, this.teamScore, this.over, this.playerOutName});

  FallOfWicket.fromJson(Map<String, dynamic> json) {
    wicketNumber = json['wicket_number'];
    teamScore = json['team_score'];
    over = json['over'];
    playerOutName = json['player_out_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wicket_number'] = this.wicketNumber;
    data['team_score'] = this.teamScore;
    data['over'] = this.over;
    data['player_out_name'] = this.playerOutName;
    return data;
  }
}

class Partnerships {
  dynamic totalRunsScored;
  dynamic totalBallsFaced;
  dynamic player1RunsScored;
  dynamic player1BallsFaced;
  dynamic player2RunsScored;
  dynamic player2BallsFaced;
  dynamic player1Name;
  dynamic player2Name;

  Partnerships(
      {this.totalRunsScored,
        this.totalBallsFaced,
        this.player1RunsScored,
        this.player1BallsFaced,
        this.player2RunsScored,
        this.player2BallsFaced,
        this.player1Name,
        this.player2Name});

  Partnerships.fromJson(Map<String, dynamic> json) {
    totalRunsScored = json['total_runs_scored'];
    totalBallsFaced = json['total_balls_faced'];
    player1RunsScored = json['player1_runs_scored'];
    player1BallsFaced = json['player1_balls_faced'];
    player2RunsScored = json['player2_runs_scored'];
    player2BallsFaced = json['player2_balls_faced'];
    player1Name = json['player1_name'];
    player2Name = json['player2_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_runs_scored'] = this.totalRunsScored;
    data['total_balls_faced'] = this.totalBallsFaced;
    data['player1_runs_scored'] = this.player1RunsScored;
    data['player1_balls_faced'] = this.player1BallsFaced;
    data['player2_runs_scored'] = this.player2RunsScored;
    data['player2_balls_faced'] = this.player2BallsFaced;
    data['player1_name'] = this.player1Name;
    data['player2_name'] = this.player2Name;
    return data;
  }
}
