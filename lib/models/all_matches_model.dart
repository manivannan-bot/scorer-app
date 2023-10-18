class AllMatchesModel {
  bool? status;
  dynamic message;
  List<Matches>? matches;

  AllMatchesModel({this.status, this.message, this.matches});

  AllMatchesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches!.add(new Matches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.matches != null) {
      data['matches'] = this.matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  dynamic matchId;
  dynamic team1Id;
  dynamic team2Id;
  dynamic scorerId;
  dynamic umpireId;
  dynamic date;
  dynamic venue;
  dynamic result;
  dynamic slotStartTime;
  dynamic slotEndTime;
  dynamic organiser;
  dynamic ground;
  dynamic toss;
  dynamic wonBy;
  dynamic choseTo;
  dynamic overs;
  dynamic currentInnings;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic team1Name;
  dynamic team2Name;
  dynamic tossWinnerName;
  dynamic status;
  List<Teams>? teams;

  Matches(
      {this.matchId,
        this.team1Id,
        this.team2Id,
        this.scorerId,
        this.umpireId,
        this.date,
        this.venue,
        this.result,
        this.slotStartTime,
        this.slotEndTime,
        this.organiser,
        this.ground,
        this.toss,
        this.wonBy,
        this.choseTo,
        this.overs,
        this.currentInnings,
        this.createdAt,
        this.updatedAt,
        this.team1Name,
        this.team2Name,
        this.tossWinnerName,
        this.status,
        this.teams});

  Matches.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    team1Id = json['team_1_id'];
    team2Id = json['team_2_id'];
    scorerId = json['scorer_id'];
    umpireId = json['umpire_id'];
    date = json['date'];
    venue = json['venue'];
    result = json['result'];
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    organiser = json['organiser'];
    ground = json['ground'];
    toss = json['toss'];
    wonBy = json['won_by'];
    choseTo = json['chose_to'];
    overs = json['overs'];
    currentInnings = json['current_innings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    team1Name = json['team1_name'];
    team2Name = json['team2_name'];
    tossWinnerName = json['toss_winner_name'];
    status = json['status'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['team_1_id'] = this.team1Id;
    data['team_2_id'] = this.team2Id;
    data['scorer_id'] = this.scorerId;
    data['umpire_id'] = this.umpireId;
    data['date'] = this.date;
    data['venue'] = this.venue;
    data['result'] = this.result;
    data['slot_start_time'] = this.slotStartTime;
    data['slot_end_time'] = this.slotEndTime;
    data['organiser'] = this.organiser;
    data['ground'] = this.ground;
    data['toss'] = this.toss;
    data['won_by'] = this.wonBy;
    data['chose_to'] = this.choseTo;
    data['overs'] = this.overs;
    data['current_innings'] = this.currentInnings;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['team1_name'] = this.team1Name;
    data['team2_name'] = this.team2Name;
    data['toss_winner_name'] = this.tossWinnerName;
    data['status'] = this.status;
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
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
  dynamic currentOverDetails;

  Teams(
      {this.teamName,
        this.totalRuns,
        this.totalWickets,
        this.ballNumber,
        this.overNumber,
        this.currentOverDetails});

  Teams.fromJson(Map<String, dynamic> json) {
    teamName = json['team_name'];
    totalRuns = json['total_runs'];
    totalWickets = json['total_wickets'];
    ballNumber = json['ball_number'];
    overNumber = json['over_number'];
    currentOverDetails = json['current_over_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_name'] = this.teamName;
    data['total_runs'] = this.totalRuns;
    data['total_wickets'] = this.totalWickets;
    data['ball_number'] = this.ballNumber;
    data['over_number'] = this.overNumber;
    data['current_over_details'] = this.currentOverDetails;
    return data;
  }
}
