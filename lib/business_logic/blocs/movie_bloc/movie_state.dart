part of 'movie_bloc.dart';

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

class MovieSearchEmpty extends MovieState {}
