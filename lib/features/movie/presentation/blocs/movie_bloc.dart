import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_ott_assignment/features/movie/data/models/movie_model.dart';
import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';
import 'package:stage_ott_assignment/features/movie/domain/usecases/add_to_fav_usecase.dart';
import 'package:stage_ott_assignment/features/movie/domain/usecases/get_saved_movies_usecase.dart';
import 'package:stage_ott_assignment/features/movie/domain/usecases/remove_from_fav_usecase.dart';

import '../../../../core/resources/data_state.dart';

import '../../domain/usecases/get_movie_usecase.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRemoteUseCase _getMovieUseCase;
  final SaveMovieUseCase _saveMovieUseCase;
  final RemoveMovieUseCase _removeMovieUseCase;
  final GetSavedMoviesUseCase _getSavedMoviesUseCase;
  bool _isFetching = false;

  get isFetching => _isFetching;
  int _totalPages = 1;
  get totalPages => _totalPages;
  List<MovieItemEntity> movieList = [];
  MovieBloc(
    this._getMovieUseCase,
    this._getSavedMoviesUseCase,
    this._removeMovieUseCase,
    this._saveMovieUseCase,
  ) : super(MovieInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<FetchFavorites>(_onFetchFavorites);
    on<SearchMovies>(_onSearchMovies);
  }

  Future<void> _onFetchMovies(
      FetchMovies event, Emitter<MovieState> emit) async {
    _isFetching = true;
    if (event.pageNumber == '1') {
      movieList = [];
      emit(MovieLoading());
    }
    try {
      final movies = await fetchMoviesFromApi(event.pageNumber);

      // Fetch favorite IDs from the database
      final favoriteMovies = await _getSavedMoviesUseCase.execute();
      final favoriteIds = favoriteMovies.map((movie) => movie.id).toSet();
      movieList.addAll(movies.data!.results!.toList());
      emit(MovieLoaded(movieList, favoriteIds));
    } catch (e) {
      emit(MovieError('Failed to load movies: ${e.toString()}'));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onAddToFavorites(
      AddToFavorites event, Emitter<MovieState> emit) async {
    if (state is MovieLoaded || state is SearchLoaded) {
      final currentState = state;

      // Save movie to the database
      await _saveMovieUseCase.execute(params: event.movie);

      if (currentState is MovieLoaded) {
        final updatedFavorites = {...currentState.favoriteIds, event.movie.id};
        emit(MovieLoaded(currentState.movies, updatedFavorites));
      } else if (currentState is SearchLoaded) {
        final updatedFavorites = {...currentState.favoriteIds, event.movie.id};
        emit(SearchLoaded(currentState.searchResults, updatedFavorites));
      }
    }
  }

  Future<void> _onRemoveFromFavorites(
      RemoveFromFavorites event, Emitter<MovieState> emit) async {
    if (state is MovieLoaded ||
        state is SearchLoaded ||
        state is FavoritesLoaded) {
      final currentState = state;

      // Remove movie from the database
      // await appDatabase.movieDao
      //     .deleteMovieFromLocal(MovieItemModel.fromEntity(event.movie));
      await _removeMovieUseCase.execute(params: event.movie);

      if (currentState is MovieLoaded) {
        final updatedFavorites = {...currentState.favoriteIds}
          ..remove(event.movie.id);
        emit(MovieLoaded(currentState.movies, updatedFavorites));
      } else if (currentState is SearchLoaded) {
        final updatedFavorites = {...currentState.favoriteIds}
          ..remove(event.movie.id);
        emit(SearchLoaded(currentState.searchResults, updatedFavorites));
      } else if (currentState is FavoritesLoaded) {
        try {
          final favoriteMovies = await _getSavedMoviesUseCase.execute();
          emit(FavoritesLoaded(favoriteMovies));
        } catch (e) {
          emit(MovieError('Failed to fetch favorites: ${e.toString()}'));
        }
      }
    }
  }

  Future<void> _onSearchMovies(
      SearchMovies event, Emitter<MovieState> emit) async {
    final searchResults = movieList
        .where((movie) =>
            movie.title!.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    final favoriteMovies = await _getSavedMoviesUseCase.execute();
    final favoriteIds = favoriteMovies.map((movie) => movie.id).toSet();
    emit(SearchLoaded(searchResults, favoriteIds));
  }

  Future<void> _onFetchFavorites(
      FetchFavorites event, Emitter<MovieState> emit) async {
    try {
      emit(MovieLoading());
      final favoriteMovies = await _getSavedMoviesUseCase.execute();
      emit(FavoritesLoaded(favoriteMovies));
    } catch (e) {
      emit(MovieError('Failed to fetch favorites: ${e.toString()}'));
    }
  }

  Future<DataState<MovieAPIModel>> fetchMoviesFromApi(String pageNumber) async {
    final dataState = await _getMovieUseCase.execute(
      params: pageNumber,
    );
    if (dataState is DataSuccess &&
        (dataState.data?.results ?? []).isNotEmpty) {
      _totalPages = dataState.data?.totalPages ?? 0;
      return dataState;
    }
    throw dataState.exception?.message ?? '';
  }
}
