import 'package:flutter/material.dart';
import 'package:nodelabs_case_study/product/constant/color.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.text,
    required this.loadingText,
    required this.isLoading,
    super.key,
  });
  final Future<void> Function() onPressed;
  final String text;
  final String loadingText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: ColorConstants.primaryColor,
        ),
        onPressed: isLoading ? null : onPressed,
        child: Text(
          isLoading ? loadingText : text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
