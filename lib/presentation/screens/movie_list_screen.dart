import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business_logic/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/presentation/screens/movie_details_screen.dart';
import 'package:movie_app/presentation/widgets/genre_dropdown.dart';
import 'package:movie_app/presentation/widgets/movie_list_tile.dart';
import 'package:movie_app/presentation/widgets/search_text_field.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  int _page = 1;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMovies();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMovies();
      }
    });
  }

  void _loadMovies() {
    BlocProvider.of<MovieBloc>(context).add(FetchMoviesEvent(_page));
    _page++;
  }

  void _navigateBack(int id) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<MovieBloc>(context),
          child: MovieDetailsScreen(id: id),
        ),
      ),
    )
        .then((_) {
      _page--;
      _loadMovies();
    });
  }

  void _searchMovies(String query) {
    context.read<MovieBloc>().add(SearchMoviesEvent(query: query));
  }

  void _searchMoviesByGenre(int id) {
    context.read<MovieBloc>().add(SearchMoviesByGenreEvent(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        if (state is MovieLoading) {
          return const CircularProgressIndicator.adaptive();
        } else if (state is MovieSearchEmpty) {
          return Center(
            child: Text(
              "No movie found",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        } else if (state is MovieLoaded) {
          return Column(
            children: [
              SearchTextField(searchController: _searchController, searchMovies: _searchMovies),
              GenreDropdown(searchByGenre: _searchMoviesByGenre,),
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return MovieListTile(
                        title: movie.title,
                        releaseDate: movie.releaseDate,
                        posterPath: movie.posterPath ?? '',
                        id: movie.id,
                        navigationMethod: () =>
                            _navigateBack(movie.id),
                      );
                    }),
              ),
            ],
          );
        } else if (state is MovieError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
