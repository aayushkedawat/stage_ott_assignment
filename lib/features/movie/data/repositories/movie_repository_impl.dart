import 'package:stage_ott_assignment/core/resources/data_state.dart';
import 'package:stage_ott_assignment/features/movie/data/data_sources/local/local/app_database.dart';
import 'package:stage_ott_assignment/features/movie/data/models/movie_model.dart';
import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';
import 'package:stage_ott_assignment/features/movie/domain/repositories/movie_repository.dart';
import 'package:stage_ott_assignment/features/movie/data/data_sources/remote/movie_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieDataSource;
  final AppDatabase appDatabase;
  MovieRepositoryImpl(this.movieDataSource, this.appDatabase);

  @override
  Future<DataState<MovieAPIModel>> getMovieList(String page) {
    return movieDataSource.getMovieList(page);
  }

  @override
  Future<List<MovieItemEntity>> getMoviesFromLocal() {
    return appDatabase.movieDao.getMovieList();
  }

  @override
  Future<void> saveMovieInLocal(MovieItemEntity page) {
    return appDatabase.movieDao
        .saveMovieInLocal(MovieItemModel.fromEntity(page));
  }

  @override
  Future<void> deleteMovieFromLocal(MovieItemEntity page) {
    return appDatabase.movieDao
        .deleteMovieFromLocal(MovieItemModel.fromEntity(page));
  }
}
