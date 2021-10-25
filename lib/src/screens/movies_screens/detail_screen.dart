import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/cast_list.dart';
import 'package:practica2/src/models/fav_model.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    ApiPopular? apiPopular = ApiPopular();

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: FutureBuilder(
        future: apiPopular.getMovieDetail(arguments['id']),
        builder: (BuildContext context,
            AsyncSnapshot<PopularMoviesModel?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la petición'));
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              //return Center();
              return _viewDetails(snapshot.data, arguments['id'], context);
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

  Widget _viewDetails(PopularMoviesModel? movie, int id, BuildContext context) {
    DatabaseHelper _databaseHelper = DatabaseHelper();
    bool favorita = false;
    //Icon fav = Icon(Icons.favorite_border, color: Colors.red[700], size: 35);
    Icon fav = Icon(Icons.favorite_border, size: 35);

    return FutureBuilder(
      future: _databaseHelper.getFavorita(id),
      builder: (BuildContext context, AsyncSnapshot<FavoritaModel?> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Ocurrio un error en la petición'));
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            FavoritaModel? movFavorita = snapshot.data;
            if (movFavorita != null) {
              favorita = true;
              fav = Icon(Icons.favorite, color: Colors.red[700], size: 35);
            }
            return Stack(
              children: [
                ClipPath(
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${movie!.posterPath}',
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 1,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 150),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //TITULO
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    movie.title!.toUpperCase(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (favorita) {
                                        //elimina
                                        fav = Icon(Icons.favorite_border,
                                            size: 35);
                                        _databaseHelper
                                            .deleteFavorita(movie.id!)
                                            .then((noRows) {
                                          if (noRows > 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'El registro de ha eliminado')));
                                            setState(() {});
                                          }
                                        });
                                      } else {
                                        //agrega
                                        fav = Icon(Icons.favorite_border,
                                            color: Colors.red[700], size: 35);
                                        FavoritaModel favorita =
                                            new FavoritaModel(
                                                id: movie.id,
                                                title: movie.title,
                                                backdropPath:
                                                    movie.backdropPath);
                                        _databaseHelper
                                            .insertFavorita(favorita.toMap())
                                            .then((value) {
                                          if (value > 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Se agrego a tus favoritos')));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'La solicitud no se completo')));
                                          }
                                          setState(() {});
                                        });
                                      }
                                    },
                                    icon: fav)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              movie.overview!,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 190),
                            child: ElevatedButton(
                              onPressed: () async {
                                final youtubeUrl =
                                    'https://www.youtube.com/embed/${movie.trailerId}';
                                if (await canLaunch(youtubeUrl)) {
                                  await launch(youtubeUrl);
                                }
                              },
                              child: Row(
                                children: [
                                  Text('Ver Trailer'),
                                  Icon(Icons.play_arrow),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Casts'.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 110,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  VerticalDivider(
                                color: Colors.transparent,
                                width: 5,
                              ),
                              itemCount: movie.castList!.length,
                              itemBuilder: (context, index) {
                                Cast cast = movie.castList![index];
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        elevation: 3,
                                        child: ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: cast.profilePath != null
                                                ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
                                                : 'https://cdn2.iconfinder.com/data/icons/symbol-blue-set-3/100/Untitled-1-94-512.png',
                                            imageBuilder:
                                                (context, imageBuilder) {
                                              return Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                  image: DecorationImage(
                                                    image: imageBuilder,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                            placeholder: (context, url) =>
                                                Container(
                                              width: 80,
                                              height: 80,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assetsimg_not_found.jpg'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            cast.name!.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            cast.character!.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );

            //return _viewDetails(snapshot.data, context);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
