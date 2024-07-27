import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController searchController;
  final Function searchMovies;

  const SearchTextField(
      {super.key, required this.searchController, required this.searchMovies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
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
              if (searchController.text.isEmpty || searchController.text == '') return;
              searchMovies(searchController.text);
              searchController.clear();
            },
          ),
        ),
        onSubmitted: (_) {
          if (searchController.text.isEmpty || searchController.text == '') return;
          searchMovies(searchController.text);
          searchController.clear();
        },
      ),
    );
  }
}
