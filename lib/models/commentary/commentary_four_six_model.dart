class CommentaryFourSixModel {
  bool? status;
  String? message;
  Data? data;

  CommentaryFourSixModel({this.status, this.message, this.data});

  CommentaryFourSixModel.fromJson(Map<String, dynamic> json) {
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
  List<Innings1>? innings1;
  List<Innings2>? innings2;

  Data({this.innings1, this.innings2});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['innings1'] != null) {
      innings1 = <Innings1>[];
      json['innings1'].forEach((v) {
        innings1!.add(new Innings1.fromJson(v));
      });
    }
    if (json['innings2'] != null) {
      innings2 = <Innings2>[];
      json['innings2'].forEach((v) {
        innings2!.add(new Innings2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.innings1 != null) {
      data['innings1'] = this.innings1!.map((v) => v.toJson()).toList();
    }
    if (this.innings2 != null) {
      data['innings2'] = this.innings2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Innings1 {
  int? innings;
  int? runsScored;
  int? overNumber;
  int? ballNumber;
  String? batsmanName;
  String? bowlerName;
  String? ballScored;

  Innings1(
      {this.innings,
        this.runsScored,
        this.overNumber,
        this.ballNumber,
        this.batsmanName,
        this.bowlerName,
        this.ballScored});

  Innings1.fromJson(Map<String, dynamic> json) {
    innings = json['innings'];
    runsScored = json['runs_scored'];
    overNumber = json['over_number'];
    ballNumber = json['ball_number'];
    batsmanName = json['batsman_name'];
    bowlerName = json['bowler_name'];
    ballScored = json['ball_scored'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['innings'] = this.innings;
    data['runs_scored'] = this.runsScored;
    data['over_number'] = this.overNumber;
    data['ball_number'] = this.ballNumber;
    data['batsman_name'] = this.batsmanName;
    data['bowler_name'] = this.bowlerName;
    data['ball_scored'] = this.ballScored;
    return data;
  }
}


class Innings2 {
  int? innings;
  int? runsScored;
  int? overNumber;
  int? ballNumber;
  String? batsmanName;
  String? bowlerName;
  String? ballScored;

  Innings2(
      {this.innings,
        this.runsScored,
        this.overNumber,
        this.ballNumber,
        this.batsmanName,
        this.bowlerName,
        this.ballScored});

  Innings2.fromJson(Map<String, dynamic> json) {
    innings = json['innings'];
    runsScored = json['runs_scored'];
    overNumber = json['over_number'];
    ballNumber = json['ball_number'];
    batsmanName = json['batsman_name'];
    bowlerName = json['bowler_name'];
    ballScored = json['ball_scored'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['innings'] = this.innings;
    data['runs_scored'] = this.runsScored;
    data['over_number'] = this.overNumber;
    data['ball_number'] = this.ballNumber;
    data['batsman_name'] = this.batsmanName;
    data['bowler_name'] = this.bowlerName;
    data['ball_scored'] = this.ballScored;
    return data;
  }
}
