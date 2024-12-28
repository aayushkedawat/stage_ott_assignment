import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';

import '../../../../core/resources/data_state.dart';
import '../../data/models/movie_model.dart';

abstract class MovieRepository {
  Future<DataState<MovieAPIModel>> getMovieList(String page);
  Future<void> saveMovieInLocal(MovieItemEntity page);
  Future<List<MovieItemEntity>> getMoviesFromLocal();
  Future<void> deleteMovieFromLocal(MovieItemEntity page);
}
