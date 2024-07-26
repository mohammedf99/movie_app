part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchMoviesEvent extends MovieEvent {
  final int page;

  const FetchMoviesEvent(this.page);

  @override
  List<Object> get props => [page];
}

class FetchMovieDetailsEvent extends MovieEvent {
  final int id;

  const FetchMovieDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}