import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/domain/entities/user.dart';
import 'package:crypto_now/domain/repository/user_repository.dart';

class LoginUseCase {
  final UserRepository _userRepository;

  LoginUseCase(this._userRepository);

  Future<Result<User, String>> call(String email, String password) =>
      _userRepository.login(email, password);
}
