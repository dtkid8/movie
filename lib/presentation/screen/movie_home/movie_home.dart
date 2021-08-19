import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/common/constants/size_constant.dart';
import 'package:movie/common/screenutil/screenutil.dart';
import 'package:movie/di/get_it.dart';
import 'package:movie/presentation/bloc/movie_home/movie_home_bloc.dart';
import 'package:movie/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie/presentation/screen/favorite/favorite_screen.dart';
import 'package:movie/presentation/screen/search_movie/custom_search_delegate.dart';
import 'package:movie/presentation/widget/movie_card.dart';
import 'package:movie/common/extensions/size_extensions.dart';

class MovieHome extends StatefulWidget {
  @override
  _MovieHomeState createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  MovieHomeBloc movieHomeBloc;
  SearchMovieBloc searchMovieBloc;
  @override
  void initState() {
    super.initState();
    movieHomeBloc = getItInstance<MovieHomeBloc>();
    movieHomeBloc.add(MovielHomeLoadEvent());
    searchMovieBloc = getItInstance<SearchMovieBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    movieHomeBloc?.close();
    searchMovieBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieHomeBloc,
        ),
        BlocProvider(
          create: (context) => searchMovieBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("MOVIE"),
          centerTitle: true,
          actions: [
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        searchMovieBloc,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: Sizes.dimen_12.h,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: Sizes.dimen_12.h,
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<MovieHomeBloc, MovieHomeState>(
          cubit: movieHomeBloc,
          builder: (context, state) {
            if (state is MovieHomeLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) => MovieCard(
                  movie: state.movies[index],
                ),
                itemCount: state.movies.length,
                scrollDirection: Axis.vertical,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
