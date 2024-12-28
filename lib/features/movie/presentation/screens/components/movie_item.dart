import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';

import '../../../../../injection_container.dart';
import '../../blocs/movie_bloc.dart';
import '../../blocs/movie_event.dart';

Widget movieItemWidget(
  MovieItemEntity movie,
  bool isFavorite,
) {
  return ListTile(
    leading: CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    ),
    title: Text(movie.title ?? ''),
    trailing: IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        final bloc = sl<MovieBloc>();
        if (isFavorite) {
          bloc.add(RemoveFromFavorites(movie));
        } else {
          bloc.add(AddToFavorites(movie));
        }
      },
    ),
  );
}
