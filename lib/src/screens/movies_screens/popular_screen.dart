import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/views/card_popular.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Lista de peliculas'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favoritas').whenComplete(() {
                  setState(() {});
                });
              },
              icon: Icon(Icons.list_alt))
        ],
      ),
      body: FutureBuilder(
        future: apiPopular!.getAllPoular(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PopularMoviesModel>?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la petición'));
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              //return Center();
              return _listPopularMovies(snapshot.data);
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

  Widget _listPopularMovies(List<PopularMoviesModel>? movies) {
    return ListView.separated(
        itemBuilder: (context, index) {
          PopularMoviesModel popular = movies![index];
          //return Text(popular.title!);
          return CardPopularView(popular: popular);
        },
        separatorBuilder: (_, __) => Divider(height: 10),
        itemCount: movies!.length);
  }
}
