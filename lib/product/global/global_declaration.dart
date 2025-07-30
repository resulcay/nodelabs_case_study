import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nodelabs_case_study/product/navigation/route_manager.dart';
import 'package:nodelabs_case_study/view_model/user_credentials/user_credential_view_model.dart';

part 'custom_snack_bar.dart';

bool isCrashlyticsEnabled = kReleaseMode;

final userCredentialViewModel = UserCredentialViewModel();
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final routeManager = RouteManager();

enum NavigationVariant { builtIn, googleMaps, yandexMaps, appleMaps, wazeMaps }

final EasyLogger logger = EasyLogger(
  name: 'CustomLogger',
  defaultLevel: LevelMessages.debug,
  enableBuildModes: [BuildMode.debug, BuildMode.profile],
  enableLevels: [
    LevelMessages.debug,
    LevelMessages.info,
    LevelMessages.error,
    LevelMessages.warning,
  ],
);
