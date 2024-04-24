import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/data/datasource/local/user_local_data_source.dart';
import 'package:crypto_now/data/models/user_dto.dart';
import 'package:crypto_now/domain/entities/user.dart';
import 'package:crypto_now/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl(this._localDataSource);

  @override
  Future<Result<User, String>> login(String email, String password) async {
    final user = await _localDataSource.getUserByEmail(email);
    if (user != null) {
      if (user.password == password) {
        await _localDataSource.updateUserLogged(user.id!);
        return Success(user.toDomain());
      } else {
        return const Failure(
            "Unable to log in, please check your password and try again.");
      }
    } else {
      return const Failure(
          "Unable to log in, please check your details and try again.");
    }
  }

  @override
  Future<Result<User, String>> registerUser(User user) async {
    final userCreated = await _localDataSource.insertUser(user.toDto());
    if (userCreated != null) {
      return Success(userCreated.toDomain());
    } else {
      return const Failure(
          "Unable to register user, check the information and try again.");
    }
  }
}
