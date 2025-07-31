import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nodelabs_case_study/view/splash/splash_view_mixin.dart';

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
              child: Lottie.asset(
                'assets/lottie/loading.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
