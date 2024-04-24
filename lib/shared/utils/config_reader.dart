import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic>? _config;
  static bool _isDevMode = false;
  static Future<void> initialize(String env) async {
    var configString = '{}';
    try {
      configString = await rootBundle.loadString('config/$env.json');
    } catch (_) {
      configString = await rootBundle.loadString('config/dev.json');
    }
    _config = json.decode(configString) as Map<String, dynamic>;
    _isDevMode = env == "dev";
  }

  static bool isDevMode() {
    return _isDevMode;
  }

  static String getWSBaseUrl() {
    return _config!['ws'] as String;
  }

  static String getBaseUrl() {
    return _config!['baseUrl'] as String;
  }

  static String getApiKey() {
    return _config!['apiKey'] as String;
  }

  static String getApiSecret() {
    return _config!['apiSecret'] as String;
  }
}
