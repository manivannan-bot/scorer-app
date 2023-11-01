class TeamOverview {
  bool? status;
  String? message;
  Data? data;

  TeamOverview({this.status, this.message, this.data});

  TeamOverview.fromJson(Map<String, dynamic> json) {
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
  List<RecentTeamForm>? recentTeamForm;
  TeamStats? teamStats;
  MostWicket? mostWicket;
  MostRun? mostRun;

  Data({this.recentTeamForm, this.teamStats, this.mostWicket, this.mostRun});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recent_team_form'] != null) {
      recentTeamForm = <RecentTeamForm>[];
      json['recent_team_form'].forEach((v) {
        recentTeamForm!.add(new RecentTeamForm.fromJson(v));
      });
    }
    teamStats = json['team_stats'] != null
        ? new TeamStats.fromJson(json['team_stats'])
        : null;
    mostWicket = json['most_wicket'] != null
        ? new MostWicket.fromJson(json['most_wicket'])
        : null;
    mostRun = json['most_run'] != null
        ? new MostRun.fromJson(json['most_run'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentTeamForm != null) {
      data['recent_team_form'] =
          this.recentTeamForm!.map((v) => v.toJson()).toList();
    }
    if (this.teamStats != null) {
      data['team_stats'] = this.teamStats!.toJson();
    }
    if (this.mostWicket != null) {
      data['most_wicket'] = this.mostWicket!.toJson();
    }
    if (this.mostRun != null) {
      data['most_run'] = this.mostRun!.toJson();
    }
    return data;
  }
}

class RecentTeamForm {
  int? matchId;
  String? result;
  String? opponent;
  String? date;

  RecentTeamForm({this.matchId, this.result, this.opponent, this.date});

  RecentTeamForm.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    result = json['result'];
    opponent = json['opponent'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['result'] = this.result;
    data['opponent'] = this.opponent;
    data['date'] = this.date;
    return data;
  }
}

class TeamStats {
  int? matchCount;
  int? matchWonCount;
  int? matchLossCount;

  TeamStats({this.matchCount, this.matchWonCount, this.matchLossCount});

  TeamStats.fromJson(Map<String, dynamic> json) {
    matchCount = json['match_count'];
    matchWonCount = json['match_won_count'];
    matchLossCount = json['match_loss_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_count'] = this.matchCount;
    data['match_won_count'] = this.matchWonCount;
    data['match_loss_count'] = this.matchLossCount;
    return data;
  }
}

class MostWicket {
  String? wickets;
  int? played;
  String? userName;
  String? profilePhoto;
  String? specification;

  MostWicket(
      {this.wickets,
        this.played,
        this.userName,
        this.profilePhoto,
        this.specification});

  MostWicket.fromJson(Map<String, dynamic> json) {
    wickets = json['wickets'];
    played = json['played'];
    userName = json['user_name'];
    profilePhoto = json['profile_photo'];
    specification = json['specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wickets'] = this.wickets;
    data['played'] = this.played;
    data['user_name'] = this.userName;
    data['profile_photo'] = this.profilePhoto;
    data['specification'] = this.specification;
    return data;
  }
}

class MostRun {
  String? runsScored;
  int? played;
  String? userName;
  String? profilePhoto;
  String? specification;

  MostRun(
      {this.runsScored,
        this.played,
        this.userName,
        this.profilePhoto,
        this.specification});

  MostRun.fromJson(Map<String, dynamic> json) {
    runsScored = json['runs_scored'];
    played = json['played'];
    userName = json['user_name'];
    profilePhoto = json['profile_photo'];
    specification = json['specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runs_scored'] = this.runsScored;
    data['played'] = this.played;
    data['user_name'] = this.userName;
    data['profile_photo'] = this.profilePhoto;
    data['specification'] = this.specification;
    return data;
  }
}
