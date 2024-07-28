/// Fetched data from the API will be converted to Movie object. The Movie object has following attributes:
/// - String id,
/// - String title,
/// - String? posterPath
/// - String releaseDate
class Movie {
  final int id;
  final String title;
  final String? posterPath;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      title: json["title"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "poster_path": posterPath,
      "release_date": releaseDate,
    };
  }
}
