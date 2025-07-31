import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';

class NavbarItem extends StatelessWidget {
  const NavbarItem({
    required this.icon,
    required this.labelText,
    super.key,
  });

  final IconData icon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ThemeViewModel, ThemeState>(
              builder: (context, state) {
                return FaIcon(
                  icon,
                  color: state.isDark ? Colors.white : Colors.black,
                );
              },
            ),
            const SizedBox(width: 8),
            Text(
              labelText,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
