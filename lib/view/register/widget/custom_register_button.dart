import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nodelabs_case_study/product/constant/color.dart';
import 'package:nodelabs_case_study/product/language/locale_keys.g.dart';

class CustomRegisterButton extends StatelessWidget {
  const CustomRegisterButton({
    required this.theme,
    required this.onPressed,
    super.key,
  });

  final ThemeData theme;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Center(
          child: Text(
            LocaleKeys.pages_register_register_button,
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ).tr(),
        ),
      ),
    );
  }
}
