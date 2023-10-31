class PlayerTeamInfoModel {
  bool? status;
  String? message;
  List<Data>? data;

  PlayerTeamInfoModel({this.status, this.message, this.data});

  PlayerTeamInfoModel.fromJson(Map<String, dynamic> json) {
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
  int? matchWonBy;
  int? matchLossBy;
  int? teamId;
  int? played;
  String? teamName;
  String? logo;

  Data(
      {this.matchWonBy,
        this.matchLossBy,
        this.teamId,
        this.played,
        this.teamName,
        this.logo});

  Data.fromJson(Map<String, dynamic> json) {
    matchWonBy = json['match_won_by'];
    matchLossBy = json['match_loss_by'];
    teamId = json['team_id'];
    played = json['played'];
    teamName = json['team_name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_won_by'] = this.matchWonBy;
    data['match_loss_by'] = this.matchLossBy;
    data['team_id'] = this.teamId;
    data['played'] = this.played;
    data['team_name'] = this.teamName;
    data['logo'] = this.logo;
    return data;
  }
}
