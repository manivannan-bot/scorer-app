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
  List<BattingPerformance>? battingPerformance;
  List<BowlingPerformance>? bowlingPerformance;
  List<RecentBatting>? recentBatting;
  List<RecentBowling>? recentBowling;

  Data(
      {this.battingPerformance,
        this.bowlingPerformance,
        this.recentBatting,
        this.recentBowling});

  Data.fromJson(Map<String, dynamic> json) {
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
  int? teamId;

  RecentBatting({this.runsScored, this.ballsFaced, this.teamId});

  RecentBatting.fromJson(Map<String, dynamic> json) {
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    teamId = json['team_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['team_id'] = this.teamId;
    return data;
  }
}


class RecentBowling {
  int? runsScored;
  int? ballsFaced;
  int? teamId;

  RecentBowling({this.runsScored, this.ballsFaced, this.teamId});

  RecentBowling.fromJson(Map<String, dynamic> json) {
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    teamId = json['team_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['team_id'] = this.teamId;
    return data;
  }
}
