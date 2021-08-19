import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/app_error.dart';
import 'package:movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError,List<MovieEntity>>> getTrending();
  Future<Either<AppError,MovieDetailEntity>> getMovieDetail(int id);
  Future<Either<AppError,List<MovieEntity>>> getSearchedMovies(String searchTerm);
  Future<Either<AppError,void>> saveMovie(MovieEntity movieEntity);
  Future<Either<AppError,List<MovieEntity>>> getFavoriteMovies();
  Future<Either<AppError,void>> deleteFavoriteMovie(int movieId);
  Future<Either<AppError,bool>> checkIfMovieFavorite(int movieId);
}
