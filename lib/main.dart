import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/data/providers/movie_api_provider.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';
import 'package:movie_app/presentation/screens/movie_list_screen.dart';

import 'business_logic/blocs/movie_bloc/movie_bloc.dart';
import 'presentation/theme/theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final movieApiProvider = MovieApiProvider();
  final movieRepository = MovieRepository(movieApiProvider: movieApiProvider);
  runApp(
    MyApp(
      movieRepository: movieRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final MovieRepository movieRepository;

  const MyApp({required this.movieRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movie App",
      theme: themeData,
      home: BlocProvider<MovieBloc>(
        create: (ctx) => MovieBloc(movieRepository),
        child: const MovieListScreen(),
      ),
    );
  }
}
