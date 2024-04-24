import 'package:crypto_now/data/datasource/local/local_database.dart';
import 'package:crypto_now/data/datasource/local/user_local_data_source.dart';
import 'package:crypto_now/data/repository/user_repository_impl.dart';
import 'package:crypto_now/domain/repository/user_repository.dart';
import 'package:crypto_now/shared/components/base/base_view.dart';
import 'package:crypto_now/shared/functions/push_views.dart';
import 'package:crypto_now/shared/functions/screen_size.dart';
import 'package:crypto_now/shared/resources/assets/assets.dart';
import 'package:crypto_now/shared/resources/routes/routes.dart';
import 'package:crypto_now/shared/resources/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userLocalProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSourceImpl(LocalDatabase.instance);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userLocal = ref.read(userLocalProvider);
  return UserRepositoryImpl(userLocal);
});

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = screenHeight(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: -120,
            bottom: -100,
            child: Image.asset(
              Assets.symbol,
              color: AppColor.yellowLogo.withOpacity(0.25),
            ),
          ),
          Positioned(
            left: -160,
            top: -150,
            child: Image.asset(
              Assets.symbol,
              color: AppColor.yellowLogo.withOpacity(0.25),
            ),
          ),
          BaseView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Text(
                      "Welcome to the",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Image.asset(
                      Assets.logo,
                      height: height / 8,
                    ),
                  ],
                ),
                Column(
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
                        pushView(context, Routes.register);
                      },
                      child: const Text("Create Account"),
                    ),
                    const SizedBox(height: 15),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColor.yellowLogo,
                        fixedSize: const Size(300, 47),
                        side: const BorderSide(color: AppColor.yellowLogo),
                        textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () {
                        pushReplacementView(context, Routes.login);
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
