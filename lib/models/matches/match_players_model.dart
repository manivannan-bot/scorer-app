class MatchPlayersModel {
  bool? status;
  String? message;
  List<Data>? data;

  MatchPlayersModel({this.status, this.message, this.data});

  MatchPlayersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? playerId;
  String? playerRole;
  String? playerName;
  String? battingStyle;
  int? playingRole;
  String? bowlingAction;
  String? bowingStyle;
  String? profileImage;

  Data(
      {this.playerId,
        this.playerRole,
        this.playerName,
        this.battingStyle,
        this.playingRole,
        this.bowlingAction,
        this.bowingStyle,
        this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
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
