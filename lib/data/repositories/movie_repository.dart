import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/data/models/genre.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/data/models/movie_details.dart';
import 'package:movie_app/data/providers/movie_api_provider.dart';

class MovieRepository {
  final MovieApiProvider movieApiProvider;
  GetStorage storage = GetStorage();

  MovieRepository({required this.movieApiProvider});

  Future<List<Movie>> fetchTrendingMovies(int page) async {
    try {
      final movies = await movieApiProvider.fetchTrendingMovies(page);
      storage.write('movies', movies);
      return movies;
    } on SocketException {
      final localStorage = await storage.read('movies');
      return localStorage;
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

  Future<List<Movie>> fetchMovieByGenreResults(int id) async {
    try {
      final movies = await movieApiProvider.fetchMoviesBasedOnGenre(id);
      return movies;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Genre>> fetchGenre() async {
    try {
      final genres = await movieApiProvider.fetchGenres();
      return genres;
    } catch (e) {
      throw Exception(e);
    }
  }
}
