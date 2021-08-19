import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String backdropPath;
  final num voteAverage;
  final String posterPath;

  const MovieDetailEntity({
    this.id,
    this.title,
    this.overview,
    this.releaseDate,
    this.backdropPath,
    this.voteAverage,
    this.posterPath,
  });

  @override
  List<Object> get props => [id];
}
