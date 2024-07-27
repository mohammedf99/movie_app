import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business_logic/blocs/movie_bloc/movie_bloc.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() {
    BlocProvider.of<MovieBloc>(context).add(FetchMoviesEvent(_page));
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
          return Center(
            child: Text(
              "Movies loaded",
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
