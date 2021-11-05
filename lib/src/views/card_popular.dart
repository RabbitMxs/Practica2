import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movies_model.dart';

class CardPopularView extends StatefulWidget {
  final PopularMoviesModel popular;

  const CardPopularView({Key? key, required this.popular}) : super(key: key);

  @override
  _CardPopularViewState createState() => _CardPopularViewState();
}

class _CardPopularViewState extends State<CardPopularView> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
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
                'https://image.tmdb.org/t/p/w500${widget.popular.backdropPath}'),
            fadeInDuration: Duration(milliseconds: 200),
          ),
        ),
      ),
      Opacity(
        opacity: .5,
        child: Container(
          padding: EdgeInsets.only(left: 15),
          height: 60.0,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'titulo',
                child: Text(
                  widget.popular.title.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: {'id': widget.popular.id},
                  ).whenComplete(() {
                    setState(() {});
                  });
                },
                child: Icon(Icons.chevron_right, color: Colors.white),
              )
            ],
          ),
        ),
      )
    ]);
  }
}
