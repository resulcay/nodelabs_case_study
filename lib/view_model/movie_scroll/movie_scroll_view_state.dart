import 'package:nodelabs_case_study/product/network/model/movie_list_response_model.dart';

final class MovieScrollViewState {
  const MovieScrollViewState({
    this.movies = const [],
    this.currentPage = 1,
    this.isLoading = false,
    this.hasMore = true,
  });
  final List<Movies> movies;
  final int currentPage;
  final bool isLoading;
  final bool hasMore;

  MovieScrollViewState copyWith({
    List<Movies>? movies,
    int? currentPage,
    bool? isLoading,
    bool? hasMore,
  }) {
    return MovieScrollViewState(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
