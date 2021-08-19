import 'package:movie/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/entities/no_params.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/usecase.dart';

class GetFavoriteMovies extends UseCase<List<MovieEntity>, NoParams> {
  final MovieRepository movieRepository;

  GetFavoriteMovies(this.movieRepository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParams noParams) async {
    return await movieRepository.getFavoriteMovies();
  }
}
