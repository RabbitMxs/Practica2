import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _nombreBD = "NOTASDB";
  static final _versionBD = 9;
  static final _nombreTBL = "tblNotas";
  static final _nombreTBL2 = "tblPerfiles";
  static final _nombreTBLTareas = "tblTareas";

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    {
      _database = await _initDatabase();
      return _database;
    }
  }

  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nombreBD);
    return openDatabase(rutaDB,
        version: _versionBD, onCreate: _crearTabla, onUpgrade: _onUpgrade);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    db.execute('DROP TABLE $_nombreTBLTareas');
    db.execute(
        "Create table $_nombreTBLTareas (id INTEGER PRIMARY KEY, nomTarea VARCHAR(100), dscTarea VARCHAR(255), fechaEntrega datetime, entregada boolean)");
  }

  Future<void> _crearTabla(Database db, int version) async {
    await db.execute(
        "Create table $_nombreTBL (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))");
    await db.execute(
        "Create table $_nombreTBL2 (id INTEGER PRIMARY KEY, avatar TEXT, nombre VARCHAR(50), apellidoP VARCHAR(50), apellidoM VARCHAR(50), tel VARCHAR(10), email VARCHAR(50))");
    await db.execute(
        "Create table $_nombreTBLTareas (id INTEGER PRIMARY KEY, nomTarea VARCHAR(100), dscTarea VARCHAR(255), fechaEntrega datetime, entregada boolean)");
  }

  //CRUD NOTAS
  Future<int> insert(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_nombreTBL, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nombreTBL, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var conexion = await database;
    return await conexion!.delete(_nombreTBL, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<NotasModel>> getAllNotes() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result.map((notaMap) => NotasModel.fromMap(notaMap)).toList();
  }

  Future<NotasModel> getNote(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nombreTBL, where: 'id = ? ', whereArgs: [id]);
    return NotasModel.fromMap(result.first);
  }

  //CRUD PERFIL
  Future<int> insertProfile(PerfilModel perfil) async {
    var conexion = await database;
    return conexion!.insert(_nombreTBL2, perfil.toMap());
  }

  Future<List<PerfilModel>> getAllProfiles() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL2);
    return result.map((perfilMap) => PerfilModel.fromMap(perfilMap)).toList();
  }

  Future<int> updateProfile(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nombreTBL2, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  //CRUD TAREAS
  Future<int> insertTarea(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_nombreTBLTareas, row);
  }

  Future<int> updateTarea(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nombreTBLTareas, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> deleteTarea(int id) async {
    var conexion = await database;
    return await conexion!
        .delete(_nombreTBLTareas, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TareasModel>> getAllTareas() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBLTareas);
    return result.map((tareaMap) => TareasModel.fromMap(tareaMap)).toList();
  }

  Future<List<TareasModel>> getAllTareasIncompletas() async {
    var conexion = await database;
    var result = await conexion!
        .query(_nombreTBLTareas, where: 'entregada = ? ', whereArgs: [0]);
    return result.map((tareaMap) => TareasModel.fromMap(tareaMap)).toList();
  }

  Future<List<TareasModel>> getAllTareasCompletas() async {
    var conexion = await database;
    var result = await conexion!
        .query(_nombreTBLTareas, where: 'entregada = ? ', whereArgs: [1]);
    return result.map((tareaMap) => TareasModel.fromMap(tareaMap)).toList();
  }

  Future<TareasModel> getTarea(int id) async {
    var conexion = await database;
    var result = await conexion!
        .query(_nombreTBLTareas, where: 'id = ? ', whereArgs: [id]);
    return TareasModel.fromMap(result.first);
  }
}
