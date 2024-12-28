import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/util/http_client.dart';
import 'features/movie/data/data_sources/local/local/app_database.dart';
import 'features/movie/data/data_sources/remote/movie_data_source.dart';
import 'features/movie/data/repositories/movie_repository_impl.dart';
import 'features/movie/domain/repositories/movie_repository.dart';
import 'features/movie/domain/usecases/get_movie_usecase.dart';
import 'features/movie/domain/usecases/get_saved_movies_usecase.dart';
import 'features/movie/domain/usecases/remove_from_fav_usecase.dart';
import 'features/movie/domain/usecases/add_to_fav_usecase.dart';

import 'features/movie/presentation/blocs/movie_bloc.dart';

final sl = GetIt.instance;

Future<void> initialiseDependencies() async {
  // local database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton(database);
  // Http client
  sl.registerSingleton<http.Client>(UserAgentClient(http.Client()));
  // Dependencies
  sl.registerSingleton<MovieRemoteDataSource>(MovieRemoteDataSourceImpl(sl()));

  sl.registerSingleton<MovieRepository>(MovieRepositoryImpl(sl(), sl()));

  // Usecase
  sl.registerSingleton<GetMovieRemoteUseCase>(GetMovieRemoteUseCase(sl()));
  sl.registerSingleton<GetSavedMoviesUseCase>(GetSavedMoviesUseCase(sl()));
  sl.registerSingleton<RemoveMovieUseCase>(RemoveMovieUseCase(sl()));
  sl.registerSingleton<SaveMovieUseCase>(SaveMovieUseCase(sl()));

  sl.registerSingleton<MovieBloc>(MovieBloc(sl(), sl(), sl(), sl()));
}
