import 'package:stage_ott_assignment/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/movie_model.dart';

class GetMovieRemoteUseCase extends UseCase<DataState<MovieAPIModel>, String> {
  final MovieRepository _movieRepository;
  GetMovieRemoteUseCase(this._movieRepository);

  @override
  Future<DataState<MovieAPIModel>> execute({String? params}) {
    return _movieRepository.getMovieList(params ?? '1');
  }
}
