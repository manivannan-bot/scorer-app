class CommentaryWicketModel {
  bool? status;
  String? message;
  List<Data>? data;

  CommentaryWicketModel({this.status, this.message, this.data});

  CommentaryWicketModel.fromJson(Map<String, dynamic> json) {
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
  int? overNumber;
  int? ballNumber;
  String? over;
  int? runsScored;
  int? ballsFaced;
  String? bowlerName;
  String? wicketerName;
  String? batsmanName;
  String? outType;

  Data(
      {this.overNumber,
        this.ballNumber,
        this.over,
        this.runsScored,
        this.ballsFaced,
        this.bowlerName,
        this.wicketerName,
        this.batsmanName,
        this.outType});

  Data.fromJson(Map<String, dynamic> json) {
    overNumber = json['over_number'];
    ballNumber = json['ball_number'];
    over = json['over'];
    runsScored = json['runs_scored'];
    ballsFaced = json['balls_faced'];
    bowlerName = json['bowler_name'];
    wicketerName = json['wicketer_name'];
    batsmanName = json['batsman_name'];
    outType = json['out_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over_number'] = this.overNumber;
    data['ball_number'] = this.ballNumber;
    data['over'] = this.over;
    data['runs_scored'] = this.runsScored;
    data['balls_faced'] = this.ballsFaced;
    data['bowler_name'] = this.bowlerName;
    data['wicketer_name'] = this.wicketerName;
    data['batsman_name'] = this.batsmanName;
    data['out_type'] = this.outType;
    return data;
  }
}
