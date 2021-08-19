import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/app_error.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/entities/movie_search_params.dart';
import 'package:movie/domain/usecases/search_movie.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovie searchMovie;
  SearchMovieBloc({
    @required this.searchMovie,
  }) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchMovieEvent event,
  ) async* {
    if (event is SearchTermChangedEvent) {
      if (event.searchTerm.length > 0) {
        yield SearchMovieLoading();
        final Either<AppError, List<MovieEntity>> response = await searchMovie(
          MovieSearchParams(
            searchTerm: event.searchTerm,
          ),
        );
        yield response.fold(
          (l) => SearchMovieError(),
          (r) => SearchMovieLoaded(r),
        );
      }
    }
  }
}
