import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nodelabs_case_study/view/movie_scroll_view/components/movie_scroll_view.dart';
import 'package:nodelabs_case_study/view/movie_scroll_view/movie_scroll_view_mixin.dart';
import 'package:nodelabs_case_study/view_model/movie_scroll/movie_scroll_view_model.dart';
import 'package:nodelabs_case_study/view_model/movie_scroll/movie_scroll_view_state.dart';

@RoutePage()
class MovieScrollView extends StatefulWidget {
  const MovieScrollView({super.key});

  @override
  State<MovieScrollView> createState() => _MovieScrollViewState();
}

class _MovieScrollViewState extends State<MovieScrollView>
    with MovieScrollViewMixin {
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieScrollViewModel, MovieScrollViewState>(
        builder: (context, state) {
          if (state.movies.isEmpty && state.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return Stack(
            children: [
              RefreshIndicator(
                color: Colors.white,
                backgroundColor: Colors.black54,
                onRefresh: onRefresh,
                child: PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: state.hasMore
                      ? state.movies.length + 1
                      : state.movies.length,
                  onPageChanged: onPageChanged,
                  itemBuilder: (context, index) {
                    if (index >= state.movies.length) {
                      return const ColoredBox(
                        color: Colors.black,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }

                    final movie = state.movies[index];
                    return MovieCard(
                      movie: movie,
                      index: index,
                      onFavoritePressed: () =>
                          changeFavoriteStatus(movieId: movie.id!),
                    );
                  },
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.barsStaggered,
                        color: Colors.white,
                      ),
                      onPressed: () => Scaffold.of(parentContext).openDrawer(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
