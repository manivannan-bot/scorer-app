class PlayerListModel {
  bool? status;
  String? message;
  Team? team;
  List<BattingPlayers>? battingPlayers;
  List<BowlingPlayers>? bowlingPlayers;
  List<WkPlayers>? wkPlayers;

  PlayerListModel(
      {this.status,
        this.message,
        this.team,
        this.battingPlayers,
        this.bowlingPlayers,
        this.wkPlayers});

  PlayerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    if (json['batting_players'] != null) {
      battingPlayers = <BattingPlayers>[];
      json['batting_players'].forEach((v) {
        battingPlayers!.add(new BattingPlayers.fromJson(v));
      });
    }
    if (json['bowling_players'] != null) {
      bowlingPlayers = <BowlingPlayers>[];
      json['bowling_players'].forEach((v) {
        bowlingPlayers!.add(new BowlingPlayers.fromJson(v));
      });
    }
    if (json['wk_players'] != null) {
      wkPlayers = <WkPlayers>[];
      json['wk_players'].forEach((v) {
        wkPlayers!.add(new WkPlayers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    if (this.battingPlayers != null) {
      data['batting_players'] =
          this.battingPlayers!.map((v) => v.toJson()).toList();
    }
    if (this.bowlingPlayers != null) {
      data['bowling_players'] =
          this.bowlingPlayers!.map((v) => v.toJson()).toList();
    }
    if (this.wkPlayers != null) {
      data['wk_players'] = this.wkPlayers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
  int? id;
  String? teamName;

  Team({this.id, this.teamName});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['team_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_name'] = this.teamName;
    return data;
  }
}

class BattingPlayers {
  int? playerId;
  String? playerName;
  String? battingStyle;
  String? bowlingAction;
  String? bowlingStyle;
  int? runsScored;
  int? ballsFaced;
  int? isOut;

  BattingPlayers(
      {this.playerId,
        this.playerName,
        this.battingStyle,
        this.bowlingAction,
        this.bowlingStyle,
        this.runsScored,
        this.ballsFaced,
        this.isOut});

  BattingPlayers.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    battingStyle = json['batting_style'];
    bowlingAction = json['bowling_action'];
    bowlingStyle = json['bowling_style'];
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    isOut = json['is_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['batting_style'] = this.battingStyle;
    data['bowling_action'] = this.bowlingAction;
    data['bowling_style'] = this.bowlingStyle;
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['is_out'] = this.isOut;
    return data;
  }
}

class BowlingPlayers {
  int? playerId;
  String? playerName;
  String? battingStyle;
  String? bowlingAction;
  String? bowlingStyle;
  String? overBall;
  int? maiden;
  int? runsConceded;
  int? wickets;
  int? active;

  BowlingPlayers(
      {this.playerId,
        this.playerName,
        this.battingStyle,
        this.bowlingAction,
        this.bowlingStyle,
        this.overBall,
        this.maiden,
        this.runsConceded,
        this.wickets,
        this.active});

  BowlingPlayers.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    battingStyle = json['batting_style'];
    bowlingAction = json['bowling_action'];
    bowlingStyle = json['bowling_style'];
    overBall = json['over_ball'];
    maiden = json['maiden'];
    runsConceded = json['runs_conceded'];
    wickets = json['wickets'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['batting_style'] = this.battingStyle;
    data['bowling_action'] = this.bowlingAction;
    data['bowling_style'] = this.bowlingStyle;
    data['over_ball'] = this.overBall;
    data['maiden'] = this.maiden;
    data['runs_conceded'] = this.runsConceded;
    data['wickets'] = this.wickets;
    data['active'] = this.active;
    return data;
  }
}


class WkPlayers {
  int? playerId;
  String? playerName;
  String? battingStyle;
  String? bowlingAction;
  String? bowlingStyle;
  int? runsScored;
  int? ballsFaced;
  int? isOut;

  WkPlayers(
      {this.playerId,
        this.playerName,
        this.battingStyle,
        this.bowlingAction,
        this.bowlingStyle,
        this.runsScored,
        this.ballsFaced,
        this.isOut});

  WkPlayers.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
    battingStyle = json['batting_style'];
    bowlingAction = json['bowling_action'];
    bowlingStyle = json['bowling_style'];
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    isOut = json['is_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    data['batting_style'] = this.battingStyle;
    data['bowling_action'] = this.bowlingAction;
    data['bowling_style'] = this.bowlingStyle;
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['is_out'] = this.isOut;
    return data;
  }
}