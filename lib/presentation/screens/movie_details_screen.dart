import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app/business_logic/blocs/movie_bloc/movie_bloc.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;

  const MovieDetailsScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MovieBloc>(context).add(FetchMovieDetailsEvent(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 480.0,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${state.movieDetails.posterPath}',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.movieDetails.title,
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(state.movieDetails.releaseDate),
                        const Divider(),
                        Text(state.movieDetails.overview),
                        const Divider(),
                        Text('Budget: \$${state.movieDetails.budget}'),
                        Text('Revenue: \$${state.movieDetails.revenue}'),
                        Text(
                            'Languages: ${state.movieDetails.languages.join(', ')}'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
