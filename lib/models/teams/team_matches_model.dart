class TeamMatchesModel {
  bool? status;
  String? message;
  Data? data;

  TeamMatchesModel({this.status, this.message, this.data});

  TeamMatchesModel.fromJson(Map<String, dynamic> json) {
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
  List<LiveMatches>? liveMatches;
  List<CompletedMatches>? completedMatches;

  Data({this.liveMatches, this.completedMatches});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['liveMatches'] != null) {
      liveMatches = <LiveMatches>[];
      json['liveMatches'].forEach((v) {
        liveMatches!.add(new LiveMatches.fromJson(v));
      });
    }
    if (json['CompletedMatches'] != null) {
      completedMatches = <CompletedMatches>[];
      json['CompletedMatches'].forEach((v) {
        completedMatches!.add(new CompletedMatches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.liveMatches != null) {
      data['liveMatches'] = this.liveMatches!.map((v) => v.toJson()).toList();
    }
    if (this.completedMatches != null) {
      data['CompletedMatches'] =
          this.completedMatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveMatches {
  Teams? teams;
  List<TeamInnings>? teamInnings;

  LiveMatches({this.teams, this.teamInnings});

  LiveMatches.fromJson(Map<String, dynamic> json) {
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

class CompletedMatches {
  Teams? teams;
  List<TeamInnings>? teamInnings;

  CompletedMatches({this.teams, this.teamInnings});

  CompletedMatches.fromJson(Map<String, dynamic> json) {
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
