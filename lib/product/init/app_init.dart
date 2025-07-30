import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nodelabs_case_study/firebase_options.dart';
import 'package:nodelabs_case_study/product/global/global_declaration.dart';

@immutable
final class ApplicationInitialization {
  Future<void> initConfig() async {
    WidgetsFlutterBinding.ensureInitialized();

    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {
      logger.error(error);
      if (isCrashlyticsEnabled) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
    });
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(isCrashlyticsEnabled);

    logger.info('Crashlytics collection enabled: $isCrashlyticsEnabled');

    await EasyLocalization.ensureInitialized();

    EasyLocalization.logger.enableLevels = [
      LevelMessages.error,
      LevelMessages.warning,
      LevelMessages.info,
    ];

    FlutterError.onError = (FlutterErrorDetails details) {
      logger.error(details.exceptionAsString());
      if (isCrashlyticsEnabled) {
        FirebaseCrashlytics.instance.recordFlutterError(details);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      logger.error(error.toString());

      if (isCrashlyticsEnabled) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }

      return true;
    };

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}
