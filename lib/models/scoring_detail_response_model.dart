class ScoringDetailResponseModel {
  bool? status;
  dynamic message;
  Data? data;

  ScoringDetailResponseModel({this.status, this.message, this.data});

  ScoringDetailResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Batting>? batting;
  Bowling? bowling;
  List<Over>? over;

  Data({this.batting, this.bowling, this.over});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['batting'] != null) {
      batting = <Batting>[];
      json['batting'].forEach((v) {
        batting!.add(new Batting.fromJson(v));
      });
    }
    bowling =
    json['bowling'] != null ? new Bowling.fromJson(json['bowling']) : null;
    if (json['over'] != null) {
      over = <Over>[];
      json['over'].forEach((v) {
        over!.add(new Over.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.batting != null) {
      data['batting'] = this.batting!.map((v) => v.toJson()).toList();
    }
    if (this.bowling != null) {
      data['bowling'] = this.bowling!.toJson();
    }
    if (this.over != null) {
      data['over'] = this.over!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batting {
  dynamic matchId;
  dynamic playerId;
  dynamic teamId;
  dynamic runsScored;
  dynamic ballsFaced;
  dynamic fours;
  dynamic sixes;
  dynamic strikeRate;
  dynamic stricker;
  dynamic playerName;

  Batting(
      {this.matchId,
        this.playerId,
        this.teamId,
        this.runsScored,
        this.ballsFaced,
        this.fours,
        this.sixes,
        this.strikeRate,
        this.stricker,
        this.playerName});

  Batting.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    playerId = json['player_id'];
    teamId = json['team_id'];
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    fours = json['fours'];
    sixes = json['sixes'];
    strikeRate = json['strike_rate'];
    stricker = json['stricker'];
    playerName = json['player_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['player_id'] = this.playerId;
    data['team_id'] = this.teamId;
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['fours'] = this.fours;
    data['sixes'] = this.sixes;
    data['strike_rate'] = this.strikeRate;
    data['stricker'] = this.stricker;
    data['player_name'] = this.playerName;
    return data;
  }
}

class Bowling {
  dynamic bowlingId;
  dynamic matchId;
  dynamic playerId;
  dynamic teamId;
  dynamic oversBowled;
  dynamic overBall;
  dynamic runsConceded;
  dynamic wickets;
  dynamic extras;
  dynamic maiden;
  dynamic totalBalls;
  dynamic economy;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic playerName;

  Bowling(
      {this.bowlingId,
        this.matchId,
        this.playerId,
        this.teamId,
        this.oversBowled,
        this.overBall,
        this.runsConceded,
        this.wickets,
        this.extras,
        this.maiden,
        this.totalBalls,
        this.economy,
        this.createdAt,
        this.updatedAt,
        this.playerName});

  Bowling.fromJson(Map<String, dynamic> json) {
    bowlingId = json['bowling_id'];
    matchId = json['match_id'];
    playerId = json['player_id'];
    teamId = json['team_id'];
    oversBowled = json['overs_bowled'];
    overBall = json['over_ball'];
    runsConceded = json['runs_conceded'];
    wickets = json['wickets'];
    extras = json['extras'];
    maiden = json['maiden'];
    totalBalls = json['total_balls'];
    economy = json['economy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    playerName = json['player_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bowling_id'] = this.bowlingId;
    data['match_id'] = this.matchId;
    data['player_id'] = this.playerId;
    data['team_id'] = this.teamId;
    data['overs_bowled'] = this.oversBowled;
    data['over_ball'] = this.overBall;
    data['runs_conceded'] = this.runsConceded;
    data['wickets'] = this.wickets;
    data['extras'] = this.extras;
    data['maiden'] = this.maiden;
    data['total_balls'] = this.totalBalls;
    data['economy'] = this.economy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['player_name'] = this.playerName;
    return data;
  }
}

class Over {
  dynamic ballId;
  dynamic ballTypeId;
  dynamic matchId;
  dynamic battingTeamId;
  dynamic bowlingTeamId;
  dynamic scorerId;
  dynamic strikerId;
  dynamic nonStrikerId;
  dynamic wicketKeeperId;
  dynamic bowlerId;
  dynamic overNumber;
  dynamic ballNumber;
  dynamic runsScored;
  dynamic extras;
  dynamic extrasType;
  dynamic wicket;
  dynamic wicketById;
  dynamic dismissalType;
  dynamic commentary;
  dynamic fieldingPositionsId;
  dynamic innings;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic slug;

  Over(
      {this.ballId,
        this.ballTypeId,
        this.matchId,
        this.battingTeamId,
        this.bowlingTeamId,
        this.scorerId,
        this.strikerId,
        this.nonStrikerId,
        this.wicketKeeperId,
        this.bowlerId,
        this.overNumber,
        this.ballNumber,
        this.runsScored,
        this.extras,
        this.extrasType,
        this.wicket,
        this.wicketById,
        this.dismissalType,
        this.commentary,
        this.fieldingPositionsId,
        this.innings,
        this.createdAt,
        this.updatedAt,
        this.slug});

  Over.fromJson(Map<String, dynamic> json) {
    ballId = json['ball_id'];
    ballTypeId = json['ball_type_id'];
    matchId = json['match_id'];
    battingTeamId = json['batting_team_id'];
    bowlingTeamId = json['bowling_team_id'];
    scorerId = json['scorer_id'];
    strikerId = json['striker_id'];
    nonStrikerId = json['non_striker_id'];
    wicketKeeperId = json['wicket_keeper_id'];
    bowlerId = json['bowler_id'];
    overNumber = json['over_number'];
    ballNumber = json['ball_number'];
    runsScored = json['runs_scored'];
    extras = json['extras'];
    extrasType = json['extras_type'];
    wicket = json['wicket'];
    wicketById = json['wicket_by_id'];
    dismissalType = json['dismissal_type'];
    commentary = json['commentary'];
    fieldingPositionsId = json['fielding_positions_id'];
    innings = json['innings'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ball_id'] = this.ballId;
    data['ball_type_id'] = this.ballTypeId;
    data['match_id'] = this.matchId;
    data['batting_team_id'] = this.battingTeamId;
    data['bowling_team_id'] = this.bowlingTeamId;
    data['scorer_id'] = this.scorerId;
    data['striker_id'] = this.strikerId;
    data['non_striker_id'] = this.nonStrikerId;
    data['wicket_keeper_id'] = this.wicketKeeperId;
    data['bowler_id'] = this.bowlerId;
    data['over_number'] = this.overNumber;
    data['ball_number'] = this.ballNumber;
    data['runs_scored'] = this.runsScored;
    data['extras'] = this.extras;
    data['extras_type'] = this.extrasType;
    data['wicket'] = this.wicket;
    data['wicket_by_id'] = this.wicketById;
    data['dismissal_type'] = this.dismissalType;
    data['commentary'] = this.commentary;
    data['fielding_positions_id'] = this.fieldingPositionsId;
    data['innings'] = this.innings;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    return data;
  }
}
