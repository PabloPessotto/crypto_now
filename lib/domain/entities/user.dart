import 'package:crypto_now/data/models/user_dto.dart';

class User {
  int? id;
  String? email;
  String? password;
  int? startSession;

  User({this.id, this.email, this.password, this.startSession});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        startSession: json["startSession"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "password": password,
      "startSession": startSession,
    };
  }
}

extension UserMapper on User? {
  UserDto toDto() {
    return UserDto(
      id: this?.id,
      email: this?.email,
      password: this?.password,
      startSession: this?.startSession,
    );
  }
}
