import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/data/models/movie_details.dart';
import 'package:movie_app/data/providers/movie_api_provider.dart';

class MovieRepository {
  final MovieApiProvider movieApiProvider;

  MovieRepository({required this.movieApiProvider});

  Future<List<Movie>> fetchTrendingMovies(int page) async {
    try {
      final movies = await movieApiProvider.fetchTrendingMovies(page);
      return movies;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<MovieDetails> fetchMovieDetails(int id) async {
    return await movieApiProvider.fetchMovieDetails(id);
  }
}
