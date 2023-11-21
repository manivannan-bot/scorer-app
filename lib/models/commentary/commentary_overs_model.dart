class CommentaryOversModel {
  bool? status;
  String? message;
  Data? data;

  CommentaryOversModel({this.status, this.message, this.data});

  CommentaryOversModel.fromJson(Map<String, dynamic> json) {
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
  int? overNumber;
  List<NoOfBalls>? noOfBalls;
  String? overRun;

  Innings1({this.overNumber, this.noOfBalls, this.overRun});

  Innings1.fromJson(Map<String, dynamic> json) {
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

class Innings2 {
  int? overNumber;
  List<NoOfBalls>? noOfBalls;
  String? overRun;

  Innings2({this.overNumber, this.noOfBalls, this.overRun});

  Innings2.fromJson(Map<String, dynamic> json) {
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
  int? innings;
  int? ballNumber;
  int? runsScored;
  int? wicket;
  String? ballType;
  String? slugData;

  NoOfBalls(
      {this.innings,
        this.ballNumber,
        this.runsScored,
        this.wicket,
        this.ballType,
        this.slugData});

  NoOfBalls.fromJson(Map<String, dynamic> json) {
    innings = json['innings'];
    ballNumber = json['ball_number'];
    runsScored = json['runs_scored'];
    wicket = json['wicket'];
    ballType = json['ball_type'];
    slugData = json['slug_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['innings'] = this.innings;
    data['ball_number'] = this.ballNumber;
    data['runs_scored'] = this.runsScored;
    data['wicket'] = this.wicket;
    data['ball_type'] = this.ballType;
    data['slug_data'] = this.slugData;
    return data;
  }
}