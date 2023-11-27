class CompletedMatchesModel {
  bool? status;
  List<Data>? data;

  CompletedMatchesModel({this.status, this.data});

  CompletedMatchesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Teams? teams;
  List<TeamInnings>? teamInnings;

  Data({this.teams, this.teamInnings});

  Data.fromJson(Map<String, dynamic> json) {
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
    if (json['team_innings'] != null) {
      teamInnings = <TeamInnings>[];
      json['team_innings'].forEach((v) {
        teamInnings!.add(new TeamInnings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teams != null) {
      data['teams'] = this.teams!.toJson();
    }
    if (this.teamInnings != null) {
      data['team_innings'] = this.teamInnings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  String? team1Name;
  String? team2Name;
  int? matchId;
  int? team1Id;
  int? team2Id;
  String? resultDescription;
  String? wonTeam;
  String? tossWonTeam;
  String? choseTo;
  int? matchStatus;
  int? currentInnings;

  Teams(
      {this.team1Name,
        this.team2Name,
        this.matchId,
        this.team1Id,
        this.team2Id,
        this.resultDescription,
        this.wonTeam,
        this.tossWonTeam,
        this.choseTo,
        this.matchStatus,
        this.currentInnings});

  Teams.fromJson(Map<String, dynamic> json) {
    team1Name = json['team1_name'];
    team2Name = json['team2_name'];
    matchId = json['match_id'];
    team1Id = json['team_1_id'];
    team2Id = json['team_2_id'];
    resultDescription = json['result_description'];
    wonTeam = json['won_team'];
    tossWonTeam = json['toss_won_team'];
    choseTo = json['chose_to'];
    matchStatus = json['match_status'];
    currentInnings = json['current_innings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team1_name'] = this.team1Name;
    data['team2_name'] = this.team2Name;
    data['match_id'] = this.matchId;
    data['team_1_id'] = this.team1Id;
    data['team_2_id'] = this.team2Id;
    data['result_description'] = this.resultDescription;
    data['won_team'] = this.wonTeam;
    data['toss_won_team'] = this.tossWonTeam;
    data['chose_to'] = this.choseTo;
    data['match_status'] = this.matchStatus;
    data['current_innings'] = this.currentInnings;
    return data;
  }
}

class TeamInnings {
  int? totalScore;
  int? totalWickets;
  String? totalOvers;
  String? currOvers;

  TeamInnings(
      {this.totalScore, this.totalWickets, this.totalOvers, this.currOvers});

  TeamInnings.fromJson(Map<String, dynamic> json) {
    totalScore = json['total_score'];
    totalWickets = json['total_wickets'];
    totalOvers = json['total_overs'];
    currOvers = json['curr_overs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_score'] = this.totalScore;
    data['total_wickets'] = this.totalWickets;
    data['total_overs'] = this.totalOvers;
    data['curr_overs'] = this.currOvers;
    return data;
  }
}
