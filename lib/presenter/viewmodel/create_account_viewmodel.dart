import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/domain/entities/user.dart';
import 'package:crypto_now/domain/usecase/register_user_usecase.dart';
import 'package:crypto_now/presenter/view/initial_view.dart';
import 'package:crypto_now/shared/functions/push_views.dart';
import 'package:crypto_now/shared/resources/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerUserProvider = Provider<RegisterUserUseCase>((ref) {
  final repository = ref.read(userRepositoryProvider);
  return RegisterUserUseCase(repository);
});

class CreateAccountViewModel extends StateNotifier<User> {
  final RegisterUserUseCase _registerUserUseCase;

  CreateAccountViewModel(this._registerUserUseCase, this.ref) : super(User());
  final Ref ref;
  String? _confirmPassword;

  void setEmail(String email) {
    state.email = email;
  }

  void setPassword(String password) {
    state.password = password;
  }

  void setConfirmPassword(String password) {
    _confirmPassword = password;
  }

  String? validatePassword(String? password) {
    if ((password?.isEmpty ?? true) || password != state.password) {
      return '';
    } else {
      return null;
    }
  }

  void createAccount(BuildContext context) async {
    ref.read(loadingButtonProvider.notifier).loading();
    final result = await _registerUserUseCase.call(state);
    switch (result) {
      case Success(value: final userCreated):
        print('User created successfully - ${userCreated.toJson()}');
        ref.read(loadingButtonProvider.notifier).loading();
        pushUntilView(context, Routes.login);
      case Failure(value: final message):
        ref.read(loadingButtonProvider.notifier).loading();
        print('Failed - $message');
    }
  }
}

final obscurePasswordProvider =
    StateNotifierProvider<ObscurePasswordNotifier, bool>((ref) {
  return ObscurePasswordNotifier();
});

class ObscurePasswordNotifier extends StateNotifier<bool> {
  ObscurePasswordNotifier() : super(true);

  bool get obscurePassword => state;

  void showPassword() {
    state = !state;
    print('state obscure - $state');
  }
}

final loadingButtonProvider =
    StateNotifierProvider<LoadingButtonNotifier, bool>((ref) {
  return LoadingButtonNotifier();
});

class LoadingButtonNotifier extends StateNotifier<bool> {
  LoadingButtonNotifier() : super(false);

  bool get isLoading => state;

  void loading() {
    state = !state;
    print('state obscure - $state');
  }
}
