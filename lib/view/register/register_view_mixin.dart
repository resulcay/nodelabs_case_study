import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:nodelabs_case_study/product/global/global_declaration.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';
import 'package:nodelabs_case_study/product/navigation/route_manager.dart';
import 'package:nodelabs_case_study/product/network/base_config/api_call_mixin.dart';
import 'package:nodelabs_case_study/product/network/base_config/dio_manager.dart';
import 'package:nodelabs_case_study/product/network/manager/auth_manager.dart';
import 'package:nodelabs_case_study/view/register/register_view.dart';

mixin RegisterViewMixin on State<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;
  final AuthManager authManager = AuthManager(
    authRepository: AuthRepository(DioManager().client),
  );

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.pages_register_validate_name.tr();
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.pages_register_validate_email_empty.tr();
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return LocaleKeys.pages_register_validate_email_invalid.tr();
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.pages_register_validate_password_empty.tr();
    }
    if (value.length < 8) {
      return LocaleKeys.pages_register_validate_password_short.tr();
    }
    return null;
  }

  String? doPasswordsMatch(String? value) {
    if (value != passwordController.text) {
      return LocaleKeys.pages_register_validate_password_not_match.tr();
    }
    return null;
  }

  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      final refineName = nameController.text.trim();
      final refinedEmail = emailController.text.trim();

      try {
        final response = await authManager.registerUser(
          name: refineName,
          email: refinedEmail,
          password: passwordController.text,
        );

        if (response != null && response.isSuccess) {
          final userData = response.data;
          if (userData != null && userData.token != null) {
            showCustomSnackBar(
              LocaleKeys.pages_register_register_success.tr(),
              type: SnackbarType.success,
            );

            await userCredentialViewModel.saveCredentials(
              accessToken: userData.token!,
              id: userData.id,
              name: userData.name,
              email: userData.email,
              photoUrl: userData.photoUrl,
            );

            if (mounted) {
              await context.router.replace(const SplashRoute());
            }
          } else {
            showCustomSnackBar(
              LocaleKeys.pages_register_error_occurred.tr(),
              type: SnackbarType.error,
            );
          }
        } else {
          final String errorMessage;

          if (response != null &&
              response.response.message.isNotEmpty == true) {
            errorMessage = response.response.message;
          } else {
            errorMessage = LocaleKeys.pages_register_register_failed.tr();
          }

          showCustomSnackBar(
            errorMessage,
            type: SnackbarType.error,
          );
        }
      } on ErrorResponseException catch (err) {
        showCustomSnackBar(
          err.error.detail ?? LocaleKeys.pages_register_error_occurred.tr(),
          type: SnackbarType.error,
        );
      } on Exception catch (e) {
        showCustomSnackBar(
          e.toString(),
          type: SnackbarType.error,
        );
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }
}
