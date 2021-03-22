import 'dart:io' as io;
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static Database _db;

  // Constante tabla  PAR_CATEGORIA
  static const String ID_CATEGORIA = 'id_par_categoria';
  static const String NAME = 'nombre';
  static const String LAST_NAME = 'apellidos';
  static const String TABLE = 'Persona';
  static const String DB_NAME = 'db_persona.db';
}
