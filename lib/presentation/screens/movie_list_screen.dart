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
          return ListView.builder(
              controller: _scrollController,
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${state.movies[index].posterPath}',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(state.movies[index].title),
                  subtitle: Text(state.movies[index].releaseDate.split('-')[0]),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<MovieBloc>(context),
                          child: MovieDetailsScreen(id: state.movies[index].id),
                        ),
                      ),
                    ).then((_) {
                      _page--;
                      _loadMovies();
                    });
                  },
                );
              });
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
