import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/data/models/genre.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/models/movie_details.dart';

/// MovieApiProvider sends http request to the *TMDB* and returns either movie or movie details based on the given endpoint.
class MovieApiProvider {
  Future<List<Movie>> fetchTrendingMovies(int page) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/discover/movie?api_key=${dotenv.env["APIKEY"]}&sort_by=popularity.desc&page=$page"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Movie> movies = List<Movie>.from(
        data['results'].map(
          (movie) => Movie.fromJson(movie),
        ),
      );
      return movies;
    } else {
      throw Exception("Failed to load movies");
    }
  }

  Future<MovieDetails> fetchMovieDetails(int id) async {
    final response = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/$id?api_key=${dotenv.env["APIKEY"]}"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieDetails.fromJson(data);
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  Future<List<Movie>> searchMovie(String query) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?query=$query&api_key=${dotenv.env["APIKEY"]}"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Movie> movies = List<Movie>.from(
        data['results'].map(
          (movie) => Movie.fromJson(movie),
        ),
      );
      return movies;
    } else {
      throw Exception("Failed to fetch movie results");
    }
  }

  Future<List<Movie>> fetchMoviesBasedOnGenre(int id) async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/discover/movie?api_key=${dotenv.env['APIKEY']}&with_genres=$id"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Movie> movies = List<Movie>.from(
        data['results'].map(
          (movie) => Movie.fromJson(movie),
        ),
      );
      return movies;
    } else {
      throw Exception("Failed to fetch movies based on Genre");
    }
  }

  Future<List<Genre>> fetchGenres() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?language=en&api_key=${dotenv.env['APIKEY']}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Genre> genres = List<Genre>.from(
        data['genres'].map(
          (genre) => Genre.fromJson(genre),
        ),
      );
      return genres;
    } else {
      throw Exception("Failed to fetch Genres");
    }
  }
}
