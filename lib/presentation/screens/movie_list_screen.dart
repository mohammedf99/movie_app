import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business_logic/blocs/movie_bloc/movie_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/presentation/screens/movie_details_screen.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        if (state is MovieLoading) {
          return const CircularProgressIndicator.adaptive();
        } else if (state is MovieLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                      hintText: "Search for movie...",
                      hintStyle: Theme.of(context).textTheme.titleMedium,
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Color(0xffD3D3D3),
                        ),
                        onPressed: () {
                          if (_searchController.text.isEmpty ||
                              _searchController.text == '') return;
                          _searchMovies(_searchController.text);
                          _searchController.clear();
                        },
                      )),
                  onSubmitted: (_) {
                    if (_searchController.text.isEmpty ||
                        _searchController.text == '') return;
                    _searchMovies(_searchController.text);
                    _searchController.clear();
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return MovieListTile(
                        title: state.movies[index].title,
                        releaseDate: state.movies[index].releaseDate,
                        posterPath: state.movies[index].posterPath,
                        id: state.movies[index].id,
                        navigationMethod: () =>
                            _navigateBack(state.movies[index].id),
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
