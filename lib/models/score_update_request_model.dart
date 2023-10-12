class ScoreUpdateRequestModel {
  int? ballTypeId;
  int? matchId;
  int? scorerId;
  int? strikerId;
  int? nonStrikerId;
  int? wicketKeeperId;
  int? bowlerId;
  int? overNumber;
  int? ballNumber;
  int? runsScored;
  int? extras;
  int? wicket;
  int? dismissalType;
  int? commentary;
  int? innings;
  int? battingTeamId;
  int? bowlingTeamId;
  int? overBowled;
  int? totalOverBowled;
  int? outByPlayer;
  int? outPlayer;
  int? totalWicket;
  int? fieldingPositionsId;
  bool? endInnings;

  ScoreUpdateRequestModel(
      {this.ballTypeId,
        this.matchId,
        this.scorerId,
        this.strikerId,
        this.nonStrikerId,
        this.wicketKeeperId,
        this.bowlerId,
        this.overNumber,
        this.ballNumber,
        this.runsScored,
        this.extras,
        this.wicket,
        this.dismissalType,
        this.commentary,
        this.innings,
        this.battingTeamId,
        this.bowlingTeamId,
        this.overBowled,
        this.totalOverBowled,
        this.outByPlayer,
        this.outPlayer,
        this.totalWicket,
        this.fieldingPositionsId,
        this.endInnings});

  ScoreUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    ballTypeId = json['ball_type_id'];
    matchId = json['match_id'];
    scorerId = json['scorer_id'];
    strikerId = json['striker_id'];
    nonStrikerId = json['non_striker_id'];
    wicketKeeperId = json['wicket_keeper_id'];
    bowlerId = json['bowler_id'];
    overNumber = json['over_number'];
    ballNumber = json['ball_number'];
    runsScored = json['runs_scored'];
    extras = json['extras'];
    wicket = json['wicket'];
    dismissalType = json['dismissal_type'];
    commentary = json['commentary'];
    innings = json['innings'];
    battingTeamId = json['batting_team_id'];
    bowlingTeamId = json['bowling_team_id'];
    overBowled = json['over_bowled'];
    totalOverBowled = json['total_over_bowled'];
    outByPlayer = json['out_by_player'];
    outPlayer = json['out_player'];
    totalWicket = json['total_wicket'];
    fieldingPositionsId = json['fielding_positions_id'];
    endInnings = json['end_innings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ball_type_id'] = this.ballTypeId;
    data['match_id'] = this.matchId;
    data['scorer_id'] = this.scorerId;
    data['striker_id'] = this.strikerId;
    data['non_striker_id'] = this.nonStrikerId;
    data['wicket_keeper_id'] = this.wicketKeeperId;
    data['bowler_id'] = this.bowlerId;
    data['over_number'] = this.overNumber;
    data['ball_number'] = this.ballNumber;
    data['runs_scored'] = this.runsScored;
    data['extras'] = this.extras;
    data['wicket'] = this.wicket;
    data['dismissal_type'] = this.dismissalType;
    data['commentary'] = this.commentary;
    data['innings'] = this.innings;
    data['batting_team_id'] = this.battingTeamId;
    data['bowling_team_id'] = this.bowlingTeamId;
    data['over_bowled'] = this.overBowled;
    data['total_over_bowled'] = this.totalOverBowled;
    data['out_by_player'] = this.outByPlayer;
    data['out_player'] = this.outPlayer;
    data['total_wicket'] = this.totalWicket;
    data['fielding_positions_id'] = this.fieldingPositionsId;
    data['end_innings'] = this.endInnings;
    return data;
  }
}
