import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';

class ExternalAuthButton extends StatelessWidget {
  const ExternalAuthButton({
    required this.logoPath,
    super.key,
  });

  final String logoPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: .5),
                ),
              ),
              child: BlocBuilder<ThemeViewModel, ThemeState>(
                builder: (context, state) {
                  return Image.asset(
                    logoPath,
                    color: state.isDark ? Colors.white : Colors.black,
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
