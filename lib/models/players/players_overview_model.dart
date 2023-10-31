class PlayerOverview {
  bool? status;
  String? message;
  Data? data;

  PlayerOverview({this.status, this.message, this.data});

  PlayerOverview.fromJson(Map<String, dynamic> json) {
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
  PlayerInfo? playerInfo;
  List<BattingPerformance>? battingPerformance;
  List<BowlingPerformance>? bowlingPerformance;
  List<RecentBatting>? recentBatting;
  List<RecentBowling>? recentBowling;

  Data(
      {this.playerInfo,
        this.battingPerformance,
        this.bowlingPerformance,
        this.recentBatting,
        this.recentBowling});

  Data.fromJson(Map<String, dynamic> json) {
    playerInfo = json['playerInfo'] != null
        ? new PlayerInfo.fromJson(json['playerInfo'])
        : null;
    if (json['battingPerformance'] != null) {
      battingPerformance = <BattingPerformance>[];
      json['battingPerformance'].forEach((v) {
        battingPerformance!.add(new BattingPerformance.fromJson(v));
      });
    }
    if (json['bowlingPerformance'] != null) {
      bowlingPerformance = <BowlingPerformance>[];
      json['bowlingPerformance'].forEach((v) {
        bowlingPerformance!.add(new BowlingPerformance.fromJson(v));
      });
    }
    if (json['recentBatting'] != null) {
      recentBatting = <RecentBatting>[];
      json['recentBatting'].forEach((v) {
        recentBatting!.add(new RecentBatting.fromJson(v));
      });
    }
    if (json['recentBowling'] != null) {
      recentBowling = <RecentBowling>[];
      json['recentBowling'].forEach((v) {
        recentBowling!.add(new RecentBowling.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playerInfo != null) {
      data['playerInfo'] = this.playerInfo!.toJson();
    }
    if (this.battingPerformance != null) {
      data['battingPerformance'] =
          this.battingPerformance!.map((v) => v.toJson()).toList();
    }
    if (this.bowlingPerformance != null) {
      data['bowlingPerformance'] =
          this.bowlingPerformance!.map((v) => v.toJson()).toList();
    }
    if (this.recentBatting != null) {
      data['recentBatting'] =
          this.recentBatting!.map((v) => v.toJson()).toList();
    }
    if (this.recentBowling != null) {
      data['recentBowling'] =
          this.recentBowling!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayerInfo {
  int? playerId;
  String? playerName;
  String? battingStyle;
  String? bowlingAction;
  String? bowlingStyle;
  String? profilePhoto;

  PlayerInfo(
      {this.playerId,
        this.playerName,
        this.battingStyle,
        this.bowlingAction,
        this.bowlingStyle,
        this.profilePhoto});

  PlayerInfo.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    battingStyle = json['batting_style'];
    bowlingAction = json['bowling_action'];
    bowlingStyle = json['bowling_style'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['batting_style'] = this.battingStyle;
    data['bowling_action'] = this.bowlingAction;
    data['bowling_style'] = this.bowlingStyle;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

class BattingPerformance {
  int? totalRuns;
  int? highestScore;
  String? playerName;
  String? average;
  String? strikeRate;

  BattingPerformance(
      {this.totalRuns,
        this.highestScore,
        this.playerName,
        this.average,
        this.strikeRate});

  BattingPerformance.fromJson(Map<String, dynamic> json) {
    totalRuns = json['total_runs'];
    highestScore = json['highest_score'];
    playerName = json['player_name'];
    average = json['average'];
    strikeRate = json['strike_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_runs'] = this.totalRuns;
    data['highest_score'] = this.highestScore;
    data['player_name'] = this.playerName;
    data['average'] = this.average;
    data['strike_rate'] = this.strikeRate;
    return data;
  }
}

class BowlingPerformance {
  int? totalWickets;
  String? bowlingBest;
  int? bowlingMaidens;
  String? bowlingAverage;

  BowlingPerformance(
      {this.totalWickets,
        this.bowlingBest,
        this.bowlingMaidens,
        this.bowlingAverage});

  BowlingPerformance.fromJson(Map<String, dynamic> json) {
    totalWickets = json['total_wickets'];
    bowlingBest = json['bowling_best'];
    bowlingMaidens = json['bowling_maidens'];
    bowlingAverage = json['bowling_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_wickets'] = this.totalWickets;
    data['bowling_best'] = this.bowlingBest;
    data['bowling_maidens'] = this.bowlingMaidens;
    data['bowling_average'] = this.bowlingAverage;
    return data;
  }
}

class RecentBatting {
  int? runsScored;
  int? ballsFaced;
  String? opponent;

  RecentBatting({this.runsScored, this.ballsFaced, this.opponent});

  RecentBatting.fromJson(Map<String, dynamic> json) {
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    opponent = json['opponent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['opponent'] = this.opponent;
    return data;
  }
}

class RecentBowling {
  int? oversBowled;
  int? runsConceded;
  int? wickets;
  String? opponent;

  RecentBowling(
      {this.oversBowled, this.runsConceded, this.wickets, this.opponent});

  RecentBowling.fromJson(Map<String, dynamic> json) {
    oversBowled = json['overs_bowled'];
    runsConceded = json['runs_conceded'];
    wickets = json['wickets'];
    opponent = json['opponent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overs_bowled'] = this.oversBowled;
    data['runs_conceded'] = this.runsConceded;
    data['wickets'] = this.wickets;
    data['opponent'] = this.opponent;
    return data;
  }
}
