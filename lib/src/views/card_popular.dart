import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movies_model.dart';

class CardPopularView extends StatelessWidget {
  final PopularMoviesModel popular;

  const CardPopularView({Key? key, required this.popular}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 2.5)
            ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
                placeholder: AssetImage('assets/activity_indicator.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${popular.backdropPath}'),
                fadeInDuration: Duration(milliseconds: 200))));
  }
}
