class MovieModel {
  String? createdBy;
  String? description;
  int? favoriteCount;
  int? id;
  String? iso6391;
  int? itemCount;
  List<Items>? items;
  String? name;
  int? page;
  Null? posterPath;
  int? totalPages;
  int? totalResults;

  MovieModel({
    this.createdBy,
    this.description,
    this.favoriteCount,
    this.id,
    this.iso6391,
    this.itemCount,
    this.items,
    this.name,
    this.page,
    this.posterPath,
    this.totalPages,
    this.totalResults,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    description = json['description'];
    favoriteCount = json['favorite_count'];
    id = json['id'];
    iso6391 = json['iso_639_1'];
    itemCount = json['item_count'];

    // Check if 'items' is not null before casting
    if (json['items'] != null) {
      items = List<Items>.from(json['items'].map((x) => Items.fromJson(x)));
    }

    name = json['name'];
    page = json['page'];
    posterPath = json['poster_path'];
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_by'] = createdBy;
    data['description'] = description;
    data['favorite_count'] = favoriteCount;
    data['id'] = id;
    data['iso_639_1'] = iso6391;
    data['item_count'] = itemCount;
    data['items'] = items?.map((x) => x.toJson()).toList();
    data['name'] = name;
    data['page'] = page;
    data['poster_path'] = posterPath;
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Items {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  List<int>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? name;
  String? originalName;
  String? firstAirDate;
  List<String>? originCountry;

  Items({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  Items.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];

    // Check if 'genre_ids' is not null before casting
    if (json['genre_ids'] != null) {
      genreIds = List<int>.from(json['genre_ids'].map((x) => x as int));
    }

    popularity = json['popularity'];
    releaseDate = json['release_date'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    name = json['name'];
    originalName = json['original_name'];
    firstAirDate = json['first_air_date'];

    // Check if 'origin_country' is not null before casting
    if (json['origin_country'] != null) {
      originCountry =
          List<String>.from(json['origin_country'].map((x) => x as String));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['title'] = title;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['genre_ids'] = genreIds;
    data['popularity'] = popularity;
    data['release_date'] = releaseDate;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['name'] = name;
    data['original_name'] = originalName;
    data['first_air_date'] = firstAirDate;
    data['origin_country'] = originCountry;
    return data;
  }
}
