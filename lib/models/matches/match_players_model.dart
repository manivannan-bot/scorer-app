class MatchPlayersModel {
  bool? status;
  dynamic message;
  Data? data;

  MatchPlayersModel({this.status, this.message, this.data});

  MatchPlayersModel.fromJson(Map<String, dynamic> json) {
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
  List<PlayersDetails>? playersDetails;
  List<Teams>? teams;

  Data({this.playersDetails, this.teams});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['playersDetails'] != null) {
      playersDetails = <PlayersDetails>[];
      json['playersDetails'].forEach((v) {
        playersDetails!.add(new PlayersDetails.fromJson(v));
      });
    }
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playersDetails != null) {
      data['playersDetails'] =
          this.playersDetails!.map((v) => v.toJson()).toList();
    }
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayersDetails {
  dynamic playerId;
  dynamic playerRole;
  dynamic playerName;
  dynamic battingStyle;
  dynamic playingRole;
  dynamic bowlingAction;
  dynamic bowingStyle;
  dynamic profileImage;

  PlayersDetails(
      {this.playerId,
        this.playerRole,
        this.playerName,
        this.battingStyle,
        this.playingRole,
        this.bowlingAction,
        this.bowingStyle,
        this.profileImage});

  PlayersDetails.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerRole = json['player_role'];
    playerName = json['player_name'];
    battingStyle = json['batting_style'];
    playingRole = json['playing_role'];
    bowlingAction = json['bowling_action'];
    bowingStyle = json['bowing_style'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_role'] = this.playerRole;
    data['player_name'] = this.playerName;
    data['batting_style'] = this.battingStyle;
    data['playing_role'] = this.playingRole;
    data['bowling_action'] = this.bowlingAction;
    data['bowing_style'] = this.bowingStyle;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

class Teams {
  dynamic team1Name;
  dynamic team2Name;

  Teams({this.team1Name, this.team2Name});

  Teams.fromJson(Map<String, dynamic> json) {
    team1Name = json['team1_name'];
    team2Name = json['team2_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team1_name'] = this.team1Name;
    data['team2_name'] = this.team2Name;
    return data;
  }
}
