import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class Opcion1Screen extends StatefulWidget {
  Opcion1Screen({Key? key}) : super(key: key);

  @override
  _Opcion1ScreenState createState() => _Opcion1ScreenState();
}

class _Opcion1ScreenState extends State<Opcion1Screen> {
  double subtotal = 0;
  double propina = 0;
  double total = 0;
  TextEditingController txtTotalCon = TextEditingController();

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cuenta"),
      content: Text(
          "El subtotal es $subtotal\nLa propina es de $propina\nEl total es $total"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TextFormField txtTotal = TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: new BorderSide(color: ColorsSettings.colorPrimary),
          ),
          icon: Icon(
            Icons.monetization_on_outlined,
            color: ColorsSettings.colorPrimary,
          ),
          labelText: 'Total del consumo',
          labelStyle: TextStyle(color: ColorsSettings.colorPrimary),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
      controller: txtTotalCon,
    );

    ElevatedButton btnLogin = ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ColorsSettings.colorPrimary),
        onPressed: () {
          if (txtTotalCon.text != '') {
            subtotal = double.parse(txtTotalCon.text);
            propina = subtotal * .16;
            total = subtotal + propina;
            showAlertDialog(context);
            setState(() {});
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.login), Text('Calcular propina')],
        ));

    return Scaffold(
      appBar: AppBar(
        //title: Text('Calcula las propinas'),
        backgroundColor: ColorsSettings.colorPrimary,
      ),
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              txtTotal,
              SizedBox(height: 10),
              btnLogin,
              SizedBox(height: 50),
            ],
          ),
        ),
        margin: EdgeInsets.only(left: 15, right: 15),
      ),
    );
  }
}
