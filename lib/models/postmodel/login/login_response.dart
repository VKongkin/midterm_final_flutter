import 'user.dart';

class LoginResponse {
  LoginResponse({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.user,
  });

  // Constructor for parsing JSON
  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken']?.toString();
    tokenType = json['tokenType']?.toString();
    refreshToken = json['refreshToken']?.toString();
    expiresIn = json['expiresIn'] is int ? json['expiresIn'] : int.tryParse(json['expiresIn']?.toString() ?? '');
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  User? user;

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['tokenType'] = tokenType;
    map['refreshToken'] = refreshToken;
    map['expiresIn'] = expiresIn;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
