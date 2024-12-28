import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/movie_model.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/error/faliure.dart';
import '../../../../../core/resources/data_state.dart';

abstract class MovieRemoteDataSource {
  Future<DataState<MovieAPIModel>> getMovieList(String page);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  MovieRemoteDataSourceImpl(this.client);

  @override
  Future<DataState<MovieAPIModel>> getMovieList(String page) async {
    try {
      final response = await client.get(Uri.parse(
        Urls.getMovieListAPIUrl(page),
      ));

      if (response.statusCode == 200) {
        MovieAPIModel movieModel =
            MovieAPIModel.fromJson(jsonDecode(response.body));

        return DataSuccess(movieModel);
      } else {
        return DataFailed(ServerFaliure(response.body));
      }
    } on http.ClientException catch (ex) {
      return DataFailed(ServerFaliure(ex.message));
    }
  }
}
