import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/utils/utility.dart';

class PerfilScreen extends StatefulWidget {
  PerfilScreen({Key? key}) : super(key: key);

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  //formulario
  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerApellidoP = TextEditingController();
  TextEditingController _controllerApellidoM = TextEditingController();
  TextEditingController _controllerTel = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  bool _validateNombre = false;
  bool _validateApellidoP = false;
  bool _validateApellidoM = false;
  bool _validateTel = false;
  bool _validateEmail = false;

  //base de datos
  late DatabaseHelper _databaseHelper;
  //imagen
  String? _imagen = null;
  //Objeto
  PerfilModel? perfiles;

  //lanzar camara
  void _getImageCamera() async {
    final imgFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 400.0,
      maxHeight: 400.0,
    );

    setState(() {
      if (imgFile == null) return;
      final imagenTemporal = File(imgFile.path);
      _imagen = Utility.base64String(imagenTemporal.readAsBytesSync());
    });
  }

  //lanzar galeria
  void _getImageGalerry() async {
    final imgFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 400.0,
      maxHeight: 400.0,
    );
    setState(() {
      if (imgFile == null) return;
      final imagenTemporal = File(imgFile.path);
      _imagen = Utility.base64String(imagenTemporal.readAsBytesSync());
    });
  }

  @override
  void initState() {
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Editar Perfil'),
      ),
      body:
          //Editar
          FutureBuilder(
        future: _databaseHelper.getAllProfiles(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PerfilModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la petición'));
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _view(snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),

      //AGREGAR
      /*Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  child: _imagen == null
                      ? Text('no hay imagen')
                      : Image.file(_imagen!),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _getImageCamera();
                          },
                          child: Text('Tomar foto')),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            _getImageGalerry();
                          },
                          child: Text('Selecciona foto'))
                    ],
                  ),
                ),
                SizedBox(height: 10),
                _crearTextFieldNombre(),
                SizedBox(height: 10),
                _crearTextFieldApellidoP(),
                SizedBox(height: 10),
                _crearTextFieldApellidoM(),
                SizedBox(height: 10),
                _crearTextFieldTel(),
                SizedBox(height: 10),
                _crearTextFieldEmail(),
                SizedBox(height: 40),
                SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      child: Text('Guardar'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          PerfilModel perfil = PerfilModel(
                              avatar: _imagen,
                              nombre: _controllerNombre.text,
                              apellidoP: _controllerApellidoP.text,
                              apellidoM: _controllerApellidoM.text,
                              tel: _controllerTel.text,
                              email: _controllerEmail.text);
                          _databaseHelper.insertProfile(perfil);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'El perfil se almaceno correctamente')),
                          );
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),*/
    );
  }

  Widget _view(List<PerfilModel> perfiles) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          PerfilModel perfil = perfiles[0];
          //_formKeys.add(GlobalKey<FormState>());
          _controllerNombre.text = perfil.nombre!;
          _controllerApellidoP.text = perfil.apellidoP!;
          _controllerApellidoM.text = perfil.apellidoM!;
          _controllerTel.text = perfil.tel!;
          _controllerEmail.text = perfil.email!;
          String foto;
          if (_imagen == null) {
            foto = perfil.avatar!;
          } else {
            foto = _imagen!;
          }
          return Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              //key: _formKeys[_formKeys.length - 1],
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                      child: foto == null
                          ? Text('No hay foto')
                          : Image.memory(
                              base64Decode(foto),
                              fit: BoxFit.fill,
                            )),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _getImageCamera();
                            },
                            child: Text('Tomar foto')),
                        SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: () {
                              _getImageGalerry();
                            },
                            child: Text('Selecciona foto'))
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  _crearTextFieldNombre(),
                  SizedBox(height: 10),
                  _crearTextFieldApellidoP(),
                  SizedBox(height: 10),
                  _crearTextFieldApellidoM(),
                  SizedBox(height: 10),
                  _crearTextFieldTel(),
                  SizedBox(height: 10),
                  _crearTextFieldEmail(),
                  SizedBox(height: 40),
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        child: Text('Guardar'),
                        onPressed: () {
                          setState(() {
                            _controllerNombre.text.isEmpty
                                ? _validateNombre = true
                                : _validateNombre = false;
                            _controllerApellidoP.text.isEmpty
                                ? _validateApellidoP = true
                                : _validateApellidoP = false;
                            _controllerApellidoM.text.isEmpty
                                ? _validateApellidoM = true
                                : _validateApellidoM = false;
                            _controllerTel.text.isEmpty
                                ? _validateTel = true
                                : _validateTel = false;
                            _controllerEmail.text.isEmpty
                                ? _validateEmail = true
                                : _validateEmail = false;

                            if (_validateNombre == false &&
                                _validateApellidoP == false &&
                                _validateApellidoM == false &&
                                _validateTel == false &&
                                _validateEmail == false) {
                              PerfilModel objeto = PerfilModel(
                                id: perfil.id,
                                avatar: foto,
                                nombre: _controllerNombre.text,
                                apellidoP: _controllerApellidoP.text,
                                apellidoM: _controllerApellidoM.text,
                                tel: _controllerTel.text,
                                email: _controllerEmail.text,
                              );

                              _databaseHelper
                                  .updateProfile(objeto.toMap())
                                  .then((value) {
                                if (value > 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Los datos se actualizaron correctamente')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'La solicitud no se completo')));
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('La solicitud no se completo')));
                            }
                          });
                        },
                      )),
                ],
              ),
            ),
          );
        },
        itemCount: perfiles.length,
      ),
    );
  }

  Widget _crearTextFieldNombre() {
    return TextField(
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Nombre del alumno",
          errorText: _validateNombre ? 'Este campo es obligatorio' : null),
      controller: _controllerNombre,
    );
  }

  Widget _crearTextFieldApellidoP() {
    return TextField(
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Apellido Paterno",
          errorText: _validateApellidoP ? 'Este campo es obligatorio' : null),
      controller: _controllerApellidoP,
    );
  }

  Widget _crearTextFieldApellidoM() {
    return TextField(
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Apellido Materno",
          errorText: _validateApellidoM ? 'Este campo es obligatorio' : null),
      controller: _controllerApellidoM,
    );
  }

  Widget _crearTextFieldTel() {
    return TextField(
      autocorrect: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Telefono",
          errorText: _validateTel ? 'Este campo es obligatorio' : null),
      controller: _controllerTel,
    );
  }

  Widget _crearTextFieldEmail() {
    return TextField(
      autocorrect: true,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Correo Electronico",
          errorText: _validateEmail ? 'Este campo es obligatorio' : null),
      controller: _controllerEmail,
    );
  }
}
