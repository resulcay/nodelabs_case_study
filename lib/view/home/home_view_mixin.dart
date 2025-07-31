import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/view/home/home_view.dart';
import 'package:nodelabs_case_study/view_model/home/home_view_model.dart';

mixin HomeViewMixin on State<HomeView> implements TickerProvider {
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: context.read<HomeViewModel>().state.currentPage,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
