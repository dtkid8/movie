import 'package:movie/data/core/api_client.dart';
import 'package:movie/data/model/movie_detail_model.dart';
import 'package:movie/data/model/movie_model.dart';
import 'package:movie/data/model/movies_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<MovieModel>> getSearchedMovies(String searchTerm);
}

class MovieRemoteDataSourceImplement extends MovieRemoteDataSource {
  final ApiClient _client;
  MovieRemoteDataSourceImplement(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final response = await _client.get('trending/movie/day');
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    print(movie);
    return movie;
  }

  @override
  Future<List<MovieModel>> getSearchedMovies(String searchTerm) async {
    final response = await _client.get('search/movie', params: {
      'query': searchTerm,
    });
    final movies = MoviesResultModel.fromJson(response).movies;
    print(movies);
    return movies;
  }
}
