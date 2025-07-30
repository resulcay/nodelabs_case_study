import 'package:flutter/material.dart';
import 'package:nodelabs_case_study/view/login/components/external_auth_button.dart';

class ExternelAuthButtonRow extends StatelessWidget {
  const ExternelAuthButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomLogoList = [
      'assets/images/google-logo.png',
      'assets/images/apple-logo.png',
      'assets/images/facebook-logo.png',
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return ExternalAuthButton(
          logoPath: bottomLogoList[index],
        );
      }),
    );
  }
}
