class TeamInfoModel {
  bool? status;
  String? message;
  Data? data;

  TeamInfoModel({this.status, this.message, this.data});

  TeamInfoModel.fromJson(Map<String, dynamic> json) {
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
  Teams? teams;
  TeamsDetails? teamsDetails;

  Data({this.teams, this.teamsDetails});

  Data.fromJson(Map<String, dynamic> json) {
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
    teamsDetails = json['teams_details'] != null
        ? new TeamsDetails.fromJson(json['teams_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teams != null) {
      data['teams'] = this.teams!.toJson();
    }
    if (this.teamsDetails != null) {
      data['teams_details'] = this.teamsDetails!.toJson();
    }
    return data;
  }
}

class Teams {
  int? teamId;
  String? teamName;
  String? teamLogo;

  Teams({this.teamId, this.teamName, this.teamLogo});

  Teams.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    teamName = json['team_name'];
    teamLogo = json['team_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    data['team_logo'] = this.teamLogo;
    return data;
  }
}

class TeamsDetails {
  String? teamState;
  String? teamCity;

  TeamsDetails({this.teamState, this.teamCity});

  TeamsDetails.fromJson(Map<String, dynamic> json) {
    teamState = json['team_state'];
    teamCity = json['team_city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_state'] = this.teamState;
    data['team_city'] = this.teamCity;
    return data;
  }
}
