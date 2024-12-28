import 'package:floor/floor.dart';
import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';

class MovieAPIModel extends MovieAPIEntity {
  const MovieAPIModel({
    super.page,
    super.results,
    super.totalPages,
    super.totalResults,
  });
  factory MovieAPIModel.fromJson(Map<String, dynamic> json) {
    final resultsModelList = <MovieItemModel>[];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        resultsModelList.add(MovieItemModel.fromJson(v));
      });
    }
    return MovieAPIModel(
      page: json["page"],
      results: resultsModelList,
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }
}

@Entity(tableName: 'movie', primaryKeys: ['id'])
class MovieItemModel extends MovieItemEntity {
  const MovieItemModel({
    super.backdropPath,
    super.id,
    super.title,
    super.originalTitle,
    super.overview,
    super.posterPath,
    super.mediaType,
    super.adult,
    super.originalLanguage,
    super.popularity,
    super.releaseDate,
    super.video,
    super.voteAverage,
    super.voteCount,
  });
  factory MovieItemModel.fromJson(Map<String, dynamic> json) {
    return MovieItemModel(
      backdropPath: json["backdrop_path"],
      id: json["id"],
      title: json["title"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      mediaType: json["media_type"],
      adult: json["adult"],
      originalLanguage: json["original_language"],
      popularity: json["popularity"],
      releaseDate: json["release_date"],
      video: json["video"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }

  factory MovieItemModel.fromEntity(MovieItemEntity pageEntity) {
    return MovieItemModel(
      adult: pageEntity.adult,
      backdropPath: pageEntity.backdropPath,
      id: pageEntity.id,
      mediaType: pageEntity.mediaType,
      originalLanguage: pageEntity.originalLanguage,
      originalTitle: pageEntity.originalTitle,
      overview: pageEntity.overview,
      popularity: pageEntity.popularity,
      posterPath: pageEntity.posterPath,
      releaseDate: pageEntity.releaseDate,
      title: pageEntity.title,
      video: pageEntity.video,
      voteAverage: pageEntity.voteAverage,
      voteCount: pageEntity.voteCount,
    );
  }
}
