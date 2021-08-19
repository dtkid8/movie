import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie/data/core/api_client.dart';
import 'package:movie/data/data_sources/movie_local_data_source.dart';
import 'package:movie/data/data_sources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repositories_implement.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/check_if_favorite_movie.dart';
import 'package:movie/domain/usecases/delete_favorite_movie.dart';
import 'package:movie/domain/usecases/get_favorite_movies.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_trending.dart';
import 'package:movie/domain/usecases/save_movie.dart';
import 'package:movie/domain/usecases/search_movie.dart';
import 'package:movie/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_home/movie_home_bloc.dart';
import 'package:movie/presentation/bloc/search_movie/search_movie_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImplement(getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImplement());

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImplement(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(() => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<SearchMovie>(() => SearchMovie(getItInstance()));
  getItInstance.registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance
      .registerLazySingleton<CheckIfFavoriteMovie>(() => CheckIfFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(() => GetFavoriteMovies(getItInstance()));
  getItInstance
      .registerLazySingleton<DeleteFavoriteMovie>(() => DeleteFavoriteMovie(getItInstance()));

  getItInstance.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: getItInstance(),
      favoriteBloc: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieHomeBloc(
      getTrending: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      searchMovie: getItInstance(),
    ),
  );
  getItInstance.registerFactory(
    () => FavoriteBloc(
      checkIfFavoriteMovie: getItInstance(),
      deleteFavoriteMovie: getItInstance(),
      getFavoriteMovies: getItInstance(),
      saveMovie: getItInstance(),
    ),
  );
}
