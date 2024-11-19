class UserRequest {
  UserRequest({
      this.id, 
      this.firstName, 
      this.lastName, 
      this.username, 
      this.email, 
      this.phoneNumber, 
      this.password, 
      this.confirmPassword, 
      this.profile, 
      this.status, 
      this.role,});

  UserRequest.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    profile = json['profile'];
    status = json['status'];
    role = json['role'];
  }
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? phoneNumber;
  String? password;
  String? confirmPassword;
  String? profile;
  String? status;
  String? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['username'] = username;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    map['profile'] = profile;
    map['status'] = status;
    map['role'] = role;
    return map;
  }

}