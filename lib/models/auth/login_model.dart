class LoginModel {
  bool? status;
  dynamic message;
  Data? data;
  LoginModel({this.status, this.message, this.data});
  LoginModel.fromJson(Map<String, dynamic> json) {
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
  dynamic userId;
  dynamic name;
  dynamic otp;
  Data({this.userId, this.name, this.otp});
  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    otp = json['otp'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['otp'] = this.otp;
    return data;
  }
}