import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodelabs_case_study/view/movie_scroll_view/movie_scroll_view.dart';
import 'package:nodelabs_case_study/view_model/movie_scroll/movie_scroll_view_model.dart';

mixin MovieScrollViewMixin on State<MovieScrollView> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<MovieScrollViewModel>().fetchMovies();
  }

  void onPageChanged(int index) {
    currentIndex = index;
    final state = context.read<MovieScrollViewModel>().state;
    if (index >= state.movies.length - 3 && !state.isLoading && state.hasMore) {
      context.read<MovieScrollViewModel>().fetchMovies(loadMore: true);
    }
  }

  Future<void> onRefresh() async {
    if (currentIndex != 0) {
      await pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    if (mounted) {
      await context.read<MovieScrollViewModel>().refreshMovies();
    }
  }

  void changeFavoriteStatus({required String movieId}) {
    context.read<MovieScrollViewModel>().changeFavoriteStatus(movieId: movieId);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
