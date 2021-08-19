import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/app_error.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/entities/movie_search_params.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/usecase.dart';

class SearchMovie extends UseCase<List<MovieEntity>,MovieSearchParams> {
  final MovieRepository repository;
  SearchMovie(this.repository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(MovieSearchParams searchParams) async {
    return await repository.getSearchedMovies(searchParams.searchTerm);
  } 
}
