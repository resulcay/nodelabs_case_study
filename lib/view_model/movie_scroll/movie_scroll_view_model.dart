import 'package:nodelabs_case_study/product/base/base_cubit.dart';
import 'package:nodelabs_case_study/product/global/global_declaration.dart';
import 'package:nodelabs_case_study/product/network/base_config/dio_manager.dart';
import 'package:nodelabs_case_study/product/network/manager/movie_manager.dart';
import 'package:nodelabs_case_study/product/network/model/movie_list_response_model.dart';
import 'package:nodelabs_case_study/view_model/movie_scroll/movie_scroll_view_state.dart';

class MovieScrollViewModel extends BaseCubit<MovieScrollViewState> {
  MovieScrollViewModel() : super(const MovieScrollViewState());
  MovieManager movieManager = MovieManager(
    movieRepository: MovieRepository(DioManager().client),
  );

  Future<void> fetchMovies({bool loadMore = false}) async {
    if (state.isLoading || (!state.hasMore && loadMore)) return;

    emit(state.copyWith(isLoading: true));
    try {
      final nextPage = loadMore ? state.currentPage + 1 : 1;
      final response = await movieManager.getMovies(page: nextPage);

      if (response != null && response.isSuccess) {
        final newMovies = response.data?.movies ?? [];
        final pagination = response.data?.pagination;

        emit(
          state.copyWith(
            movies: loadMore ? [...state.movies, ...newMovies] : newMovies,
            currentPage: nextPage,
            hasMore: pagination?.currentPage != pagination?.maxPage,
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

  Future<void> refreshMovies() async {
    emit(state.copyWith(movies: [], hasMore: true));
    await fetchMovies();
  }

  Future<void> changeFavoriteStatus({required String movieId}) async {
    try {
      final response = await movieManager.toggleFavoriteMovie(movieId: movieId);

      if (response.isSuccess) {
        final updatedMovies = List<Movies>.from(state.movies);
        final index = updatedMovies.indexWhere((movie) => movie.id == movieId);
        if (index != -1) {
          final movie = updatedMovies[index];
          updatedMovies[index] = movie.copyWith(isFavorite: !movie.isFavorite!);
          emit(state.copyWith(movies: updatedMovies));
        }
      }
    } on Exception catch (_) {
      showCustomSnackBar(
        'Failed to change favorite status',
        type: SnackbarType.error,
      );
    }
  }
}
