import 'package:dio/dio.dart';
import 'package:nodelabs_case_study/product/constant/text.dart';
import 'package:nodelabs_case_study/product/network/base_config/api_call_mixin.dart';
import 'package:nodelabs_case_study/product/network/base_config/base_repository.dart';
import 'package:nodelabs_case_study/product/network/model/base_response_model.dart';
import 'package:nodelabs_case_study/product/network/model/favorite_movies_response_model.dart';
import 'package:nodelabs_case_study/product/network/model/movie_list_response_model.dart';

class MovieManager {
  MovieManager({required MovieRepository movieRepository})
      : _movieRepository = movieRepository;
  final MovieRepository _movieRepository;

  Future<BaseResponse<MovieListResponseModel>?> getMovies({int page = 1}) {
    return _movieRepository.getMovies(page: page);
  }

  Future<BaseResponse<FavoriteMoviesResponseModel>?> getFavoriteMovies() {
    return _movieRepository.getFavoriteMovies();
  }

  Future<BaseResponse<void>> toggleFavoriteMovie({required String movieId}) {
    return _movieRepository.toggleFavoriteMovie(movieId: movieId);
  }
}

class MovieRepository extends BaseRepository
    with ApiCallMixin
    implements IMovieRepository {
  MovieRepository(this.dioClient);

  @override
  final Dio dioClient;

  @override
  Future<BaseResponse<MovieListResponseModel>?> getMovies({
    required int page,
  }) async {
    final query = {'page': page};

    return wrapExecuteApiCall(
      () async => dioClient.get(
        TextConstants.getMovies,
        queryParameters: query,
      ),
      (data) => BaseResponse<MovieListResponseModel>.fromJson(
        data as Map<String, dynamic>,
        MovieListResponseModel.fromJson,
      ),
    );
  }

  @override
  Future<BaseResponse<FavoriteMoviesResponseModel>?> getFavoriteMovies() async {
    return wrapExecuteApiCall(
      () => dioClient.get(TextConstants.getFavoriteMovies),
      (data) => BaseResponse<FavoriteMoviesResponseModel>.fromJsonWithArrayData(
        data as Map<String, dynamic>,
        FavoriteMoviesResponseModel.fromJson,
      ),
    );
  }

  @override
  Future<BaseResponse<void>> toggleFavoriteMovie({
    required String movieId,
  }) async {
    return wrapExecuteApiCall(
      () => dioClient.post(
        '${TextConstants.toggleFavoriteMovie}/$movieId',
      ),
      (data) => BaseResponse.fromJson(
        data as Map<String, dynamic>,
        (json) => json,
      ),
    );
  }
}

abstract class IMovieRepository {
  Future<BaseResponse<MovieListResponseModel>?> getMovies({required int page});
  Future<BaseResponse<FavoriteMoviesResponseModel>?> getFavoriteMovies();
  Future<BaseResponse<void>> toggleFavoriteMovie({required String movieId});
}
