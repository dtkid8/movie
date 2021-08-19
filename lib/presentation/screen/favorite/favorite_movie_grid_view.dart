import 'package:flutter/material.dart';
import 'package:movie/common/constants/size_constant.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/common/extensions/size_extensions.dart';
import 'package:movie/presentation/screen/favorite/favorite_movie_card.dart';

class FavoriteMovieGridView extends StatelessWidget {
  final List<MovieEntity> movies;
  const FavoriteMovieGridView({
    Key key,
    @required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Sizes.dimen_8.w,
        vertical: Sizes.dimen_8.h,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: Sizes.dimen_16.w,
        ),
        itemBuilder: (context, index) {
          return FavoriteMovieCardWidget(
            movie: movies[index],
          );
        },
      ),
    );
  }
}
