class GetLiveScoreResponseModel {
  bool? status;
  String? message;
  Matches? matches;
  dynamic target;
  RunRate? runRate;

  GetLiveScoreResponseModel({this.status, this.message, this.matches, this.target, this.runRate});

  GetLiveScoreResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    matches = json['matches'] != null ? new Matches.fromJson(json['matches']) : null;
    target = json['target'];
    runRate = json['batting_val'] != null ? new RunRate.fromJson(json['batting_val']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.matches != null) {
      data['matches'] = this.matches!.toJson();
    }
    data['target'] = this.target;
    data['batting_val'] = this.runRate;
    return data;
  }
}

class RunRate {
  dynamic reqRunRate;
  dynamic currentRunRate;

  RunRate({
    this.reqRunRate,
    this.currentRunRate
  });

  RunRate.fromJson(Map<String, dynamic> json) {
    reqRunRate = json['req_run_rate'];
    currentRunRate = json['cur_run_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['req_run_rate'] = this.reqRunRate;
    data['cur_run_rate'] = this.currentRunRate;
    return data;
  }
}

class Matches {
  int? matchId;
  String? matchNumber;
  int? team1Id;
  int? team2Id;
  int? scorerId;
  int? umpireId;
  String? date;
  String? venue;
  String? slotStartTime;
  String? slotEndTime;
  String? organiser;
  String? ground;
  int? tossWonBy;
  String? choseTo;
  String? overs;
  int? currentInnings;
  int? matchStatus;
  int? matchWonBy;
  int? matchLossBy;
  String? resultDescription;
  String? createdAt;
  String? updatedAt;
  String? team1Name;
  String? team2Name;
  String? tossWinnerName;
  String? status;
  Teams? teams;

  Matches(
      {this.matchId,
        this.matchNumber,
        this.team1Id,
        this.team2Id,
        this.scorerId,
        this.umpireId,
        this.date,
        this.venue,
        this.slotStartTime,
        this.slotEndTime,
        this.organiser,
        this.ground,
        this.tossWonBy,
        this.choseTo,
        this.overs,
        this.currentInnings,
        this.matchStatus,
        this.matchWonBy,
        this.matchLossBy,
        this.resultDescription,
        this.createdAt,
        this.updatedAt,
        this.team1Name,
        this.team2Name,
        this.tossWinnerName,
        this.status,
        this.teams});

  Matches.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    matchNumber = json['match_number'];
    team1Id = json['team_1_id'];
    team2Id = json['team_2_id'];
    scorerId = json['scorer_id'];
    umpireId = json['umpire_id'];
    date = json['date'];
    venue = json['venue'];
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    organiser = json['organiser'];
    ground = json['ground'];
    tossWonBy = json['toss_won_by'];
    choseTo = json['chose_to'];
    overs = json['overs'];
    currentInnings = json['current_innings'];
    matchStatus = json['match_status'];
    matchWonBy = json['match_won_by'];
    matchLossBy = json['match_loss_by'];
    resultDescription = json['result_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    team1Name = json['team1_name'];
    team2Name = json['team2_name'];
    tossWinnerName = json['toss_winner_name'];
    status = json['status'];
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['match_number'] = this.matchNumber;
    data['team_1_id'] = this.team1Id;
    data['team_2_id'] = this.team2Id;
    data['scorer_id'] = this.scorerId;
    data['umpire_id'] = this.umpireId;
    data['date'] = this.date;
    data['venue'] = this.venue;
    data['slot_start_time'] = this.slotStartTime;
    data['slot_end_time'] = this.slotEndTime;
    data['organiser'] = this.organiser;
    data['ground'] = this.ground;
    data['toss_won_by'] = this.tossWonBy;
    data['chose_to'] = this.choseTo;
    data['overs'] = this.overs;
    data['current_innings'] = this.currentInnings;
    data['match_status'] = this.matchStatus;
    data['match_won_by'] = this.matchWonBy;
    data['match_loss_by'] = this.matchLossBy;
    data['result_description'] = this.resultDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['team1_name'] = this.team1Name;
    data['team2_name'] = this.team2Name;
    data['toss_winner_name'] = this.tossWinnerName;
    data['status'] = this.status;
    if (this.teams != null) {
      data['teams'] = this.teams!.toJson();
    }
    return data;
  }
}

class Teams {
  dynamic teamName;
  dynamic totalRuns;
  dynamic totalWickets;
  dynamic ballNumber;
  dynamic overNumber;
  dynamic overs;
  dynamic currentOverDetails;
  dynamic ballRecordCheck;
  dynamic teamLogo;

  Teams(
      {this.teamName,
        this.totalRuns,
        this.totalWickets,
        this.ballNumber,
        this.overNumber,
        this.overs,
        this.currentOverDetails,
        this.ballRecordCheck,
        this.teamLogo});

  Teams.fromJson(Map<String, dynamic> json) {
    teamName = json['team_name'];
    totalRuns = json['total_runs'];
    totalWickets = json['total_wickets'];
    ballNumber = json['ball_number'];
    overNumber = json['over_number'];
    overs = json['overs'];
    currentOverDetails = json['current_over_details'];
    ballRecordCheck = json['ball_record_check'];
    teamLogo = json['team_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_name'] = this.teamName;
    data['total_runs'] = this.totalRuns;
    data['total_wickets'] = this.totalWickets;
    data['ball_number'] = this.ballNumber;
    data['over_number'] = this.overNumber;
    data['overs'] = this.overs;
    data['current_over_details'] = this.currentOverDetails;
    data['ball_record_check'] = this.ballRecordCheck;
    data['team_logo'] = this.teamLogo;
    return data;
  }
}
