import 'package:crypto_now/presenter/viewmodel/login_viewmodel.dart';
import 'package:crypto_now/shared/components/base/base_view.dart';
import 'package:crypto_now/shared/functions/push_views.dart';
import 'package:crypto_now/shared/functions/screen_size.dart';
import 'package:crypto_now/shared/resources/assets/assets.dart';
import 'package:crypto_now/shared/resources/routes/routes.dart';
import 'package:crypto_now/shared/resources/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider = Provider<LoginViewModel>((ref) {
  final usecase = ref.read(loginProvider);
  return LoginViewModel(ref, usecase);
});

class LoginView extends ConsumerWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (height, widht) = screenSize(context);
    final viewModel = ref.watch(loginViewModelProvider);
    final obscure = ref.watch(obscurePasswordProvider);
    final isLoading = ref.watch(loadingButtonProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -160,
            top: -150,
            child: Image.asset(
              Assets.symbol,
              color: AppColor.yellowLogo.withOpacity(0.25),
            ),
          ),
          Positioned(
            right: -170,
            bottom: -180,
            child: Image.asset(
              Assets.symbol,
              color: AppColor.yellowLogo.withOpacity(0.2),
            ),
          ),
          BaseView(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      Assets.logo,
                      height: height / 8,
                    ),
                    Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: widht / 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Email",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextFormField(
                          cursorHeight: 25,
                          cursorColor: AppColor.yellowLogo,
                          decoration: const InputDecoration(
                            hintText: "Enter your email",
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return '';
                            } else {
                              return null;
                            }
                          },
                          onChanged: viewModel.setEmail,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Your Password",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextFormField(
                          cursorHeight: 25,
                          cursorColor: AppColor.yellowLogo,
                          obscureText: obscure,
                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            suffixIcon: IconButton(
                              onPressed: ref
                                  .read(obscurePasswordProvider.notifier)
                                  .showPassword,
                              icon: Icon(
                                obscure ? Icons.visibility_off : Icons.visibility,
                              ),
                            ),
                          ),
                          onChanged: viewModel.setPassword,
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return '';
                            } else {
                              return null;
                            }
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.yellowLogo,
                          foregroundColor: Colors.white,
                          fixedSize: const Size(300, 47),
                          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            viewModel.login(context);
                          }
                        },
                        child: const Text("Login"),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          pushView(context, Routes.register);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style:
                                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: AppColor.yellowLogo,
                                          fontWeight: FontWeight.w800,
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
