import 'package:movie_app/data/models/movie.dart';

class MovieDetails extends Movie {
  final String overview;
  final int budget;
  final int revenue;
  // final String languages;
  final List<String> languages;

  MovieDetails({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.releaseDate,
    required this.overview,
    required this.budget,
    required this.revenue,
    required this.languages,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      budget: json['budget'],
      revenue: json['revenue'],
      // languages: json['original_language']
      languages: List<String>.from(
        json['spoken_languages'].map((lang) => lang['name']),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'overview': overview,
      'budget': budget,
      'revenue': revenue,
      'spoken_language': languages,
      // 'original_language': languages.map((lang) => {'name': lang}).toList(),
    });
    return json;
  }
}
