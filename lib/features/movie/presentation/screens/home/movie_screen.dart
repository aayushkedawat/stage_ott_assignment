import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_ott_assignment/core/constants/strings.dart';
import 'package:stage_ott_assignment/features/movie/domain/entities/movie_entity.dart';
import '../../../../../injection_container.dart';
import '../../blocs/movie_bloc.dart';
import '../../blocs/movie_event.dart';
import '../../blocs/movie_state.dart';
import '../components/movie_item.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final MovieBloc _movieBloc = sl<MovieBloc>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sl<MovieBloc>().add(FetchMovies(pageNumber: '1'));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _fetchNextPage();
      }
    });
  }

  void _fetchNextPage() {
    if (!_movieBloc.isFetching && _currentPage < _movieBloc.totalPages) {
      _currentPage++;
      _movieBloc.add(FetchMovies(pageNumber: '$_currentPage'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                if (!_movieBloc.isFetching) {
                  sl<MovieBloc>().add(FetchMovies(pageNumber: '1'));
                }
              },
            ),
          ),
          onChanged: (query) {
            context.read<MovieBloc>().add(SearchMovies(query));
          },
        ),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return getUIBasedOnState(state);
        },
      ),
    );
  }

  Widget getUIBasedOnState(MovieState state) {
    if (state is MovieLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MovieLoaded) {
      return _buildMovieList(state.movies, state.favoriteIds, context);
    } else if (state is SearchLoaded) {
      return _buildMovieList(state.searchResults, state.favoriteIds, context);
    } else if (state is MovieError) {
      return Center(child: Text('Error: ${state.error}'));
    } else {
      return const SizedBox();
    }
  }

  Widget _buildMovieList(
      List<MovieItemEntity> movies, Set favIDs, BuildContext context) {
    if (movies.isEmpty) {
      return const Center(child: Text(Strings.noDataAvailable));
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final isFavorite = favIDs.contains(movie.id);

        return movieItemWidget(movie, isFavorite);
      },
    );
  }
}
