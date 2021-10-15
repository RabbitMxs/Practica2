import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class AgregarTareaScreen extends StatefulWidget {
  TareasModel? tarea;
  int? estado;
  AgregarTareaScreen({Key? key, this.estado, this.tarea}) : super(key: key);

  @override
  _AgregarTareaScreenState createState() => _AgregarTareaScreenState();
}

class _AgregarTareaScreenState extends State<AgregarTareaScreen> {
  String _enteredName = '';
  String _enteredDescription = '';

  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerDetalle = TextEditingController();
  bool _validateNombre = false;
  bool _validateDetalle = false;
  bool _validateLonNombre = false;
  bool _validateLonDetalle = false;
  DateTime? _dateTime;

  //base de datos
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    if (widget.tarea != null) {
      _controllerNombre.text = widget.tarea!.nomTarea!;
      _controllerDetalle.text = widget.tarea!.dscTarea!;
      _dateTime = DateTime.parse(widget.tarea!.fechaEntrega!);
    }
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorsSettings.colorPrimary,
          title: widget.tarea == null
              ? Text('Agregar Tarea')
              : Text('Editar Tarea')),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              _crearTextFieldNombre(),
              SizedBox(height: 10),
              _crearTextFieldDetalle(),
              SizedBox(height: 40),
              SizedBox(
                  child: Column(
                children: [
                  Text(
                    _dateTime == null
                        ? "La fecha que se establecerá por default es la fecha actual"
                        : DateFormat.yMd().add_jm().format(_dateTime!),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      child: Text("Selecciona una fecha"),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: _dateTime == null
                                    ? DateTime.now()
                                    : _dateTime!,
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2222))
                            .then((date) {
                          _dateTime = date;
                          setState(() {});
                        });
                      })
                ],
              )),
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
                        _controllerDetalle.text.isEmpty
                            ? _validateDetalle = true
                            : _validateDetalle = false;
                        _enteredName.length > 100
                            ? _validateLonNombre = true
                            : _validateLonNombre = false;
                        _enteredDescription.length > 255
                            ? _validateLonDetalle = true
                            : _validateLonDetalle = false;

                        if (_validateNombre == false &&
                            _validateDetalle == false &&
                            _validateLonNombre == false &&
                            _validateLonDetalle == false) {
                          if (_dateTime == null) {
                            _dateTime = DateTime.now();
                          }

                          if (widget.tarea == null) {
                            //insertar
                            TareasModel tarea = TareasModel(
                                nomTarea: _controllerNombre.text,
                                dscTarea: _controllerDetalle.text,
                                fechaEntrega: _dateTime?.toIso8601String(),
                                entregada: 0);

                            _databaseHelper
                                .insertTarea(tarea.toMap())
                                .then((value) {
                              if (value > 0) {
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'La solicitud no se completo')));
                              }
                            });
                          } else {
                            //editar
                            TareasModel tarea = TareasModel(
                                id: widget.tarea!.id,
                                nomTarea: _controllerNombre.text,
                                dscTarea: _controllerDetalle.text,
                                fechaEntrega: _dateTime?.toIso8601String(),
                                entregada: widget.estado);

                            _databaseHelper
                                .updateTarea(tarea.toMap())
                                .then((value) {
                              if (value > 0) {
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'La solicitud no se completo')));
                              }
                            });
                          }
                        }
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearTextFieldNombre() {
    return TextField(
      autocorrect: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          counterText: '${_enteredName.length.toString()} /100 character(s)',
          labelText: "Nombre de la tarea",
          errorText: _validateNombre ? 'Este campo es obligatorio' : null),
      controller: _controllerNombre,
      onChanged: (value) {
        setState(() {
          _enteredName = value;
        });
      },
    );
  }

  Widget _crearTextFieldDetalle() {
    return TextField(
      autocorrect: true,
      keyboardType: TextInputType.text,
      maxLines: 10,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          counterText:
              '${_enteredDescription.length.toString()} /255 character(s)',
          labelText: "Detalle de la tarea",
          errorText: _validateDetalle ? 'Este campo es obligatorio' : null),
      controller: _controllerDetalle,
      onChanged: (value) {
        setState(() {
          _enteredDescription = value;
        });
      },
    );
  }
}
