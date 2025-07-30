import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:nodelabs_case_study/view/add_profile_picture/add_profile_picture.dart';
import 'package:nodelabs_case_study/view/home/home_view_mixin.dart';
import 'package:nodelabs_case_study/view/home/widget/home_view_drawer.dart';

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
      child: ValueListenableBuilder(
        valueListenable: selectedPage,
        builder: (context, selectedIndex, _) {
          return Scaffold(
            drawer: HomeViewDrawer(mainContext: context),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                if (mounted) {
                  selectedPage.value = index;
                  controller.jumpToPage(index);
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '1',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '2',
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
                      AddProfilePictureView(),
                      Center(child: Text('2')),
                    ],
                    onPageChanged: (index) {
                      if (mounted) {
                        selectedPage.value = index;
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
