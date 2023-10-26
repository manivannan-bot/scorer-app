class ScoreCardResponseModel {
  bool? status;
  String? message;
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
  List<Batting>? batting;
  List<YetToBatPlayers>? yetToBatPlayers;
  List<Bowling>? bowling;
  BowlingExtras? bowlingExtras;
  List<FallOfWicket>? fallOfWicket;
  List<Partnerships>? partnerships;

  Data(
      {this.batting,
        this.yetToBatPlayers,
        this.bowling,
        this.bowlingExtras,
        this.fallOfWicket,
        this.partnerships});

  Data.fromJson(Map<String, dynamic> json) {
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

class Batting {
  int? runsScored;
  int? ballsFaced;
  int? fours;
  int? sixes;
  String? strikeRate;
  int? isOut;
  String? outType;
  String? wicketBowlerName;
  String? wicketerName;
  String? playerName;

  Batting(
      {this.runsScored,
        this.ballsFaced,
        this.fours,
        this.sixes,
        this.strikeRate,
        this.isOut,
        this.outType,
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
    outType = json['out_type'];
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
    data['out_type'] = this.outType;
    data['wicket_bowler_name'] = this.wicketBowlerName;
    data['wicketer_name'] = this.wicketerName;
    data['player_name'] = this.playerName;
    return data;
  }
}

class YetToBatPlayers {
  int? playerId;
  String? playerName;
  String? battingStyle;

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
  String? overBall;
  int? maiden;
  String? economy;
  int? runsConceded;
  int? wickets;
  String? playerName;

  Bowling(
      {this.overBall,
        this.maiden,
        this.economy,
        this.runsConceded,
        this.wickets,
        this.playerName});

  Bowling.fromJson(Map<String, dynamic> json) {
    overBall = json['over_ball'];
    maiden = json['maiden'];
    economy = json['economy'];
    runsConceded = json['runs_conceded'];
    wickets = json['wickets'];
    playerName = json['player_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over_ball'] = this.overBall;
    data['maiden'] = this.maiden;
    data['economy'] = this.economy;
    data['runs_conceded'] = this.runsConceded;
    data['wickets'] = this.wickets;
    data['player_name'] = this.playerName;
    return data;
  }
}

class BowlingExtras {
  String? totalExtras;
  String? wides;
  String? noBalls;
  String? byes;
  String? legByes;

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
  int? wicketNumber;
  int? teamScore;
  String? over;
  String? playerOutName;

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
  int? runsScored;
  int? ballsFaced;
  int? player1RunsScored;
  int? player1BallsFaced;
  int? player2RunsScored;
  int? player2BallsFaced;
  String? player1Name;
  String? player2Name;

  Partnerships(
      {this.runsScored,
        this.ballsFaced,
        this.player1RunsScored,
        this.player1BallsFaced,
        this.player2RunsScored,
        this.player2BallsFaced,
        this.player1Name,
        this.player2Name});

  Partnerships.fromJson(Map<String, dynamic> json) {
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    player1RunsScored = json['player1_runs_scored'];
    player1BallsFaced = json['player1_balls_faced'];
    player2RunsScored = json['player2_runs_scored'];
    player2BallsFaced = json['player2_balls_faced'];
    player1Name = json['player1_name'];
    player2Name = json['player2_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['player1_runs_scored'] = this.player1RunsScored;
    data['player1_balls_faced'] = this.player1BallsFaced;
    data['player2_runs_scored'] = this.player2RunsScored;
    data['player2_balls_faced'] = this.player2BallsFaced;
    data['player1_name'] = this.player1Name;
    data['player2_name'] = this.player2Name;
    return data;
  }
}
