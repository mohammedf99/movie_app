import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business_logic/blocs/genre_bloc/genre_bloc.dart';
import 'package:movie_app/data/models/genre.dart';

class GenreDropdown extends StatefulWidget {
  final Function searchByGenre;

  const GenreDropdown({super.key, required this.searchByGenre});

  @override
  State<GenreDropdown> createState() => _GenreDropdownState();
}

class _GenreDropdownState extends State<GenreDropdown> {
  Genre? selectedGenre;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is GenreLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GenreLoaded) {
          final genres = state.genres;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DropdownButton<Genre>(
                  hint: Text(
                    "Select Genre",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  dropdownColor: Theme.of(context).colorScheme.onSurface,
                  isExpanded: true,
                  value: selectedGenre,
                  onChanged: (Genre? newValue) {
                    setState(() {
                      selectedGenre = newValue!;
                    });
                    if (newValue != null) {
                      widget.searchByGenre(newValue.id);
                    }
                  },
                  items: genres.map((Genre genre) {
                    return DropdownMenuItem<Genre>(
                      value: genre,
                      child: Text(genre.name),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        } else if (state is GenreError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Container();
        }
      },
    );
  }
}
