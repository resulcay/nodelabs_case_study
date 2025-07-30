import 'package:flutter/material.dart';
import 'package:nodelabs_case_study/product/constant/color.dart';

class CustomRegisterTextField extends StatelessWidget {
  const CustomRegisterTextField({
    required this.controller,
    required this.label,
    required this.iconData,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.helperText,
    this.helperMaxLines,
    this.isEnabled,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final IconData iconData;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? helperText;
  final int? helperMaxLines;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: isEnabled ?? true,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        helperMaxLines: helperMaxLines,
        floatingLabelStyle: const TextStyle(color: ColorConstants.primaryColor),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.primaryColor),
        ),
        prefixIcon: Icon(iconData),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
