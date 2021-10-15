import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/tareas_screens/agregar_tarea_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class TareasCompletadasScreen extends StatefulWidget {
  TareasCompletadasScreen({Key? key}) : super(key: key);

  @override
  _TareasCompletadasScreenState createState() =>
      _TareasCompletadasScreenState();
}

class _TareasCompletadasScreenState extends State<TareasCompletadasScreen> {
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Tareas Completadas'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllTareasCompletas(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TareasModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrio un error en la petición'));
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              //return Center();
              return _listadoNotas(snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  Widget _listadoNotas(List<TareasModel> tareas) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          TareasModel tarea = tareas[index];
          return Dismissible(
              key: Key(tarea.id.toString()),
              onDismissed: (DismissDirection dir) {
                if (dir == DismissDirection.startToEnd) {
                  //eliminar
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Confirmación'),
                          content: Text('¿Estas seguro de borrar la tarea?'),
                          actions: [
                            TextButton(
                                //Si
                                onPressed: () {
                                  Navigator.pop(context);
                                  _databaseHelper
                                      .deleteTarea(tarea.id!)
                                      .then((noRows) {
                                    if (noRows > 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'La tarea se ha eliminado')));
                                      setState(() {});
                                    }
                                  });
                                },
                                child: Text('Sí')),
                            TextButton(
                                //No
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No')),
                          ],
                        );
                      }).then((value) {
                    setState(() {});
                  });
                } else {
                  //modifica
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgregarTareaScreen(
                          tarea: tarea,
                          estado: 1,
                        ),
                      )).then((value) {
                    setState(() {});
                  });
                }
              },
              // Show a red background as the item is swiped away
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.delete),
              ),
              // Background when swipping from right to left
              secondaryBackground: Container(
                color: Colors.blueAccent,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.edit),
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  Center(
                    child: Text(
                      tarea.nomTarea!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(child: Text(tarea.dscTarea!)),
                  Center(
                    child: Text(DateFormat.yMd()
                        .add_jm()
                        .format(DateTime.parse(tarea.fechaEntrega!))),
                  ),
                  IconButton(
                    // Completar
                    onPressed: () {
                      tarea.entregada = 0;
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirmación'),
                              content: Text(
                                  '¿Estas seguro de desmarcar la tarea como completada?'),
                              actions: [
                                TextButton(
                                    //Si
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _databaseHelper
                                          .updateTarea(tarea.toMap())
                                          .then((noRows) {
                                        if (noRows > 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'La tarea se desmarco')));
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Text('Sí')),
                                TextButton(
                                    //No
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                              ],
                            );
                          }).then((value) {
                        setState(() {});
                      });
                    },
                    icon: Icon(Icons.task_alt),
                    iconSize: 18,
                  ),
                ]),
              ));
        },
        itemCount: tareas.length,
      ),
    );
  }
}
