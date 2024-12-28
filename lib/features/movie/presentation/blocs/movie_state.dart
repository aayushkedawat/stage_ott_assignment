import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieItemEntity> movies;
  final Set<int?> favoriteIds;

  MovieLoaded(this.movies, this.favoriteIds);
}

class FavoritesLoaded extends MovieState {
  final List<MovieItemEntity> favoriteMovies;

  FavoritesLoaded(this.favoriteMovies);
}

class SearchLoaded extends MovieState {
  final List<MovieItemEntity> searchResults;
  final Set<int?> favoriteIds;
  SearchLoaded(this.searchResults, this.favoriteIds);
}

class MovieError extends MovieState {
  final String error;
  MovieError(this.error);
}
