import 'dart:async';

import 'package:crypto_now/presenter/view/app/cryto_now.dart';
import 'package:crypto_now/shared/utils/config_reader.dart';
import 'package:flutter/material.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize(env);

  runApp(const CryptoNow());
}
