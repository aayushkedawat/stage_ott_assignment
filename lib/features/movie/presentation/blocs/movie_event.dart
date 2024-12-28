import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';

abstract class MovieEvent {}

class FetchMovies extends MovieEvent {
  final String pageNumber;

  FetchMovies({required this.pageNumber});
}

class AddToFavorites extends MovieEvent {
  final MovieItemEntity movie;
  AddToFavorites(this.movie);
}

class RemoveFromFavorites extends MovieEvent {
  final MovieItemEntity movie;
  RemoveFromFavorites(this.movie);
}

class FetchFavorites extends MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;
  SearchMovies(this.query);
}
