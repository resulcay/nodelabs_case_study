import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/product/constant/color.dart';
import 'package:nodelabs_case_study/product/constant/text.dart';
import 'package:nodelabs_case_study/view/splash/splash_view_mixin.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Scaffold(
            body: Center(
              child: BlocBuilder<ThemeViewModel, ThemeState>(
                builder: (context, state) {
                  return AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        textAlign: TextAlign.center,
                        TextConstants.appTitle,
                        colors: [
                          ColorConstants.primaryColor,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 150),
                      ),
                    ],
                    repeatForever: true,
                    displayFullTextOnTap: true,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
