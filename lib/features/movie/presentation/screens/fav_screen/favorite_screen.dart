import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_ott_assignment/core/constants/strings.dart';
import 'package:stage_ott_assignment/features/movie/presentation/blocs/movie_bloc.dart';
import 'package:stage_ott_assignment/features/movie/presentation/blocs/movie_event.dart';
import 'package:stage_ott_assignment/features/movie/presentation/blocs/movie_state.dart';
import 'package:stage_ott_assignment/injection_container.dart';

import '../components/movie_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    sl<MovieBloc>().add(FetchFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.favScreenTitle),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return getUIBasedOnState(state);
        },
      ),
    );
  }

  Widget getUIBasedOnState(MovieState state) {
    if (state is FavoritesLoaded) {
      if (state.favoriteMovies.isNotEmpty) {
        return ListView.builder(
          itemCount: state.favoriteMovies.length,
          itemBuilder: (context, index) {
            final movie = state.favoriteMovies[index];
            const isFavorite = true;

            return movieItemWidget(movie, isFavorite);
          },
        );
      }
    } else if (state is MovieLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Center(
      child: Text(Strings.noDataAvailable),
    );
  }
}
