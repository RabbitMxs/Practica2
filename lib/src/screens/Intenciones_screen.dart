import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Intenciones Implicitas"),
          backgroundColor: ColorsSettings.colorPrimary),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text("Abrir Pagiba Web"),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app,
                    size: 18,
                    color: Colors.green,
                  ),
                  Text("https:://celaya/tecnm.mx?"),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 20.0),
                height: 40.0,
                child: Icon(
                  Icons.language,
                  color: ColorsSettings.colorPrimary,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _abrirWeb,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text("Llamada Telefonica"),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app,
                    size: 18,
                    color: Colors.green,
                  ),
                  Text("Cel.411 155 2093"),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 20.0),
                height: 40.0,
                child: Icon(
                  Icons.phone_android,
                  color: ColorsSettings.colorPrimary,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _llamadaTelefonica,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text("Enviar SMS"),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app,
                    size: 18,
                    color: Colors.green,
                  ),
                  Text("Cel.4111039104"),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 20.0),
                height: 40.0,
                child: Icon(
                  Icons.sms_sharp,
                  color: ColorsSettings.colorPrimary,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarSMS,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text("Enviar Email"),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app,
                    size: 18,
                    color: Colors.green,
                  ),
                  Text("To: 17030830@itcelaya.edu.mx"),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 20.0),
                height: 40.0,
                child: Icon(
                  Icons.email_outlined,
                  color: ColorsSettings.colorPrimary,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarEmail,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text("Tomar Foto"),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app,
                    size: 18,
                    color: Colors.green,
                  ),
                  Text("Sonrie"),
                ],
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 20.0),
                height: 40.0,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: ColorsSettings.colorPrimary,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }

  _abrirWeb() async {
    const url = 'https://celaya.tecnm.mx?';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _llamadaTelefonica() async {
    const url = 'tel:4111552093';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarSMS() async {
    const url = 'sms:4111552093';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarEmail() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: '17030830@itcelaya.edu.mx',
        query: 'subject=Saludo&body=Bienvenido :)');
    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    }
  }

  _tomarFoto() {}
}
