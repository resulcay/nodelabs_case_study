import 'package:nodelabs_case_study/product/base/base_cubit.dart';
import 'package:nodelabs_case_study/product/network/base_config/dio_manager.dart';
import 'package:nodelabs_case_study/product/network/manager/movie_manager.dart';
import 'package:nodelabs_case_study/product/network/model/movie_list_response_model.dart';

class FavoriteMoviesViewModel extends BaseCubit<FavoriteMoviesViewState> {
  FavoriteMoviesViewModel() : super(const FavoriteMoviesViewState());
  MovieManager movieManager = MovieManager(
    movieRepository: MovieRepository(DioManager().client),
  );

  Future<void> fetchFavoriteMovies() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    try {
      final response = await movieManager.getFavoriteMovies();

      if (response != null && response.isSuccess) {
        final movies = response.data?.movies ?? [];

        emit(
          state.copyWith(
            movies: movies,
            isLoading: false,
          ),
        );
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } on Exception catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }
}

final class FavoriteMoviesViewState {
  const FavoriteMoviesViewState({
    this.movies = const [],
    this.isLoading = false,
  });
  final List<Movies> movies;
  final bool isLoading;
  FavoriteMoviesViewState copyWith({
    List<Movies>? movies,
    bool? isLoading,
  }) {
    return FavoriteMoviesViewState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
