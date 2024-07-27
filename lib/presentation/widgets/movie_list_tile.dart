import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieListTile extends StatelessWidget {
  final int id;
  final String title;
  final String releaseDate;
  final String posterPath;
  final VoidCallback navigationMethod;

  const MovieListTile({
    super.key,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.id,
    required this.navigationMethod,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: 'https://image.tmdb.org/t/p/w500$posterPath',
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(title),
      subtitle: Text(releaseDate.split('-')[0]),
      onTap: () => navigationMethod(),
    );
  }
}
