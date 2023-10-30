class ScoreCardYetTobat {
  bool? status;
  String? message;
  List<Data>? data;

  ScoreCardYetTobat({this.status, this.message, this.data});

  ScoreCardYetTobat.fromJson(Map<String, dynamic> json) {
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
  String? playerName;
  String? battingStyle;

  Data({this.playerName, this.battingStyle});

  Data.fromJson(Map<String, dynamic> json) {
    playerName = json['player_name'];
    battingStyle = json['batting_style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_name'] = this.playerName;
    data['batting_style'] = this.battingStyle;
    return data;
  }
}
