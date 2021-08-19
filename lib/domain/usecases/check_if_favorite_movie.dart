import 'package:movie/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_params.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/usecase.dart';

class CheckIfFavoriteMovie extends UseCase<bool, MovieParams> {
  final MovieRepository movieRepository;

  CheckIfFavoriteMovie(this.movieRepository);

  @override
  Future<Either<AppError, bool>> call(MovieParams params) async {
    return await movieRepository.checkIfMovieFavorite(params.id);
  }
}
