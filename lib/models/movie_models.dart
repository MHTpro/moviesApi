class MovieModel {
  String? title;
  String? poster;
  String? year;
  List<Object?>? images;
  String? country;
  String? imdbrating;

  MovieModel({
    this.country,
    this.images,
    this.poster,
    this.title,
    this.year,
    this.imdbrating,
  });

  factory MovieModel.fromJson(Map<String?, dynamic> json) {
    return MovieModel(
      title: json['title'],
      year: json['year'],
      country: json['country'],
      poster: json['poster'],
      images: json['images'],
      imdbrating: json['imdb_rating'],
    );
  }
}

class DataModel {
  List<MovieModel?>? data;

  DataModel({this.data});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      data: List<MovieModel>.from(
        json["data"].map(
          (value) => MovieModel.fromJson(value),
        ),
      ),
    );
  }
}
