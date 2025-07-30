import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/product/constant/text.dart';
import 'package:nodelabs_case_study/product/global/global_declaration.dart';
import 'package:nodelabs_case_study/product/init/app_init.dart';
import 'package:nodelabs_case_study/product/language/language_manager.dart';
import 'package:nodelabs_case_study/product/network/base_config/dio_manager.dart';
import 'package:nodelabs_case_study/product/theme/dark_theme.dart';
import 'package:nodelabs_case_study/product/theme/light_theme.dart';
import 'package:nodelabs_case_study/view_model/home/home_view_model.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';
import 'package:nodelabs_case_study/view_model/user_credentials/user_credential_view_model.dart';

Future<void> main() async {
  await ApplicationInitialization().initConfig();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeViewModel()),
        BlocProvider(create: (_) => HomeViewModel()),
        BlocProvider(create: (_) => UserCredentialViewModel()),
      ],
      child: LanguageManager(child: const Root()),
    ),
  );
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    DioManager().setLanguage(context.locale.languageCode);
    final viewModel = context.read<UserCredentialViewModel>();
    DioManager().setUserCredentialViewModel(viewModel);

    return BlocBuilder<ThemeViewModel, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: TextConstants.appTitle,
          theme: LightTheme(isDarkMode: state.isDark).theme,
          darkTheme: DarkTheme(isDarkMode: state.isDark).theme,
          routerConfig: routeManager.config(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
