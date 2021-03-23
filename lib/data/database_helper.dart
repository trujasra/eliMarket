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

  // Campos para las tablas Bitacora
  static const String ESTADO_REGISTRO = 'estado_registro';
  static const String USUARIO_REGISTRO = 'usuario_registro';
  static const String FECHA_REGISTRO = 'fecha_registro';
  static const String USUARIO_MODIFICACION = 'usuario_modificacion';
  static const String FECHA_MODIFICACION = 'fecha_modificacion';

  // Campos tabla  PAR_TIPO_CATEGORIA
  static const String ID_TIPO_CATEGORIA = 'id_tipo_categoria';
  static const String TIPO_CATEGORIA = 'tipo_categoria';

  // Campos tabla CATEGORIA
  static const String ID_CATEGORIA = 'id_categoria';
  static const String DESC_CATEGORIA = 'desc_categoria';
  static const String PAR_TIPO_CATEGORIA = 'par_tipo_categoria';
  static const String OBSERVACION = 'observacion';
  static const String IMAGEN = 'imagen';

  // Campos tabla PRODUCTO
  static const String ID_PRODUCTO = 'id_producto';
  static const String DESC_PRODUCTO = 'desc_producto';
  static const String PRECIO = 'precio';
  static const String LUGAR_COMPRA = 'lugar_compra';

  // Campos tabla PRODUCTO_BITACORA
  static const String ID_PRODUCTO_BITACORA = 'id_producto_bitacora';

  Future<Database> get database async {
    // Verifica si la BD es diferente de nulo
    if (_db != null) {
      return _db;
    }

    // envia al metodo para inicializar la BD
    _db = await iniciaDB();
    return _db;
  }

  iniciaDB() async {
    io.Directory documentoDirectorio = await getApplicationDocumentsDirectory();
    String path = join(documentoDirectorio.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    String sqlParTipoCategoria =
        "CREATE TABLE $TABLA_TIPO_CATEGORIA ($ID_TIPO_CATEGORIA INTEGER PRIMARY KEY AUTOINCREMENT, $TIPO_CATEGORIA TEXT, $ESTADO_REGISTRO BOOLEAN, $USUARIO_REGISTRO TEXT, $FECHA_REGISTRO DATETIME, $USUARIO_MODIFICACION TEXT, $FECHA_MODIFICACION DATETIME)";
    String sqlCategoria =
        "CREATE TABLE $TABLA_CATEGORIA ($ID_CATEGORIA INTEGER PRIMARY KEY AUTOINCREMENT, $DESC_CATEGORIA TEXT, $PAR_TIPO_CATEGORIA INTEGER, $OBSERVACION TEXT, $IMAGEN TEXT, $ESTADO_REGISTRO BOOLEAN, $USUARIO_REGISTRO TEXT, $FECHA_REGISTRO DATETIME, $USUARIO_MODIFICACION TEXT, $FECHA_MODIFICACION DATETIME)";
    String sqlProducto =
        "CREATE TABLE $TABLA_CATEGORIA ($ID_PRODUCTO INTEGER PRIMARY KEY AUTOINCREMENT, $ID_CATEGORIA INTEGER, $DESC_PRODUCTO TEXT, $PRECIO DOUBLE, $OBSERVACION TEXT, $LUGAR_COMPRA TEXT, $IMAGEN TEXT, $ESTADO_REGISTRO BOOLEAN, $USUARIO_REGISTRO TEXT, $FECHA_REGISTRO DATETIME, $USUARIO_MODIFICACION TEXT, $FECHA_MODIFICACION DATETIME)";
    String sqlProductoBitacora =
        "CREATE TABLE $TABLA_CATEGORIA ($ID_PRODUCTO_BITACORA INTEGER PRIMARY KEY AUTOINCREMENT, $ID_PRODUCTO INTEGER, $ID_CATEGORIA INTEGER, $DESC_PRODUCTO TEXT, $PRECIO DOUBLE, $OBSERVACION TEXT, $LUGAR_COMPRA TEXT, $IMAGEN TEXT, $ESTADO_REGISTRO BOOLEAN, $USUARIO_REGISTRO TEXT, $FECHA_REGISTRO DATETIME, $USUARIO_MODIFICACION TEXT, $FECHA_MODIFICACION DATETIME)";

    await db.execute(sqlParTipoCategoria);
    await db.execute(sqlCategoria);
    await db.execute(sqlProducto);
    await db.execute(sqlProductoBitacora);
  }

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
