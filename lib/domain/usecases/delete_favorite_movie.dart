import 'package:movie/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_params.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/usecase.dart';

class DeleteFavoriteMovie extends UseCase<void, MovieParams> {
  final MovieRepository movieRepository;

  DeleteFavoriteMovie(this.movieRepository);

  @override
  Future<Either<AppError, void>> call(MovieParams params) async {
    return await movieRepository.deleteFavoriteMovie(params.id);
  }
}
