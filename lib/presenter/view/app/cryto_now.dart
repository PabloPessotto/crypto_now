import 'package:crypto_now/data/network/dio_factory.dart';
import 'package:crypto_now/data/network/service_client/ticker_service_client.dart';
import 'package:crypto_now/shared/resources/routes/routes.dart';
import 'package:crypto_now/shared/resources/theme/app_color.dart';
import 'package:crypto_now/shared/resources/theme/app_font_style.dart';
import 'package:crypto_now/shared/utils/config_reader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioFactoryProvider = Provider<DioFactory>((ref) {
  return DioFactory();
});

final dioProvider = FutureProvider<Dio>((ref) async {
  final dio = await ref.watch(dioFactoryProvider).getDio();
  return dio;
});

final tickerServiceClientProvider = Provider<TickerServiceClient>((ref) {
  final dio = ref.watch(dioProvider);
  return TickerServiceClient(
    dio.asData?.value ??
        Dio(
          BaseOptions(
            baseUrl: ConfigReader.getBaseUrl(),
          ),
        ),
  );
});

class CryptoNow extends StatelessWidget {
  const CryptoNow({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        initialRoute: Routes.initial,
        onGenerateRoute: GenerateRoutes.getRoute,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          textTheme: const TextTheme(
            displayLarge: AppFontStyle.displayLarge,
            displayMedium: AppFontStyle.displayMedium,
            displaySmall: AppFontStyle.displaySmall,
            headlineLarge: AppFontStyle.headlineLarge,
            headlineMedium: AppFontStyle.headlineMedium,
            headlineSmall: AppFontStyle.headlineSmall,
            titleLarge: AppFontStyle.titleLarge,
            titleMedium: AppFontStyle.titleMedium,
            titleSmall: AppFontStyle.titleSmall,
            bodyLarge: AppFontStyle.bodyLarge,
            bodyMedium: AppFontStyle.bodyMedium,
            bodySmall: AppFontStyle.bodySmall,
            labelLarge: AppFontStyle.labelLarge,
            labelMedium: AppFontStyle.labelMedium,
            labelSmall: AppFontStyle.labelSmall,
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColor.yellowLogo,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red[900]!),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red[900]!),
            ),
            errorStyle: const TextStyle(height: 0),
          ),
        ),
        theme: ThemeData(fontFamily: 'TT Bluescreens'),
      ),
    );
  }
}
