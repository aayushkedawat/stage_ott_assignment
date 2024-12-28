import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/movie_repository.dart';

class SaveMovieUseCase implements UseCase<void, MovieItemEntity?> {
  final MovieRepository _movieRepository;

  SaveMovieUseCase(this._movieRepository);

  @override
  Future<void> execute({MovieItemEntity? params}) {
    return _movieRepository.saveMovieInLocal(params!);
  }
}
