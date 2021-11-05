import 'package:flutter/material.dart';
import 'package:practica2/src/models/dota_heroes.dart';

class CardHeroView extends StatefulWidget {
  final DotaHeroesModel hero;

  CardHeroView({Key? key, required this.hero}) : super(key: key);

  @override
  _CardHeroViewState createState() => _CardHeroViewState();
}

class _CardHeroViewState extends State<CardHeroView> {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Container(
        padding: EdgeInsets.only(left: 15),
        height: 60.0,
        color: Color.lerp(
            Color.fromRGBO(16, 20, 21, 1), Color.fromRGBO(37, 39, 40, 1), 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: ClipRRect(
                child: FadeInImage(
                  placeholder: AssetImage('assets/activity_indicator.gif'),
                  image: NetworkImage(
                      'https://api.opendota.com${widget.hero.icon}'),
                  fadeInDuration: Duration(milliseconds: 200),
                ),
              ),
            ),
            Text(
              widget.hero.localizedName.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/detailheroe',
                  arguments: widget.hero,
                ).whenComplete(() {
                  setState(() {});
                });
              },
              child: Icon(Icons.chevron_right, color: Colors.white),
            )
          ],
        ),
      ),
    ]);
  }
}
