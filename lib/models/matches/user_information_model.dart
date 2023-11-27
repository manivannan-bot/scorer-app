class UserInformationModel {
  bool? status;
  String? message;
  List<Data>? data;

  UserInformationModel({this.status, this.message, this.data});

  UserInformationModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? dob;
  String? mobileNo;
  String? experience;
  String? location;
  String? state;
  String? city;
  String? pincode;
  int? matches;

  Data(
      {this.id,
        this.name,
        this.dob,
        this.mobileNo,
        this.experience,
        this.location,
        this.state,
        this.city,
        this.pincode,
        this.matches});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    mobileNo = json['mobile_no'];
    experience = json['experience'];
    location = json['location'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    matches = json['matches'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['mobile_no'] = this.mobileNo;
    data['experience'] = this.experience;
    data['location'] = this.location;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['matches'] = this.matches;
    return data;
  }
}
