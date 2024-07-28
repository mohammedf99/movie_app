import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/data/models/genre.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/data/models/movie_details.dart';
import 'package:movie_app/data/providers/movie_api_provider.dart';

/// The MovieRepository works as an intermediate between the MovieBloc and MovieApiService.
class MovieRepository {
  final MovieApiProvider movieApiProvider;
  GetStorage storage = GetStorage();

  MovieRepository({required this.movieApiProvider});

  /// Fetches trending movies based on the given [page].
  /// 
  /// If there is no internet connection, then it returns List of movies stored in GetStorage. 
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
  /// Returns movie detail based on [id] provided by the movie object.
  /// 
  /// *Note: no detial is available when there is no internet connection.
  Future<MovieDetails> fetchMovieDetails(int id) async {
    try {
      return await movieApiProvider.fetchMovieDetails(id);
    } on SocketException {
      throw ("No details availabe. Please connect to internet!");
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Fetches search results based on a given [query].
  /// 
  /// *Note: no search is availabe when there is no connection.
  Future<List<Movie>> fetchSearchResults(String query) async {
    try {
      final movies = await movieApiProvider.searchMovie(query);
      return movies;
    } on SocketException {
      throw Exception("You can not search. Please connect to internet.");
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Returns a list of movies based on given genre [id].
  Future<List<Movie>> fetchMovieByGenreResults(int id) async {
    try {
      final movies = await movieApiProvider.fetchMoviesBasedOnGenre(id);
      return movies;
    } on SocketException {
      throw Exception("You can not fetch by genre. Please connect to internet.");
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Returns a list of available genre.
  Future<List<Genre>> fetchGenre() async {
    try {
      final genres = await movieApiProvider.fetchGenres();
      return genres;
    } on SocketException {
      throw Exception("Please connect to internet first!");
    } catch (e) {
      throw Exception(e);
    }
  }
}
