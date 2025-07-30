import 'package:flutter/material.dart';
import 'package:nodelabs_case_study/view/home/home_view.dart';

mixin HomeViewMixin on State<HomeView> implements TickerProvider {
  PageController controller = PageController();

  ValueNotifier<int> selectedPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: selectedPage.value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
