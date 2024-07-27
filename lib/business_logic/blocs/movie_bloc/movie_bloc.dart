import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/data/models/movie_details.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await movieRepository.fetchTrendingMovies(event.page);
        emit(MovieLoaded(movies: movies));
      } catch (e) {
        emit(MovieError(message: e.toString()));
      }
    });

    on<FetchMovieDetailsEvent>((event, emit) async {
      emit(MovieDetailsLoading());
      try {
        final movieDetials = await movieRepository.fetchMovieDetails(event.id);
        emit(MovieDetailsLoaded(movieDetails: movieDetials));
      } catch (e) {
        emit(MovieError(message: e.toString()));
      }
    });

    on<SearchMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await movieRepository.fetchSearchResults(event.query);
        emit(MovieLoaded(movies: movies));
      } catch (e) {
        emit(MovieError(message: e.toString()));
      }
    });
  }
}
