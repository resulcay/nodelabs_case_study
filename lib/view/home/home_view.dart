import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:nodelabs_case_study/view/home/home_view_mixin.dart';
import 'package:nodelabs_case_study/view/home/widget/home_view_drawer.dart';
import 'package:nodelabs_case_study/view/home/widget/navbar_item.dart';
import 'package:nodelabs_case_study/view/movie_scroll_view/movie_scroll_view.dart';
import 'package:nodelabs_case_study/view/profile_details/profile_details_view.dart';
import 'package:nodelabs_case_study/view_model/home/home_view_model.dart';
import 'package:nodelabs_case_study/view_model/home/home_view_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_state.dart';
import 'package:nodelabs_case_study/view_model/theme/theme_view_model.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin, HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocBuilder<HomeViewModel, HomeViewState>(
        builder: (
          context,
          state,
        ) {
          return BlocBuilder<ThemeViewModel, ThemeState>(
            builder: (context, themeState) {
              return Scaffold(
                drawer: HomeViewDrawer(mainContext: context),
                bottomNavigationBar: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: state.currentPage,
                  onTap: (index) {
                    if (mounted) {
                      context.read<HomeViewModel>().changeCurrentPage(index);
                      controller.jumpToPage(index);
                    }
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: NavbarItem(
                        icon: FontAwesomeIcons.house,
                        labelText: 'Ana Sayfa',
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: NavbarItem(
                        icon: FontAwesomeIcons.solidUser,
                        labelText: 'Profil',
                      ),
                      label: '',
                    ),
                  ],
                ),
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: PageView(
                        controller: controller,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const <Widget>[
                          MovieScrollView(),
                          ProfileDetailsView(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
