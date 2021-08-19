import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/common/constants/size_constant.dart';
import 'package:movie/di/get_it.dart';
import 'package:movie/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/screen/movie_detail/big_poster.dart';
import 'package:movie/presentation/screen/movie_detail/movie_detail_arguments.dart';
import 'package:movie/common/extensions/size_extensions.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments movieDetailArguments;
  const MovieDetailScreen({
    Key key,
    @required this.movieDetailArguments,
  })  : assert(movieDetailArguments != null, 'arguments must not be null'),
        super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailBloc _movieDetailBloc;
  FavoriteBloc _favoriteBloc;
  @override
  void initState() {
    super.initState();
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _favoriteBloc = _movieDetailBloc.favoriteBloc;
    _movieDetailBloc.add(
      MovieDetailLoadEvent(
        widget.movieDetailArguments.movieId,
      ),
    );
  }

  @override
  void dispose() {
    _movieDetailBloc?.close();
    _favoriteBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailBloc),
          BlocProvider.value(value: _favoriteBloc),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movieDetail = state.movieDetailEntity;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BigPoster(
                      movie: movieDetail,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_16.w,
                        vertical: Sizes.dimen_8.h,
                      ),
                      child: Text(
                        movieDetail.overview,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is MovieDetailError) {
              return Container();
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
