import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/fav_model.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/views/card_popular.dart';

class FavoritaScreen extends StatefulWidget {
  FavoritaScreen({Key? key}) : super(key: key);

  @override
  _FavoritaScreenState createState() => _FavoritaScreenState();
}

class _FavoritaScreenState extends State<FavoritaScreen> {
  ApiPopular? apiPopular;
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Lista de peliculas favoritas'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllFavoritas(),
        builder: (BuildContext context,
            AsyncSnapshot<List<FavoritaModel>?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la petición'));
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              //return Center();
              return _listFavoritaMovies(snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  Widget _listFavoritaMovies(List<FavoritaModel>? movies) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {});
        });
      },
      child: ListView.separated(
          itemBuilder: (context, index) {
            PopularMoviesModel popular = new PopularMoviesModel(
                id: movies![index].id,
                title: movies[index].title,
                backdropPath: movies[index].backdropPath);
            //return Text(popular.title!);
            return CardPopularView(popular: popular);
          },
          separatorBuilder: (_, __) => Divider(height: 10),
          itemCount: movies!.length),
    );
  }
}
