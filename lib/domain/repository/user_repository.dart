import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Result<User, String>> registerUser(User user);
  Future<Result<User, String>> login(String email, String password);
}
