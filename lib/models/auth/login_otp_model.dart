class LoginOtpModel {
  bool? status;
  String? message;
  User? user;
  String? token;

  LoginOtpModel({this.status, this.message, this.user, this.token});

  LoginOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? playerId;
  String? userCode;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? dob;
  String? twoFactorSecret;
  String? twoFactorRecoveryCodes;
  String? twoFactorConfirmedAt;
  String? mobileNo;
  String? alterMobileNo;
  String? captainDeviceToken;
  String? playerDeviceToken;
  String? organizerDeviceToken;
  String? viceCaptainDeviceToken;
  String? adminDeviceToken;
  String? profilePhoto;
  int? otp;
  int? active;
  String? createdAt;
  String? updatedAt;
  List<Roles>? roles;

  User(
      {this.id,
        this.playerId,
        this.userCode,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.dob,
        this.twoFactorSecret,
        this.twoFactorRecoveryCodes,
        this.twoFactorConfirmedAt,
        this.mobileNo,
        this.alterMobileNo,
        this.captainDeviceToken,
        this.playerDeviceToken,
        this.organizerDeviceToken,
        this.viceCaptainDeviceToken,
        this.adminDeviceToken,
        this.profilePhoto,
        this.otp,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['player_id'];
    userCode = json['user_code'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    dob = json['dob'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    mobileNo = json['mobile_no'];
    alterMobileNo = json['alter_mobile_no'];
    captainDeviceToken = json['captain_device_token'];
    playerDeviceToken = json['player_device_token'];
    organizerDeviceToken = json['organizer_device_token'];
    viceCaptainDeviceToken = json['vice_captain_device_token'];
    adminDeviceToken = json['admin_device_token'];
    profilePhoto = json['profile_photo'];
    otp = json['otp'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['player_id'] = this.playerId;
    data['user_code'] = this.userCode;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['dob'] = this.dob;
    data['two_factor_secret'] = this.twoFactorSecret;
    data['two_factor_recovery_codes'] = this.twoFactorRecoveryCodes;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['mobile_no'] = this.mobileNo;
    data['alter_mobile_no'] = this.alterMobileNo;
    data['captain_device_token'] = this.captainDeviceToken;
    data['player_device_token'] = this.playerDeviceToken;
    data['organizer_device_token'] = this.organizerDeviceToken;
    data['vice_captain_device_token'] = this.viceCaptainDeviceToken;
    data['admin_device_token'] = this.adminDeviceToken;
    data['profile_photo'] = this.profilePhoto;
    data['otp'] = this.otp;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
        this.name,
        this.guardName,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? modelId;
  int? roleId;
  String? modelType;

  Pivot({this.modelId, this.roleId, this.modelType});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['role_id'] = this.roleId;
    data['model_type'] = this.modelType;
    return data;
  }
}
