class ScoringDetailResponseModel {
  bool? status;
  dynamic message;
  Data? data;

  ScoringDetailResponseModel({status, message, data});

  ScoringDetailResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
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

  Data({batting, bowling, over});

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
    if (batting != null) {
      data['batting'] = batting!.map((v) => v.toJson()).toList();
    }
    if (bowling != null) {
      data['bowling'] = bowling!.toJson();
    }
    if (over != null) {
      data['over'] = over!.map((v) => v.toJson()).toList();
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
  dynamic striker;
  dynamic playerName;

  Batting(
      {matchId,
        playerId,
        teamId,
        runsScored,
        ballsFaced,
        fours,
        sixes,
        strikeRate,
        striker,
        playerName});

  Batting.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    playerId = json['player_id'];
    teamId = json['team_id'];
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    fours = json['fours'];
    sixes = json['sixes'];
    strikeRate = json['strike_rate'];
    striker = json['stricker'];
    playerName = json['player_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = matchId;
    data['player_id'] = playerId;
    data['team_id'] = teamId;
    data['runs_scored'] = runsScored;
    data['balls_faced'] = ballsFaced;
    data['fours'] = fours;
    data['sixes'] = sixes;
    data['strike_rate'] = strikeRate;
    data['stricker'] = striker;
    data['player_name'] = playerName;
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
      {bowlingId,
        matchId,
        playerId,
        teamId,
        oversBowled,
        overBall,
        runsConceded,
        wickets,
        extras,
        maiden,
        totalBalls,
        economy,
        createdAt,
        updatedAt,
        playerName});

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
    data['bowling_id'] = bowlingId;
    data['match_id'] = matchId;
    data['player_id'] = playerId;
    data['team_id'] = teamId;
    data['overs_bowled'] = oversBowled;
    data['over_ball'] = overBall;
    data['runs_conceded'] = runsConceded;
    data['wickets'] = wickets;
    data['extras'] = extras;
    data['maiden'] = maiden;
    data['total_balls'] = totalBalls;
    data['economy'] = economy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['player_name'] = playerName;
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
      {ballId,
        ballTypeId,
        matchId,
        battingTeamId,
        bowlingTeamId,
        scorerId,
        strikerId,
        nonStrikerId,
        wicketKeeperId,
        bowlerId,
        overNumber,
        ballNumber,
        runsScored,
        extras,
        extrasType,
        wicket,
        wicketById,
        dismissalType,
        commentary,
        fieldingPositionsId,
        innings,
        createdAt,
        updatedAt,
        slug});

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
    slug = json['slug_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ball_id'] = ballId;
    data['ball_type_id'] = ballTypeId;
    data['match_id'] = matchId;
    data['batting_team_id'] = battingTeamId;
    data['bowling_team_id'] = bowlingTeamId;
    data['scorer_id'] = scorerId;
    data['striker_id'] = strikerId;
    data['non_striker_id'] = nonStrikerId;
    data['wicket_keeper_id'] = wicketKeeperId;
    data['bowler_id'] = bowlerId;
    data['over_number'] = overNumber;
    data['ball_number'] = ballNumber;
    data['runs_scored'] = runsScored;
    data['extras'] = extras;
    data['extras_type'] = extrasType;
    data['wicket'] = wicket;
    data['wicket_by_id'] = wicketById;
    data['dismissal_type'] = dismissalType;
    data['commentary'] = commentary;
    data['fielding_positions_id'] = fieldingPositionsId;
    data['innings'] = innings;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['slug_data'] = slug;
    return data;
  }
}
