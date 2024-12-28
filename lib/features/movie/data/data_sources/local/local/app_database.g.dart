// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movie` (`backdropPath` TEXT, `id` INTEGER, `title` TEXT, `originalTitle` TEXT, `overview` TEXT, `posterPath` TEXT, `mediaType` TEXT, `adult` INTEGER, `originalLanguage` TEXT, `popularity` REAL, `releaseDate` TEXT, `video` INTEGER, `voteAverage` REAL, `voteCount` INTEGER, `isFav` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieItemModelInsertionAdapter = InsertionAdapter(
            database,
            'movie',
            (MovieItemModel item) => <String, Object?>{
                  'backdropPath': item.backdropPath,
                  'id': item.id,
                  'title': item.title,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'mediaType': item.mediaType,
                  'adult': item.adult == null ? null : (item.adult! ? 1 : 0),
                  'originalLanguage': item.originalLanguage,
                  'popularity': item.popularity,
                  'releaseDate': item.releaseDate,
                  'video': item.video == null ? null : (item.video! ? 1 : 0),
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'isFav': item.isFav == null ? null : (item.isFav! ? 1 : 0)
                }),
        _movieItemModelDeletionAdapter = DeletionAdapter(
            database,
            'movie',
            ['id'],
            (MovieItemModel item) => <String, Object?>{
                  'backdropPath': item.backdropPath,
                  'id': item.id,
                  'title': item.title,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'posterPath': item.posterPath,
                  'mediaType': item.mediaType,
                  'adult': item.adult == null ? null : (item.adult! ? 1 : 0),
                  'originalLanguage': item.originalLanguage,
                  'popularity': item.popularity,
                  'releaseDate': item.releaseDate,
                  'video': item.video == null ? null : (item.video! ? 1 : 0),
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'isFav': item.isFav == null ? null : (item.isFav! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieItemModel> _movieItemModelInsertionAdapter;

  final DeletionAdapter<MovieItemModel> _movieItemModelDeletionAdapter;

  @override
  Future<List<MovieItemModel>> getMovieList() async {
    return _queryAdapter.queryList('select * from movie',
        mapper: (Map<String, Object?> row) => MovieItemModel(
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int?,
            title: row['title'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String?,
            posterPath: row['posterPath'] as String?,
            mediaType: row['mediaType'] as String?,
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            originalLanguage: row['originalLanguage'] as String?,
            popularity: row['popularity'] as double?,
            releaseDate: row['releaseDate'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?));
  }

  @override
  Future<List<MovieItemModel>> isFav(String id) async {
    return _queryAdapter.queryList('select * from movie where id = ?1',
        mapper: (Map<String, Object?> row) => MovieItemModel(
            backdropPath: row['backdropPath'] as String?,
            id: row['id'] as int?,
            title: row['title'] as String?,
            originalTitle: row['originalTitle'] as String?,
            overview: row['overview'] as String?,
            posterPath: row['posterPath'] as String?,
            mediaType: row['mediaType'] as String?,
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            originalLanguage: row['originalLanguage'] as String?,
            popularity: row['popularity'] as double?,
            releaseDate: row['releaseDate'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> saveMovieInLocal(MovieItemModel resultsModel) async {
    await _movieItemModelInsertionAdapter.insert(
        resultsModel, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMovieFromLocal(MovieItemModel resultsModel) async {
    await _movieItemModelDeletionAdapter.delete(resultsModel);
  }
}
