import 'package:dartz/dartz.dart';
import 'package:movie/data/data_sources/movie_local_data_source.dart';
import 'package:movie/data/data_sources/movie_remote_data_source.dart';
import 'package:movie/data/model/movie_detail_model.dart';
import 'package:movie/data/model/movie_model.dart';
import 'package:movie/data/tables/movie_table.dart';
import 'package:movie/domain/entities/app_error.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImplement extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  MovieRepositoryImplement(this.remoteDataSource, this.localDataSource);
  @override
  Future<Either<AppError, List<MovieModel>>> getTrending() async {
    try {
      final movies = await remoteDataSource.getTrending();
      return Right(movies);
    } on Exception {
      return Left(AppError("ERROR"));
    }
  }

  @override
  Future<Either<AppError, MovieDetailModel>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on Exception {
      return Left(AppError("ERROR"));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getSearchedMovies(String searchTerm) async {
    try {
      final movies = await remoteDataSource.getSearchedMovies(searchTerm);
      return Right(movies);
    } on Exception {
      return Left(AppError("ERROR"));
    }
  }

  @override
  Future<Either<AppError, bool>> checkIfMovieFavorite(int movieId) async {
    try {
      final response = await localDataSource.checkIfMovieFavorite(movieId);
      return Right(response);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> deleteFavoriteMovie(int movieId) async {
    try {
      final response = await localDataSource.deleteMovie(movieId);
      return Right(response);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies() async {
    try {
      final response = await localDataSource.getMovies();
      return Right(response);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity) async {
    try {
      final response = await localDataSource.saveMovie(MovieTable.fromMovieEntity(movieEntity));
      return Right(response);
    } on Exception catch (e) {
      return Left(AppError(e.toString()));
    }
  }
}
