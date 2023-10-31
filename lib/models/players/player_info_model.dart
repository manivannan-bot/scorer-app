class PlayerInfoModel {
  bool? status;
  String? message;
  Data? data;

  PlayerInfoModel({this.status, this.message, this.data});

  PlayerInfoModel.fromJson(Map<String, dynamic> json) {
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
  UserDetails? userDetails;

  Data({this.userDetails});

  Data.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? name;
  String? dob;
  String? location;
  String? battingStyle;
  String? battingOrder;
  String? bowlingAction;
  String? bowlingStyle;
  int? battingRole;
  int? bowlingRole;
  int? wicketKeeper;
  String? bowlingProficiency;

  UserDetails(
      {this.name,
        this.dob,
        this.location,
        this.battingStyle,
        this.battingOrder,
        this.bowlingAction,
        this.bowlingStyle,
        this.battingRole,
        this.bowlingRole,
        this.wicketKeeper,
        this.bowlingProficiency});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dob = json['dob'];
    location = json['location'];
    battingStyle = json['batting_style'];
    battingOrder = json['batting_order'];
    bowlingAction = json['bowling_action'];
    bowlingStyle = json['bowling_style'];
    battingRole = json['batting_role'];
    bowlingRole = json['bowling_role'];
    wicketKeeper = json['wicket_keeper'];
    bowlingProficiency = json['bowling_proficiency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['batting_style'] = this.battingStyle;
    data['batting_order'] = this.battingOrder;
    data['bowling_action'] = this.bowlingAction;
    data['bowling_style'] = this.bowlingStyle;
    data['batting_role'] = this.battingRole;
    data['bowling_role'] = this.bowlingRole;
    data['wicket_keeper'] = this.wicketKeeper;
    data['bowling_proficiency'] = this.bowlingProficiency;
    return data;
  }
}
