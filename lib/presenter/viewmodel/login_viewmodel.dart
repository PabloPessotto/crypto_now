import 'package:crypto_now/core/result.dart';
import 'package:crypto_now/domain/entities/user.dart';
import 'package:crypto_now/domain/usecase/login_usecase.dart';
import 'package:crypto_now/presenter/view/initial_view.dart';
import 'package:crypto_now/shared/functions/push_views.dart';
import 'package:crypto_now/shared/resources/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(userRepositoryProvider);
  return LoginUseCase(repository);
});

class LoginViewModel extends StateNotifier<User> {
  final LoginUseCase _loginUseCase;
  final Ref ref;

  LoginViewModel(this.ref, this._loginUseCase) : super(User());

  void setEmail(String email) {
    state.email = email;
  }

  void setPassword(String password) {
    state.password = password;
  }

  void login(BuildContext context) async {
    ref.read(loadingButtonProvider.notifier).loading();
    final result = await _loginUseCase.call(state.email!, state.password!);
    switch (result) {
      case Success(value: final userCreated):
        print('User created successfully - ${userCreated.toJson()}');
        ref.read(loadingButtonProvider.notifier).loading();
        pushUntilView(context, Routes.home);
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
