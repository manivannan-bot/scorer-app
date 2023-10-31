class PlayerStatsModel {
  bool? status;
  String? message;
  Data? data;

  PlayerStatsModel({this.status, this.message, this.data});

  PlayerStatsModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.battingPerformance, this.bowlingPerformance});

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
    return data;
  }
}

class BattingPerformance {
  int? totalMatches;
  int? totalRuns;
  int? highestScore;
  String? average;
  String? strikeRate;
  int? totalFour;
  int? totalDuck;
  int? hundred;
  int? totalInnings;
  int? totalBalls;
  int? totalNotOut;
  int? totalSix;
  int? twoHundred;
  String? battingFifty;

  BattingPerformance(
      {this.totalMatches,
        this.totalRuns,
        this.highestScore,
        this.average,
        this.strikeRate,
        this.totalFour,
        this.totalDuck,
        this.hundred,
        this.totalInnings,
        this.totalBalls,
        this.totalNotOut,
        this.totalSix,
        this.twoHundred,
        this.battingFifty});

  BattingPerformance.fromJson(Map<String, dynamic> json) {
    totalMatches = json['total_matches'];
    totalRuns = json['total_runs'];
    highestScore = json['highest_score'];
    average = json['average'];
    strikeRate = json['strike_rate'];
    totalFour = json['total_four'];
    totalDuck = json['total_duck'];
    hundred = json['hundred'];
    totalInnings = json['total_innings'];
    totalBalls = json['total_balls'];
    totalNotOut = json['total_not_out'];
    totalSix = json['total_six'];
    twoHundred = json['two_hundred'];
    battingFifty = json['batting_fifty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_matches'] = this.totalMatches;
    data['total_runs'] = this.totalRuns;
    data['highest_score'] = this.highestScore;
    data['average'] = this.average;
    data['strike_rate'] = this.strikeRate;
    data['total_four'] = this.totalFour;
    data['total_duck'] = this.totalDuck;
    data['hundred'] = this.hundred;
    data['total_innings'] = this.totalInnings;
    data['total_balls'] = this.totalBalls;
    data['total_not_out'] = this.totalNotOut;
    data['total_six'] = this.totalSix;
    data['two_hundred'] = this.twoHundred;
    data['batting_fifty'] = this.battingFifty;
    return data;
  }
}

class BowlingPerformance {
  int? totalMatches;
  int? totalWickets;
  int? bowlingTotalBalls;
  int? bowlingMaidens;
  String? bowlingAverage;
  String? bowlingStrikeRate;
  int? bowlingFiveWicket;
  int? bowlingTotalRuns;
  int? totalInnings;
  int? bowlingEconomy;
  int? bowlingFourWicket;
  int? bowlingTenWicket;

  BowlingPerformance(
      {this.totalMatches,
        this.totalWickets,
        this.bowlingTotalBalls,
        this.bowlingMaidens,
        this.bowlingAverage,
        this.bowlingStrikeRate,
        this.bowlingFiveWicket,
        this.bowlingTotalRuns,
        this.totalInnings,
        this.bowlingEconomy,
        this.bowlingFourWicket,
        this.bowlingTenWicket});

  BowlingPerformance.fromJson(Map<String, dynamic> json) {
    totalMatches = json['total_matches'];
    totalWickets = json['total_wickets'];
    bowlingTotalBalls = json['bowling_total_balls'];
    bowlingMaidens = json['bowling_maidens'];
    bowlingAverage = json['bowling_average'];
    bowlingStrikeRate = json['bowling_strike_rate'];
    bowlingFiveWicket = json['bowling_five_wicket'];
    bowlingTotalRuns = json['bowling_total_runs'];
    totalInnings = json['total_innings'];
    bowlingEconomy = json['bowling_economy'];
    bowlingFourWicket = json['bowling_four_wicket'];
    bowlingTenWicket = json['bowling_ten_wicket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_matches'] = this.totalMatches;
    data['total_wickets'] = this.totalWickets;
    data['bowling_total_balls'] = this.bowlingTotalBalls;
    data['bowling_maidens'] = this.bowlingMaidens;
    data['bowling_average'] = this.bowlingAverage;
    data['bowling_strike_rate'] = this.bowlingStrikeRate;
    data['bowling_five_wicket'] = this.bowlingFiveWicket;
    data['bowling_total_runs'] = this.bowlingTotalRuns;
    data['total_innings'] = this.totalInnings;
    data['bowling_economy'] = this.bowlingEconomy;
    data['bowling_four_wicket'] = this.bowlingFourWicket;
    data['bowling_ten_wicket'] = this.bowlingTenWicket;
    return data;
  }
}
