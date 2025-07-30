import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:nodelabs_case_study/product/global/global_declaration.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';
import 'package:nodelabs_case_study/product/navigation/route_manager.dart';
import 'package:nodelabs_case_study/product/network/base_config/api_call_mixin.dart';
import 'package:nodelabs_case_study/product/network/base_config/dio_manager.dart';
import 'package:nodelabs_case_study/product/network/manager/auth_manager.dart';
import 'package:nodelabs_case_study/view/login/login_view.dart';

mixin LoginViewMixin on State<LoginView> {
  final formKey = GlobalKey<FormState>();
  AuthManager authManager = AuthManager(
    authRepository: AuthRepository(DioManager().client),
  );
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.pages_login_email_validation_empty.tr();
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return LocaleKeys.pages_login_email_validation_invalid.tr();
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.pages_login_password_validation_empty.tr();
    } else if (value.length < 8) {
      return LocaleKeys.pages_login_password_validation_short.tr();
    }
    return null;
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      final email = emailController.text.trim();
      final password = passwordController.text;

      try {
        final response = await authManager.loginUser(
          email: email,
          password: password,
        );

        if (response != null && response.data?.token != null) {
          await userCredentialViewModel.saveCredentials(
            accessToken: response.data!.token!,
            id: response.data!.id,
            name: response.data!.name,
            email: response.data!.email,
            photoUrl: response.data!.photoUrl,
          );

          showCustomSnackBar(
            LocaleKeys.pages_login_login_success.tr(),
            type: SnackbarType.success,
          );

          if (mounted) {
            setState(() {
              isLoading = false;
            });
            await context.router.replace(const SplashRoute());
          }
        } else {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          showCustomSnackBar(
            LocaleKeys.pages_login_login_failed.tr(),
            type: SnackbarType.error,
          );
        }
      } on ErrorResponseException catch (err) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        showCustomSnackBar(
          err.error.displayMessage.isNotEmpty
              ? err.error.displayMessage
              : LocaleKeys.pages_login_error_occurred.tr(),
          type: SnackbarType.error,
        );
      } on Exception catch (e) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        showCustomSnackBar(e.toString(), type: SnackbarType.error);
      }
    }
  }
}
