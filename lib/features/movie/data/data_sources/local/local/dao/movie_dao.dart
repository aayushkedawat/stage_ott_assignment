import 'package:floor/floor.dart';
import 'package:stage_ott_assignment/features/movie/data/models/movie_model.dart';

@dao
abstract class MovieDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveMovieInLocal(MovieItemModel resultsModel);

  @delete
  Future<void> deleteMovieFromLocal(MovieItemModel resultsModel);

  @Query('select * from movie')
  Future<List<MovieItemModel>> getMovieList();
  @Query('select * from movie where id = :id')
  Future<List<MovieItemModel>> isFav(String id);
}
