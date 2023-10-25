class ScoreUpdateResponseModel {
  String? message;
  Data? data;

  ScoreUpdateResponseModel({this.message, this.data});

  ScoreUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? innings;
  bool? inningCompleted;
  String? inningsMessage;
  int? bowlerChange;
  int? overNumber;
  int? ballNumber;
  int? strikerId;
  int? nonStrikerId;

  Data(
      {this.innings,
        this.inningCompleted,
        this.inningsMessage,
        this.bowlerChange,
        this.overNumber,
        this.ballNumber,
        this.strikerId,
        this.nonStrikerId});

  Data.fromJson(Map<String, dynamic> json) {
    innings = json['innings'];
    inningCompleted = json['inning_completed'];
    inningsMessage = json['innings_message'];
    bowlerChange = json['bowler_change'];
    overNumber = json['over_number'];
    ballNumber = json['ballNumber'];
    strikerId = json['striker_id'];
    nonStrikerId = json['non_striker_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['innings'] = this.innings;
    data['inning_completed'] = this.inningCompleted;
    data['innings_message'] = this.inningsMessage;
    data['bowler_change'] = this.bowlerChange;
    data['over_number'] = this.overNumber;
    data['ballNumber'] = this.ballNumber;
    data['striker_id'] = this.strikerId;
    data['non_striker_id'] = this.nonStrikerId;
    return data;
  }
}
