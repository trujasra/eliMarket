import 'dart:io' as io;
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static Database _db;
  // Datos de la Base de datos
  static const String DB_NAME = 'db_mercado.db';
  // Datos de las tablas
  static const String TABLA_TIPO_CATEGORIA = 'Par_tipo_categoria';
  static const String TABLA_CATEGORIA = 'Categoria';
  static const String TABLA_PRODUCTO = 'Producto';
  static const String TABLA_PRODUCTO_BITACORA = 'Producto_bitacora';

  // Constante tabla  PAR_CATEGORIA
  static const String ID_CATEGORIA = 'id_par_categoria';
  static const String NAME = 'nombre';
  static const String LAST_NAME = 'apellidos';

  // Future<Database> get dbase async {
  //   // Verifica si la BD es diferente de nulo
  //   if (_db != null) {
  //     return _db;
  //   }

  //   // envia al metodo para inicializar la BD
  //   _db = await iniciaDB();
  //   return _db;
  // }

  // iniciaDB() async {
  //   io.Directory documentoDirectorio = await getApplicationDocumentsDirectory();
  //   String path = join(documentoDirectorio.path, DB_NAME);
  //   var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  //   return db;
  // }

  // FutureOr<void> _onCreate(Database db, int version) async {
  //   String sql =
  //       "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT, $LAST_NAME TEXT)";
  //   await db.execute(sql);
  // }

  // Future<Persona> registraPersona(Persona persona) async {
  //   var dbCliente = await dbase;
  //   persona.id = await dbCliente.insert(TABLE, persona.toMap());
  //   return persona;

  //   /*await dbClient.transaction((txn) {
  //     var query = "INSERT INTO $TABLE($NAME, $LAST_NAME) VALUES('" +
  //         persona.nombre +
  //         "','" +
  //         persona.apellidos +
  //         "')";
  //     return txn.rawQuery(query);
  //   });*/
  // }

  // Future<List<Persona>> obtienePersona() async {
  //   var dbClient = await dbase;
  //   List<Map> maps =
  //       await dbClient.query(TABLE, columns: [ID, NAME, LAST_NAME]);
  //   // List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
  //   List<Persona> listaPersona = [];
  //   if (maps.length > 0) {
  //     for (int i = 0; i < maps.length; i++) {
  //       listaPersona.add(Persona.fromMap(maps[i]));
  //     }
  //   }
  //   return listaPersona;
  // }

  // Future<int> eliminaPersona(int id) async {
  //   var dbCliente = await dbase;
  //   return await dbCliente.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  // }

  // Future<int> actualizaPersona(Persona persona) async {
  //   var dbCliente = await dbase;
  //   return await dbCliente.update(TABLE, persona.toMap(),
  //       where: '$ID = ?', whereArgs: [persona.id]);
  // }

  // Future close() async {
  //   var dbCliente = await dbase;
  //   dbCliente.close();
  // }

}
