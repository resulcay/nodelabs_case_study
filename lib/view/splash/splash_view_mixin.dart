import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/product/navigation/route_manager.dart';
import 'package:nodelabs_case_study/view/splash/splash_view.dart';
import 'package:nodelabs_case_study/view_model/user_credentials/user_credential_view_model.dart';

mixin SplashViewMixin on State<SplashView> {
  @override
  void initState() {
    super.initState();
    _initCache();
    navigationManager(context);
  }

  Future<void> _initCache() async {
    await context.read<UserCredentialViewModel>().loadCredentials();
  }

  Future<bool> _isLoggedIn() async {
    final isLoggedIn =
        await context.read<UserCredentialViewModel>().isLoggedIn();

    return isLoggedIn;
  }

  Future<void> navigationManager(BuildContext context) async {
    final result = await _isLoggedIn();

    if (result) {
      if (context.mounted) {
        await context.router.replace(const HomeRoute());
      }
    } else {
      if (context.mounted) {
        await context.router.replace(const LoginRoute());
      }
    }
  }
}
