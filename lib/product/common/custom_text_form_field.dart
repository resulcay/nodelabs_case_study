import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/product/constant/color.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    required this.prefixIconPath,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String prefixIconPath;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscurePassword = false;

  void togglePasswordVisibility() {
    if (mounted) {
      setState(() {
        obscurePassword = !obscurePassword;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeViewModel, ThemeState>(
      builder: (context, state) {
        return TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText && !obscurePassword,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: .1),
            labelText: widget.labelText,
            hintText: widget.hintText,
            floatingLabelStyle: const TextStyle(
              color: ColorConstants.primaryColor,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                color: ColorConstants.primaryColor,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                widget.prefixIconPath,
                color: state.isDark ? Colors.white : Colors.black,
              ),
            ),
            suffixIcon: widget.obscureText
                ? GestureDetector(
                    onTap: togglePasswordVisibility,
                    child: Image.asset(
                      'assets/images/eye.png',
                      color: state.isDark ? Colors.white : Colors.black,
                    ),
                  )
                : null,
          ),
          validator: widget.validator,
        );
      },
    );
  }
}
