class Constants {
  static const String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNzU3YTcxMGQyMGExZTQyYWY0MTMyMTg1OGU0MGE2MCIsIm5iZiI6MTU1MzE4MDQ3Ni4zNjA5OTk4LCJzdWIiOiI1YzkzYTczYzkyNTE0MTJiNTg3OGE1NjUiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.AJCLc1spRE2FFX2yLAMceLRkD8nMhYXAN3luWCmEFa8';
}

class Urls {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/original';
  static String getMovieListAPIUrl(String pageNumber) =>
      '$baseUrl/trending/movie/day?language=en-US&page=$pageNumber';
}
