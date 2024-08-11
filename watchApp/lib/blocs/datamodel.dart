class UserDataModel {
  String uid;
  String userType;
  String name;
  String email;
  String phone;
  String address;
  String ephone1;
  UserDataModel(
      {required this.uid,
      required this.userType,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.ephone1});
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      uid: json['uid'],
      userType: json['userType'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      ephone1: json['ephone1'],
    );
  }
}
class CommunityDataModel {
  String uid;
  String name;
  CommunityDataModel(
      {required this.uid,
      required this.name});
  factory CommunityDataModel.fromJson(Map<String, dynamic> json) {
    return CommunityDataModel(
      uid: json['uid'],
      name: json['name']
    );
  }
}

class DeviceDataModel {
  String uid;
  String type;
  String mfg;
  String api;
  String license;
  String description;
  DeviceDataModel(
      {required this.uid,
      required this.type,
      required this.mfg,
      required this.api,
      required this.license,
      required this.description
      
      });
  factory DeviceDataModel.fromJson(Map<String, dynamic> json) {
    return DeviceDataModel(
      uid: json['uid'],
      type: json['type'],
      mfg: json['mfg'],
      api: json['api'],
      license: json['license'],
      description: json['description']
    );
  }
}

class PromptDataModel {
  String uid;
  DateTime dttm;
  String prompt;
  String res;
  bool like;
  bool unlike;
  bool bookmark;
  String file;
  PromptDataModel(
      {required this.uid,
      required this.dttm,
      required this.prompt,
      required this.res,
      required this.like,
      required this.unlike,
      required this.bookmark,
      required this.file});
  factory PromptDataModel.fromJson(Map<String, dynamic> json) {
    return PromptDataModel(
      uid: json['uid'],
      dttm: json['dttm'],
      prompt: json['prompt'],
      res: json['res'],
      like: json['like'],
      unlike: json['unlike'],
      bookmark: json['bookmark'],
      file: json['file']
    );
  }
}

class LoginDataModel {
  String email;
  String password;
  LoginDataModel({required this.email, required this.password});
}
