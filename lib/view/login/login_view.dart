import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nodelabs_case_study/product/common/custom_text_form_field.dart';
import 'package:nodelabs_case_study/product/common/externel_auth_button_row.dart';
import 'package:nodelabs_case_study/product/common/primary_button.dart';

import 'package:nodelabs_case_study/product/extension/size_extension.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';
import 'package:nodelabs_case_study/product/navigation/route_manager.dart';
import 'package:nodelabs_case_study/view/login/login_view_mixin.dart';

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: context.screenHeight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Merhabalar',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            textAlign: TextAlign.center,
                            '''Tempus varius a vitae interdum id tortor elementum tristique eleifend at.''',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 50),
                          CustomTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelText: 'E-Posta',
                            hintText:
                                LocaleKeys.pages_login_email_helper_text.tr(),
                            obscureText: false,
                            validator: validateEmail,
                            prefixIconPath: 'assets/images/message.png',
                          ),
                          const SizedBox(height: 15),
                          CustomTextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            labelText: 'Şifre',
                            hintText: LocaleKeys
                                .pages_login_password_helper_text
                                .tr(),
                            obscureText: obscurePassword,
                            validator: validatePassword,
                            prefixIconPath: 'assets/images/unlock.png',
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                LocaleKeys.pages_login_forgot_password.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          PrimaryButton(
                            onPressed: login,
                            isLoading: isLoading,
                            text: 'Login',
                            loadingText: 'Logging In...',
                          ),
                          const SizedBox(height: 30),
                          const ExternelAuthButtonRow(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bir hesabın yok mu? ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.router.push(const RegisterRoute()),
                                child: Text(
                                  'Kayıt Ol',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
