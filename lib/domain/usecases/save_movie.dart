import 'package:movie/domain/entities/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/usecase.dart';

class SaveMovie extends UseCase<void,MovieEntity>{
  final MovieRepository movieRepository;

  SaveMovie(this.movieRepository);

  @override
  Future<Either<AppError, void>> call(MovieEntity params) async {
    return await movieRepository.saveMovie(params);
  }

}