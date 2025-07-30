import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/product/common/custom_text_form_field.dart';
import 'package:nodelabs_case_study/product/common/externel_auth_button_row.dart';
import 'package:nodelabs_case_study/product/common/primary_button.dart';
import 'package:nodelabs_case_study/product/constant/text.dart';
import 'package:nodelabs_case_study/product/extension/size_extension.dart';
import 'package:nodelabs_case_study/product/navigation/route_manager.dart';
import 'package:nodelabs_case_study/view/register/register_view_mixin.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterViewMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.screenHeight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      labelText: 'Ad Soyad',
                      hintText: 'Ad Soyad',
                      obscureText: false,
                      validator: validateName,
                      prefixIconPath: 'assets/images/add-user.png',
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'E-posta',
                      hintText: 'E-posta',
                      obscureText: false,
                      validator: validateEmail,
                      prefixIconPath: 'assets/images/message.png',
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: 'Şifre',
                      hintText: 'Şifre',
                      obscureText: obscurePassword,
                      prefixIconPath: 'assets/images/unlock.png',
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: 'Şifre Tekrar',
                      hintText: 'Şifre Tekrar',
                      obscureText: obscureConfirmPassword,
                      prefixIconPath: 'assets/images/unlock.png',
                      validator: doPasswordsMatch,
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: BlocBuilder<ThemeViewModel, ThemeState>(
                        builder: (context, state) {
                          return RichText(
                            maxLines: 3,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Kullanıcı sözleşmesini ',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(
                                        Uri.parse(TextConstants.termsUrl),
                                      );
                                    },
                                  text: 'okudum ve kabul ediyorum. ',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: state.isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '''Bu sözelşmeyi okuyarak devam ediniz lütfen.''',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: PrimaryButton(
                        onPressed: register,
                        text: 'Kayıt Ol',
                        loadingText: 'Kayıt Olunuyor...',
                        isLoading: isLoading,
                      ),
                    ),
                    const ExternelAuthButtonRow(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Zaten bir hesabın var mı?',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.router.push(const LoginRoute()),
                          child: Text(
                            'Giriş Yap!',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
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
    );
  }
}
