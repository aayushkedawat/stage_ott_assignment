import 'package:equatable/equatable.dart';

class MovieAPIEntity extends Equatable {
  final int? page;
  final List<MovieItemEntity>? results;
  final int? totalPages;
  final int? totalResults;

  const MovieAPIEntity({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [
        page,
        results,
        totalPages,
        totalResults,
      ];
}

class MovieItemEntity extends Equatable {
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final bool? adult;
  final String? originalLanguage;
  final double? popularity;
  final String? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final bool? isFav;

  const MovieItemEntity({
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.originalLanguage,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.isFav,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        title,
        originalTitle,
        overview,
        posterPath,
        mediaType,
        adult,
        originalLanguage,
        popularity,
        releaseDate,
        video,
        voteAverage,
        voteCount,
      ];
}
