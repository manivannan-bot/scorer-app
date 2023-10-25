class EndInningsResponseModel {
  String? message;
  Match? match;

  EndInningsResponseModel({this.message, this.match});

  EndInningsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    match = json['match'] != null ? new Match.fromJson(json['match']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.match != null) {
      data['match'] = this.match!.toJson();
    }
    return data;
  }
}

class Match {
  int? matchId;
  String? matchNumber;
  int? team1Id;
  int? team2Id;
  int? scorerId;
  int? umpireId;
  String? date;
  String? venue;
  dynamic result;
  String? slotStartTime;
  String? slotEndTime;
  String? organiser;
  String? ground;
  int? wonBy;
  String? choseTo;
  String? overs;
  int? currentInnings;
  int? matchStatus;
  dynamic createdAt;
  String? updatedAt;

  Match(
      {this.matchId,
        this.matchNumber,
        this.team1Id,
        this.team2Id,
        this.scorerId,
        this.umpireId,
        this.date,
        this.venue,
        this.result,
        this.slotStartTime,
        this.slotEndTime,
        this.organiser,
        this.ground,
        this.wonBy,
        this.choseTo,
        this.overs,
        this.currentInnings,
        this.matchStatus,
        this.createdAt,
        this.updatedAt});

  Match.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    matchNumber = json['match_number'];
    team1Id = json['team_1_id'];
    team2Id = json['team_2_id'];
    scorerId = json['scorer_id'];
    umpireId = json['umpire_id'];
    date = json['date'];
    venue = json['venue'];
    result = json['result'];
    slotStartTime = json['slot_start_time'];
    slotEndTime = json['slot_end_time'];
    organiser = json['organiser'];
    ground = json['ground'];
    wonBy = json['won_by'];
    choseTo = json['chose_to'];
    overs = json['overs'];
    currentInnings = json['current_innings'];
    matchStatus = json['match_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['match_number'] = this.matchNumber;
    data['team_1_id'] = this.team1Id;
    data['team_2_id'] = this.team2Id;
    data['scorer_id'] = this.scorerId;
    data['umpire_id'] = this.umpireId;
    data['date'] = this.date;
    data['venue'] = this.venue;
    data['result'] = this.result;
    data['slot_start_time'] = this.slotStartTime;
    data['slot_end_time'] = this.slotEndTime;
    data['organiser'] = this.organiser;
    data['ground'] = this.ground;
    data['won_by'] = this.wonBy;
    data['chose_to'] = this.choseTo;
    data['overs'] = this.overs;
    data['current_innings'] = this.currentInnings;
    data['match_status'] = this.matchStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
