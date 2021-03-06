import 'package:flutter/material.dart';
import 'package:practica2/src/screens/Intenciones_screen.dart';
import 'package:practica2/src/screens/agregar_nota_screen.dart';
import 'package:practica2/src/screens/heroes_screens/hero_details.dart';
import 'package:practica2/src/screens/heroes_screens/heroes_screen.dart';
import 'package:practica2/src/screens/movies_screens/detail_screen.dart';
import 'package:practica2/src/screens/movies_screens/favoritas_screen.dart';
import 'package:practica2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';
import 'package:practica2/src/screens/perfill_screen.dart';
import 'package:practica2/src/screens/splash_sreen.dart';
import 'package:practica2/src/screens/tareas_screens/agregar_tarea_screen.dart';
import 'package:practica2/src/screens/tareas_screens/tareas_completadas_screen.dart';
import 'package:practica2/src/screens/tareas_screens/tareas_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1': (BuildContext context) => Opcion1Screen(),
        '/intenciones': (BuildContext context) => IntencionesScreen(),
        '/notas': (BuildContext context) => NotasScreen(),
        '/agregar': (BuildContext context) => AgregarNotaScreen(),
        '/perfil': (BuildContext context) => PerfilScreen(),
        '/movie': (BuildContext context) => PopularScreen(),
        '/tareas': (BuildContext context) => TareasScreen(),
        '/agregartareas': (BuildContext context) => AgregarTareaScreen(),
        '/tareascompletadas': (BuildContext context) =>
            TareasCompletadasScreen(),
        '/details': (BuildContext context) => DetailScreen(),
        '/favoritas': (BuildContext context) => FavoritaScreen(),
        '/heroes': (BuildContext context) => HeroScreen(),
        '/detailheroe': (BuildContext context) => HeroDetails(),
      },
      debugShowCheckedModeBanner: false,
      home: SplashSreen(),
    );
  }
}
