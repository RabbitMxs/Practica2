import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/dota_heroes.dart';

class ApiDota {
  var URL = Uri.parse('https://api.opendota.com/api/heroStats');

  Future<List<DotaHeroesModel>?> getAllHeroes() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var heroes = jsonDecode(response.body) as List;

      List<DotaHeroesModel> listHeroes =
          heroes.map((hero) => DotaHeroesModel.fromMap(hero)).toList();

      listHeroes = listHeroes.sublist(1, 121);
      return listHeroes;
    } else {
      return null;
    }
  }
}
