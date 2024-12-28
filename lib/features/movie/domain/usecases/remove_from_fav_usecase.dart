import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/movie_repository.dart';

class RemoveMovieUseCase implements UseCase<void, MovieItemEntity?> {
  final MovieRepository _movieRepository;

  RemoveMovieUseCase(this._movieRepository);

  @override
  Future<void> execute({MovieItemEntity? params}) {
    return _movieRepository.deleteMovieFromLocal(params!);
  }
}
