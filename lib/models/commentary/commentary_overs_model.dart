class CommentaryOversModel {
  bool? status;
  String? message;
  List<Data>? data;

  CommentaryOversModel({this.status, this.message, this.data});

  CommentaryOversModel.fromJson(Map<String, dynamic> json) {
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
  List<NoOfBalls>? noOfBalls;
  String? overRun;

  Data({this.overNumber, this.noOfBalls, this.overRun});

  Data.fromJson(Map<String, dynamic> json) {
    overNumber = json['over_number'];
    if (json['no_of_balls'] != null) {
      noOfBalls = <NoOfBalls>[];
      json['no_of_balls'].forEach((v) {
        noOfBalls!.add(new NoOfBalls.fromJson(v));
      });
    }
    overRun = json['over_run'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['over_number'] = this.overNumber;
    if (this.noOfBalls != null) {
      data['no_of_balls'] = this.noOfBalls!.map((v) => v.toJson()).toList();
    }
    data['over_run'] = this.overRun;
    return data;
  }
}

class NoOfBalls {
  int? runsScored;
  int? wicket;
  String? ballType;
  String? slugData;

  NoOfBalls({this.runsScored, this.wicket, this.ballType, this.slugData});

  NoOfBalls.fromJson(Map<String, dynamic> json) {
    runsScored = json['runs_scored'];
    wicket = json['wicket'];
    ballType = json['ball_type'];
    slugData = json['slug_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['runs_scored'] = this.runsScored;
    data['wicket'] = this.wicket;
    data['ball_type'] = this.ballType;
    data['slug_data'] = this.slugData;
    return data;
  }
}
