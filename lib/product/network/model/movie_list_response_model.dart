class MovieListResponseModel {
  MovieListResponseModel({
    this.movies,
    this.pagination,
  });
  factory MovieListResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieListResponseModel(
      movies: (json['movies'] as List<dynamic>?)
          ?.map((e) => Movies.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
  List<Movies>? movies;
  Pagination? pagination;

  MovieListResponseModel copyWith({
    List<Movies>? movies,
    Pagination? pagination,
  }) {
    return MovieListResponseModel(
      movies: movies ?? this.movies,
      pagination: pagination ?? this.pagination,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movies': movies,
      'pagination': pagination,
    };
  }
}

class Movies {
  Movies({
    this.id,
    this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.poster,
    this.metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbID,
    this.type,
    this.response,
    this.images,
    this.comingSoon,
    this.isFavorite,
  });
  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      id: json['_id'] as String?,
      title: json['Title'] as String?,
      year: json['Year'] as String?,
      rated: json['Rated'] as String?,
      released: json['Released'] as String?,
      runtime: json['Runtime'] as String?,
      genre: json['Genre'] as String?,
      director: json['Director'] as String?,
      writer: json['Writer'] as String?,
      actors: json['Actors'] as String?,
      plot: json['Plot'] as String?,
      language: json['Language'] as String?,
      country: json['Country'] as String?,
      awards: json['Awards'] as String?,
      poster: json['Poster'] as String?,
      metascore: json['Metascore'] as String?,
      imdbRating: json['imdbRating'] as String?,
      imdbVotes: json['imdbVotes'] as String?,
      imdbID: json['imdbID'] as String?,
      type: json['Type'] as String?,
      response: json['Response'] as String?,
      images:
          (json['Images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      comingSoon: json['ComingSoon'] as bool?,
      isFavorite: json['isFavorite'] as bool?,
    );
  }
  String? id;
  String? title;
  String? year;
  String? rated;
  String? released;
  String? runtime;
  String? genre;
  String? director;
  String? writer;
  String? actors;
  String? plot;
  String? language;
  String? country;
  String? awards;
  String? poster;
  String? metascore;
  String? imdbRating;
  String? imdbVotes;
  String? imdbID;
  String? type;
  String? response;
  List<String>? images;
  bool? comingSoon;
  bool? isFavorite;

  Movies copyWith({
    String? id,
    String? title,
    String? year,
    String? rated,
    String? released,
    String? runtime,
    String? genre,
    String? director,
    String? writer,
    String? actors,
    String? plot,
    String? language,
    String? country,
    String? awards,
    String? poster,
    String? metascore,
    String? imdbRating,
    String? imdbVotes,
    String? imdbID,
    String? type,
    String? response,
    List<String>? images,
    bool? comingSoon,
    bool? isFavorite,
  }) {
    return Movies(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      rated: rated ?? this.rated,
      released: released ?? this.released,
      runtime: runtime ?? this.runtime,
      genre: genre ?? this.genre,
      director: director ?? this.director,
      writer: writer ?? this.writer,
      actors: actors ?? this.actors,
      plot: plot ?? this.plot,
      language: language ?? this.language,
      country: country ?? this.country,
      awards: awards ?? this.awards,
      poster: poster ?? this.poster,
      metascore: metascore ?? this.metascore,
      imdbRating: imdbRating ?? this.imdbRating,
      imdbVotes: imdbVotes ?? this.imdbVotes,
      imdbID: imdbID ?? this.imdbID,
      type: type ?? this.type,
      response: response ?? this.response,
      images: images ?? this.images,
      comingSoon: comingSoon ?? this.comingSoon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Title': title,
      'Year': year,
      'Rated': rated,
      'Released': released,
      'Runtime': runtime,
      'Genre': genre,
      'Director': director,
      'Writer': writer,
      'Actors': actors,
      'Plot': plot,
      'Language': language,
      'Country': country,
      'Awards': awards,
      'Poster': poster,
      'Metascore': metascore,
      'imdbRating': imdbRating,
      'imdbVotes': imdbVotes,
      'imdbID': imdbID,
      'Type': type,
      'Response': response,
      'Images': images,
      'ComingSoon': comingSoon,
      'isFavorite': isFavorite,
    };
  }
}

class Pagination {
  Pagination({
    this.totalCount,
    this.perPage,
    this.maxPage,
    this.currentPage,
  });
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalCount: json['totalCount'] as int?,
      perPage: json['perPage'] as int?,
      maxPage: json['maxPage'] as int?,
      currentPage: json['currentPage'] as int?,
    );
  }
  int? totalCount;
  int? perPage;
  int? maxPage;
  int? currentPage;

  Pagination copyWith({
    int? totalCount,
    int? perPage,
    int? maxPage,
    int? currentPage,
  }) {
    return Pagination(
      totalCount: totalCount ?? this.totalCount,
      perPage: perPage ?? this.perPage,
      maxPage: maxPage ?? this.maxPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'perPage': perPage,
      'maxPage': maxPage,
      'currentPage': currentPage,
    };
  }
}
