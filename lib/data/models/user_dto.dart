import 'package:crypto_now/domain/entities/user.dart';

class UserDto {
  int? id;
  String? email;
  String? password;
  int? startSession;

  UserDto({this.id, this.email, this.password, this.startSession});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
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

extension UserDtoMapper on UserDto? {
  User toDomain() {
    return User(
      id: this?.id,
      email: this?.email,
      password: this?.password,
      startSession: this?.startSession,
    );
  }
}
