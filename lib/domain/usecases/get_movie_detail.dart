import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/app_error.dart';
import 'package:movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/domain/entities/movie_params.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/usecase.dart';

class GetMovieDetail extends UseCase<MovieDetailEntity,MovieParams> {
  final MovieRepository repository;
  GetMovieDetail(this.repository);

  @override
  Future<Either<AppError, MovieDetailEntity>> call(MovieParams params) async {
    return await repository.getMovieDetail(params.id);
  } 
}
