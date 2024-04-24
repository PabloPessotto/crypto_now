import 'package:crypto_now/presenter/viewmodel/create_account_viewmodel.dart';
import 'package:crypto_now/shared/components/base/base_view.dart';
import 'package:crypto_now/shared/functions/screen_size.dart';
import 'package:crypto_now/shared/resources/assets/assets.dart';
import 'package:crypto_now/shared/resources/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createAccountProvider = Provider<CreateAccountViewModel>((ref) {
  final usecase = ref.read(registerUserProvider);
  return CreateAccountViewModel(usecase, ref);
});

class CreateAccountView extends ConsumerWidget {
  CreateAccountView({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(createAccountProvider);
    final obscure = ref.watch(obscurePasswordProvider);
    final isLoading = ref.watch(loadingButtonProvider);

    final (height, widht) = screenSize(context);
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
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    top: MediaQuery.paddingOf(context).top,
                    left: MediaQuery.paddingOf(context).left),
                child: BackButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: AppColor.yellowLogo.withOpacity(0.4),
                  ),
                ),
              ),
              Expanded(
                child: BaseView(
                  safeAreaTop: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            Assets.logo,
                            height: height / 12,
                          ),
                          Text(
                            "Create Account",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayLarge,
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
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextFormField(
                                cursorHeight: 25,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: AppColor.yellowLogo,
                                decoration: const InputDecoration(
                                  hintText: "Enter your email",
                                ),
                                validator: (value) {
                                  if ((value?.isEmpty ?? true) ||
                                      !value!.contains('@')) {
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
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                      obscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value?.isEmpty ?? false) {
                                    return '';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: viewModel.setPassword,
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Confirm Your Password",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextFormField(
                                cursorHeight: 25,
                                cursorColor: AppColor.yellowLogo,
                                obscureText: obscure,
                                decoration: InputDecoration(
                                  hintText: "Enter your password again",
                                  suffixIcon: IconButton(
                                    onPressed: ref
                                        .read(obscurePasswordProvider.notifier)
                                        .showPassword,
                                    icon: Icon(
                                      obscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                validator: viewModel.validatePassword,
                                onChanged: viewModel.setConfirmPassword,
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
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.paddingOf(context).bottom),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.yellowLogo,
                            foregroundColor: Colors.white,
                            fixedSize: const Size(300, 47),
                            textStyle:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              viewModel.createAccount(context);
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: AppColor.dark,
                                  backgroundColor: Colors.black,
                                )
                              : const Text("Create Account"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
