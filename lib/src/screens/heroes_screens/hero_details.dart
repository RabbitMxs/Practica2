import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/dota_heroes.dart';
import 'package:practica2/src/utils/color_settings.dart';

class HeroDetails extends StatefulWidget {
  HeroDetails({Key? key}) : super(key: key);

  @override
  _HeroDetailsState createState() => _HeroDetailsState();
}

class _HeroDetailsState extends State<HeroDetails> {
  @override
  Widget build(BuildContext context) {
    String primary_attr_icon;
    DotaHeroesModel hero =
        ModalRoute.of(context)!.settings.arguments as DotaHeroesModel;

    if (hero.primaryAttr == 'str') {
      primary_attr_icon = 'assets/hero_strength.png';
    } else {
      if (hero.primaryAttr == 'agi') {
        primary_attr_icon = 'assets/hero_agility.png';
      } else {
        primary_attr_icon = 'assets/hero_intelligence.png';
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 1,
          title: Row(
            children: [
              Container(
                child: Image.asset(primary_attr_icon),
                width: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(hero.localizedName.toString()),
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipPath(
                  child: ClipRRect(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/activity_indicator.gif'),
                      image:
                          NetworkImage('https://api.opendota.com${hero.img}'),
                      fadeInDuration: Duration(milliseconds: 200),
                      width: double.infinity,
                      height: 202,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  //health
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment(-0.8, 0.9),
                      colors: <Color>[
                        Color.fromRGBO(122, 250, 60, 1),
                        Color.fromRGBO(40, 99, 35, 1),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height / 18,
                      ),
                      Text(
                        hero.baseHealth.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        "+${hero.baseHealthRegen.toString()}",
                        style: TextStyle(
                            color: Color.fromRGBO(40, 99, 35, 1),
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  //mana
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment(-0.8, 0.9),
                      colors: <Color>[
                        Color.fromRGBO(115, 245, 254, 1),
                        Color.fromRGBO(16, 86, 219, 1),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height / 25,
                      ),
                      Text(
                        hero.baseMana.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        "+${hero.baseManaRegen.toString()}",
                        style: TextStyle(
                            color: Color.fromRGBO(40, 99, 35, 1),
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //mana
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(15),

                  child: Column(
                    children: [
                      Text(
                        "ATRIBUTOS  ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Image.asset('assets/hero_strength.png'),
                                  Text(
                                    hero.baseStr.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '+${hero.strGain.toString()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset('assets/hero_agility.png'),
                                  Text(
                                    hero.baseAgi.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '+${hero.agiGain.toString()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset('assets/hero_intelligence.png'),
                                  Text(
                                    hero.baseInt.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '+${hero.intGain.toString()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "ESTADÍSTICAS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Ataque",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            'assets/icon_damage.png'),
                                        width: 20,
                                      ),
                                      Text(
                                        "  ${hero.baseAttackMin} - ${hero.baseAttackMax}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            'assets/icon_attack_time.png'),
                                        width: 20,
                                      ),
                                      Text(
                                        "  ${hero.attackRate}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            'assets/icon_attack_range.png'),
                                        width: 20,
                                      ),
                                      Text(
                                        "  ${hero.attackRange}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            'assets/icon_projectile_speed.png'),
                                        width: 20,
                                      ),
                                      Text(
                                        "  ${hero.projectileSpeed}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Defensa",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            'assets/icon_armor.png'),
                                        width: 20,
                                      ),
                                      Text(
                                        "  ${hero.baseArmor}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            'assets/icon_magic_resist.png'),
                                        width: 20,
                                      ),
                                      Text(
                                        "  ${hero.baseMr}%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Movilidad",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            'assets/icon_movement_speed.png'),
                                        width: 20,
                                      ),
                                      Text(
                                        "  ${hero.moveSpeed}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        backgroundColor: Color.lerp(
            Color.fromRGBO(16, 20, 21, 1), Color.fromRGBO(37, 39, 40, 1), 1));
  }
}
