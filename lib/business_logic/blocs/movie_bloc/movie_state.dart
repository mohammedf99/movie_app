part of 'movie_bloc.dart';

/// Different States of movie are available which are:
/// - MovieInitial
/// - MovieLoading
/// - MovieLoaded => takes a list< Movie >
/// - MovieDetailsLoading
/// - MovieDetailsLoaded => has MovieDetail as attribute
/// - MovieError => needs error message
/// - MovieSearchEmpty
@immutable
abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieDetailsLoading extends MovieState {}

class MovieDetailsLoaded extends MovieState {
  final MovieDetails movieDetails;

  const MovieDetailsLoaded({required this.movieDetails});

  @override
  List<Object> get props => [movieDetails];
}

class MovieError extends MovieState {
  final String message;

  const MovieError({required this.message});

  @override
  List<Object> get props => [message];
}

// Some given searches might not be available by TMDB query.
class MovieSearchEmpty extends MovieState {}
