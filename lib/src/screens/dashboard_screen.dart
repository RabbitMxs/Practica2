import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dasboard'),
        backgroundColor: ColorsSettings.colorPrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("ISC"),
              accountEmail: Text("17030830"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/man4-512.png'),

                //child: Image.network( )
              ),
              decoration: BoxDecoration(color: ColorsSettings.colorPrimary),
            ),
            ListTile(
              title: Text('Propinas'),
              subtitle: Text('Calcula la propina'),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/opc1');
              },
            ),
            ListTile(
              title: Text('Intenciones'),
              subtitle: Text('Intenciones implicitas'),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/intenciones');
              },
            ),
          ],
        ),
      ),
    );
  }
}
