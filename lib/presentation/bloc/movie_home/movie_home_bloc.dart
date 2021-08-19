import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/entities/no_params.dart';
import 'package:movie/domain/usecases/get_trending.dart';
import 'package:flutter/foundation.dart';

part 'movie_home_event.dart';
part 'movie_home_state.dart';

class MovieHomeBloc extends Bloc<MovieHomeEvent, MovieHomeState> {
  final GetTrending getTrending;
  MovieHomeBloc({
    @required this.getTrending,
  }) : super(MovieHomeInitial());

  @override
  Stream<MovieHomeState> mapEventToState(
    MovieHomeEvent event,
  ) async* {
    if (event is MovielHomeLoadEvent) {
      final moviesEither = await getTrending(NoParams());
      yield moviesEither.fold((l) => MovieHomeError(), (movies) {
        return MovieHomeLoaded(
          movies: movies,
        );
      });
    }
  }
}
