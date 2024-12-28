import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';
import 'package:stage_ott_assignment/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/usecase/usecase.dart';

class GetSavedMoviesUseCase implements UseCase<List<MovieItemEntity>, void> {
  final MovieRepository _movieRepository;

  GetSavedMoviesUseCase(this._movieRepository);

  @override
  Future<List<MovieItemEntity>> execute({void params}) {
    return _movieRepository.getMoviesFromLocal();
  }
}
