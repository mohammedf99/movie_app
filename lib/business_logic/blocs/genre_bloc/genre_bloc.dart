import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/genre.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  MovieRepository movieRepository;
  GenreBloc(this.movieRepository) : super(GenreInitial()) {
    on<FetchGenreEvent>((event, emit) async {
      emit(GenreLoading());
      try {
        final genres = await movieRepository.fetchGenre();
        emit(GenreLoaded(genres: genres));
      } catch (e) {
        emit(
          GenreError(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
