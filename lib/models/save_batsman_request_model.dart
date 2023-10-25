class SaveBatsmanDetailRequestModel {
  List<Batsman>? batsman;

  SaveBatsmanDetailRequestModel({this.batsman});

  SaveBatsmanDetailRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['batsman'] != null) {
      batsman = <Batsman>[];
      json['batsman'].forEach((v) {
        batsman!.add(new Batsman.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.batsman != null) {
      data['batsman'] = this.batsman!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Batsman {
  int? matchId;
  int? teamId;
  int? playerId;
  bool? striker;

  Batsman({this.matchId, this.teamId, this.playerId, this.striker});

  Batsman.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'];
    teamId = json['team_id'];
    playerId = json['player_id'];
    striker = json['striker'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['team_id'] = this.teamId;
    data['player_id'] = this.playerId;
    data['striker'] = this.striker;
    return data;
  }
}
