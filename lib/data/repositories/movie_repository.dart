import 'package:movie_app/data/models/genre.dart';
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

  Future<List<Movie>> fetchSearchResults(String query) async {
    try {
      final movies = await movieApiProvider.searchMovie(query);
      return movies;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Genre>> fetchGenre() async {
    try {
      final genres = await movieApiProvider.fetchGenres();
      print(genres);
      return genres;
    } catch (e) {
      throw Exception(e);
    }
  }
}
