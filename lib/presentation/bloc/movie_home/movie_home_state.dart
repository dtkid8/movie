part of 'movie_home_bloc.dart';

abstract class MovieHomeState extends Equatable {
  const MovieHomeState();
  
  @override
  List<Object> get props => [];
}

class MovieHomeInitial extends MovieHomeState {}

class MovieHomeError extends MovieHomeState{

}

class MovieHomeLoaded extends MovieHomeState{
  final List<MovieEntity> movies;
  const MovieHomeLoaded({this.movies});
}
