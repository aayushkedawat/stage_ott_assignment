// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:stage_ott_assignment/features/movie/data/models/movie_model.dart';

import 'dao/movie_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [MovieItemModel])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
}
