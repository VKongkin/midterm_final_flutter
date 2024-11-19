import 'data.dart';

class UserResponse {
  UserResponse({
      this.message, 
      this.messageKh, 
      this.messageCh, 
      this.code, 
      this.data,});

  UserResponse.fromJson(dynamic json) {
    message = json['message'];
    messageKh = json['messageKh'];
    messageCh = json['messageCh'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  String? messageKh;
  String? messageCh;
  String? code;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['messageKh'] = messageKh;
    map['messageCh'] = messageCh;
    map['code'] = code;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}