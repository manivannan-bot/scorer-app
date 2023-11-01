class CommentaryFourSixModel {
  bool? status;
  String? message;
  List<Data>? data;

  CommentaryFourSixModel({this.status, this.message, this.data});

  CommentaryFourSixModel.fromJson(Map<String, dynamic> json) {
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
  int? runsScored;
  int? overNumber;
  int? ballNumber;
  String? batsmanName;
  String? bowlerName;
  String? ballScored;

  Data(
      {this.runsScored,
        this.overNumber,
        this.ballNumber,
        this.batsmanName,
        this.bowlerName,
        this.ballScored});

  Data.fromJson(Map<String, dynamic> json) {
    runsScored = json['runs_scored'];
    overNumber = json['over_number'];
    ballNumber = json['ball_number'];
    batsmanName = json['batsman_name'];
    bowlerName = json['bowler_name'];
    ballScored = json['ball_scored'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runs_scored'] = this.runsScored;
    data['over_number'] = this.overNumber;
    data['ball_number'] = this.ballNumber;
    data['batsman_name'] = this.batsmanName;
    data['bowler_name'] = this.bowlerName;
    data['ball_scored'] = this.ballScored;
    return data;
  }
}
