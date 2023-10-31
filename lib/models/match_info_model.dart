class MatchInfoModel {
  bool? status;
  dynamic message;
  Data? data;

  MatchInfoModel({this.status, this.message, this.data});

  MatchInfoModel.fromJson(Map<String, dynamic> json) {
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
  MatchDetails? matchDetails;
  Playing11? playing11;
  HeadToHead? headToHead;
  List<Proffesionals>? proffesionals;

  Data(
      {this.matchDetails, this.playing11, this.headToHead, this.proffesionals});

  Data.fromJson(Map<String, dynamic> json) {
    matchDetails = json['matchDetails'] != null
        ? new MatchDetails.fromJson(json['matchDetails'])
        : null;
    playing11 = json['playing11'] != null
        ? new Playing11.fromJson(json['playing11'])
        : null;
    headToHead = json['headToHead'] != null
        ? new HeadToHead.fromJson(json['headToHead'])
        : null;
    if (json['proffesionals'] != null) {
      proffesionals = <Proffesionals>[];
      json['proffesionals'].forEach((v) {
        proffesionals!.add(new Proffesionals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.matchDetails != null) {
      data['matchDetails'] = this.matchDetails!.toJson();
    }
    if (this.playing11 != null) {
      data['playing11'] = this.playing11!.toJson();
    }
    if (this.headToHead != null) {
      data['headToHead'] = this.headToHead!.toJson();
    }
    if (this.proffesionals != null) {
      data['proffesionals'] =
          this.proffesionals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MatchDetails {
  dynamic matchDate;
  dynamic slotTime;
  dynamic team1Name;
  dynamic team1Logo;
  dynamic team2Name;
  dynamic team2Logo;
  dynamic organiser;
  dynamic team2Id;
  dynamic team1Id;
  dynamic ground;
  dynamic venue;

  MatchDetails(
      {this.matchDate,
        this.slotTime,
        this.team1Name,
        this.team1Logo,
        this.team2Name,
        this.team2Logo,
        this.organiser,
        this.team2Id,
        this.team1Id,
        this.ground,
        this.venue});

  MatchDetails.fromJson(Map<String, dynamic> json) {
    matchDate = json['match_date'];
    slotTime = json['slot_time'];
    team1Name = json['team1_name'];
    team1Logo = json['team1_logo'];
    team2Name = json['team2_name'];
    team2Logo = json['team2_logo'];
    organiser = json['organiser'];
    team2Id = json['team_2_id'];
    team1Id = json['team_1_id'];
    ground = json['ground'];
    venue = json['venue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_date'] = this.matchDate;
    data['slot_time'] = this.slotTime;
    data['team1_name'] = this.team1Name;
    data['team1_logo'] = this.team1Logo;
    data['team2_name'] = this.team2Name;
    data['team2_logo'] = this.team2Logo;
    data['organiser'] = this.organiser;
    data['team_2_id'] = this.team2Id;
    data['team_1_id'] = this.team1Id;
    data['ground'] = this.ground;
    data['venue'] = this.venue;
    return data;
  }
}

class Playing11 {
  dynamic team1Name;
  dynamic team1Id;
  dynamic team1Logo;
  dynamic team2Name;
  dynamic team2Id;
  dynamic team2Logo;

  Playing11(
      {this.team1Name,
        this.team1Id,
        this.team1Logo,
        this.team2Name,
        this.team2Id,
        this.team2Logo});

  Playing11.fromJson(Map<String, dynamic> json) {
    team1Name = json['team1_name'];
    team1Id = json['team1_id'];
    team1Logo = json['team1_logo'];
    team2Name = json['team2_name'];
    team2Id = json['team2_id'];
    team2Logo = json['team2_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team1_name'] = this.team1Name;
    data['team1_id'] = this.team1Id;
    data['team1_logo'] = this.team1Logo;
    data['team2_name'] = this.team2Name;
    data['team2_id'] = this.team2Id;
    data['team2_logo'] = this.team2Logo;
    return data;
  }
}

class HeadToHead {
  dynamic team1Name;
  dynamic team1Id;
  dynamic team1Logo;
  dynamic team1Won;
  dynamic team2Name;
  dynamic team2Id;
  dynamic team2Logo;
  dynamic team2Won;

  HeadToHead(
      {this.team1Name,
        this.team1Id,
        this.team1Logo,
        this.team1Won,
        this.team2Name,
        this.team2Id,
        this.team2Logo,
        this.team2Won});

  HeadToHead.fromJson(Map<String, dynamic> json) {
    team1Name = json['team1_name'];
    team1Id = json['team1_id'];
    team1Logo = json['team1_logo'];
    team1Won = json['team1_won'];
    team2Name = json['team2_name'];
    team2Id = json['team2_id'];
    team2Logo = json['team2_logo'];
    team2Won = json['team2_won'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team1_name'] = this.team1Name;
    data['team1_id'] = this.team1Id;
    data['team1_logo'] = this.team1Logo;
    data['team1_won'] = this.team1Won;
    data['team2_name'] = this.team2Name;
    data['team2_id'] = this.team2Id;
    data['team2_logo'] = this.team2Logo;
    data['team2_won'] = this.team2Won;
    return data;
  }
}

class Proffesionals {
  dynamic umpireName;
  dynamic scorerName;
  dynamic umpireProfile;
  dynamic scorerProfile;

  Proffesionals(
      {this.umpireName,
        this.scorerName,
        this.umpireProfile,
        this.scorerProfile});

  Proffesionals.fromJson(Map<String, dynamic> json) {
    umpireName = json['umpire_name'];
    scorerName = json['scorer_name'];
    umpireProfile = json['umpire_profile'];
    scorerProfile = json['scorer_profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['umpire_name'] = this.umpireName;
    data['scorer_name'] = this.scorerName;
    data['umpire_profile'] = this.umpireProfile;
    data['scorer_profile'] = this.scorerProfile;
    return data;
  }
}
