import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/domain/entities/user.dart';
import 'package:crypto_now/domain/repository/user_repository.dart';

class RegisterUserUseCase {
  final UserRepository _userRepository;

  RegisterUserUseCase(this._userRepository);

  Future<Result<User, String>> call(User user) => _userRepository.registerUser(user);
}
