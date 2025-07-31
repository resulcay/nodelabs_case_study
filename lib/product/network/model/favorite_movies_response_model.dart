import 'package:nodelabs_case_study/product/network/model/movie_list_response_model.dart';

class FavoriteMoviesResponseModel {
  FavoriteMoviesResponseModel({this.movies});

  factory FavoriteMoviesResponseModel.fromJson(List<dynamic> json) {
    return FavoriteMoviesResponseModel(
      movies:
          json.map((e) => Movies.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  final List<Movies>? movies;

  FavoriteMoviesResponseModel copyWith({
    List<Movies>? movies,
  }) {
    return FavoriteMoviesResponseModel(
      movies: movies ?? this.movies,
    );
  }

  List<Map<String, dynamic>> toJson() {
    return movies?.map((movie) => movie.toJson()).toList() ?? [];
  }
}
