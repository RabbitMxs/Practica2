import 'package:flutter/material.dart';
import 'package:practica2/src/models/dota_heroes.dart';
import 'package:practica2/src/network/api_dota.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/views/card_hero.dart';

class HeroScreen extends StatefulWidget {
  HeroScreen({Key? key}) : super(key: key);

  @override
  _HeroScreenState createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  ApiDota? apiDota;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiDota = ApiDota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Lista de heroes'),
      ),
      body: FutureBuilder(
        future: apiDota!.getAllHeroes(),
        builder: (BuildContext context,
            AsyncSnapshot<List<DotaHeroesModel>?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la petición'));
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              //return Center();
              return _listDotaHeroes(snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
      backgroundColor: Color.lerp(
          Color.fromRGBO(16, 20, 21, 1), Color.fromRGBO(37, 39, 40, 1), 1),
    );
  }

  Widget _listDotaHeroes(List<DotaHeroesModel>? heroes) {
    return ListView.separated(
      itemBuilder: (context, index) {
        DotaHeroesModel hero = heroes![index];
        return CardHeroView(hero: hero);
      },
      separatorBuilder: (_, __) => Divider(height: 10),
      itemCount: heroes!.length,
    );
  }
}
