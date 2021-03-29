import 'dart:io' as io;
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:eli_market/models/categoria.dart';

class DataBaseHelper {
  static final DataBaseHelper db = DataBaseHelper._();
  static Database _database;

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

  DataBaseHelper._();

  Future<Database> get database async {
    // Verifica si la BD es diferente de nulo
    if (_database != null) {
      return _database;
    }

    // envia al metodo para inicializar la BD
    _database = await iniciaDB();
    return _database;
  }

  iniciaDB() async {
    io.Directory documentoDirectorio = await getApplicationDocumentsDirectory();
    String path = join(documentoDirectorio.path, DB_NAME);

    // Delete the database //TODO: esto luego borrar
    await deleteDatabase(path);

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    String sqlParTipoCategoria =
        "CREATE TABLE $TABLA_TIPO_CATEGORIA ($ID_TIPO_CATEGORIA INTEGER PRIMARY KEY, $TIPO_CATEGORIA TEXT, $ESTADO_REGISTRO BOOLEAN, $USUARIO_REGISTRO TEXT, $FECHA_REGISTRO DATETIME, $USUARIO_MODIFICACION TEXT, $FECHA_MODIFICACION DATETIME)";
    String sqlCategoria =
        "CREATE TABLE $TABLA_CATEGORIA ($ID_CATEGORIA INTEGER PRIMARY KEY AUTOINCREMENT, $DESC_CATEGORIA TEXT, $PAR_TIPO_CATEGORIA INTEGER, $OBSERVACION TEXT, $IMAGEN TEXT, $ESTADO_REGISTRO BOOLEAN, $USUARIO_REGISTRO TEXT, $FECHA_REGISTRO DATETIME, $USUARIO_MODIFICACION TEXT, $FECHA_MODIFICACION DATETIME)";
    String sqlProducto =
        "CREATE TABLE $TABLA_PRODUCTO ($ID_PRODUCTO INTEGER PRIMARY KEY AUTOINCREMENT, $ID_CATEGORIA INTEGER, $DESC_PRODUCTO TEXT, $PRECIO DOUBLE, $OBSERVACION TEXT, $LUGAR_COMPRA TEXT, $IMAGEN TEXT, $ESTADO_REGISTRO BOOLEAN, $USUARIO_REGISTRO TEXT, $FECHA_REGISTRO DATETIME, $USUARIO_MODIFICACION TEXT, $FECHA_MODIFICACION DATETIME)";
    String sqlProductoBitacora =
        "CREATE TABLE $TABLA_PRODUCTO_BITACORA ($ID_PRODUCTO_BITACORA INTEGER PRIMARY KEY AUTOINCREMENT, $ID_PRODUCTO INTEGER, $ID_CATEGORIA INTEGER, $DESC_PRODUCTO TEXT, $PRECIO DOUBLE, $OBSERVACION TEXT, $LUGAR_COMPRA TEXT, $IMAGEN TEXT, $ESTADO_REGISTRO BOOLEAN, $USUARIO_REGISTRO TEXT, $FECHA_REGISTRO DATETIME, $USUARIO_MODIFICACION TEXT, $FECHA_MODIFICACION DATETIME)";

    // Crea las tablas de la BD
    await db.execute(sqlParTipoCategoria);
    await db.execute(sqlCategoria);
    await db.execute(sqlProducto);
    await db.execute(sqlProductoBitacora);

    // Insertar por defecto los tipo de categoria
    await db.execute(
        "INSERT INTO $TABLA_TIPO_CATEGORIA($ID_TIPO_CATEGORIA, $TIPO_CATEGORIA,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?)",
        [
          1,
          "Verduras y hortalizas",
          true,
          "ramiro.trujillo",
          "2021-03-26 15:00:00"
        ]);
    await db.execute(
        "INSERT INTO $TABLA_TIPO_CATEGORIA($ID_TIPO_CATEGORIA,$TIPO_CATEGORIA,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?)",
        [2, "Frutas", true, "ramiro.trujillo", "2021-03-26 15:01:00"]);
    await db.execute(
        "INSERT INTO $TABLA_TIPO_CATEGORIA($ID_TIPO_CATEGORIA,$TIPO_CATEGORIA,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?)",
        [
          3,
          "Refrescos y bebidas",
          true,
          "ramiro.trujillo",
          "2021-03-26 15:02:00"
        ]);
    await db.execute(
        "INSERT INTO $TABLA_TIPO_CATEGORIA($ID_TIPO_CATEGORIA,$TIPO_CATEGORIA,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?)",
        [4, "Carnes y pollos", true, "ramiro.trujillo", "2021-03-26 15:03:00"]);
    await db.execute(
        "INSERT INTO $TABLA_TIPO_CATEGORIA($ID_TIPO_CATEGORIA,$TIPO_CATEGORIA,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?)",
        [5, "Limpieza", true, "ramiro.trujillo", "2021-03-26 15:04:00"]);
    await db.execute(
        "INSERT INTO $TABLA_TIPO_CATEGORIA($ID_TIPO_CATEGORIA,$TIPO_CATEGORIA,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?)",
        [6, "Otros", true, "ramiro.trujillo", "2021-03-26 15:05:00"]);

    // Crea por defecto registros para la tabla categoria
    await db.execute(
        "INSERT INTO $TABLA_CATEGORIA($DESC_CATEGORIA,$PAR_TIPO_CATEGORIA,$OBSERVACION,$IMAGEN,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?,?,?)",
        [
          "Verduras y hortalizas",
          1,
          "Datos para el regsitro de verduras y hortalizas",
          "assets/imagenes/verduras.png",
          true,
          "ramiro.trujillo",
          "2021-03-26 16:00:00"
        ]);
    await db.execute(
        "INSERT INTO $TABLA_CATEGORIA($DESC_CATEGORIA,$PAR_TIPO_CATEGORIA,$OBSERVACION,$IMAGEN,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?,?,?)",
        [
          "Frutas",
          2,
          "Datos para el registro de frutas",
          "assets/imagenes/frutas.png",
          true,
          "ramiro.trujillo",
          "2021-03-26 16:01:00"
        ]);
    await db.execute(
        "INSERT INTO $TABLA_CATEGORIA($DESC_CATEGORIA,$PAR_TIPO_CATEGORIA,$OBSERVACION,$IMAGEN,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?,?,?)",
        [
          "Refrescos y bebidas",
          3,
          "Datos para el registro de refrescos y bebidas",
          "assets/imagenes/refrescos.png",
          true,
          "ramiro.trujillo",
          "2021-03-26 16:02:00"
        ]);
    await db.execute(
        "INSERT INTO $TABLA_CATEGORIA($DESC_CATEGORIA,$PAR_TIPO_CATEGORIA,$OBSERVACION,$IMAGEN,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?,?,?)",
        [
          "Carnes y pollos",
          4,
          "Datos para el registro de carnes y pollos",
          "assets/imagenes/carnes.png",
          true,
          "ramiro.trujillo",
          "2021-03-26 16:03:00"
        ]);
    await db.execute(
        "INSERT INTO $TABLA_CATEGORIA($DESC_CATEGORIA,$PAR_TIPO_CATEGORIA,$OBSERVACION,$IMAGEN,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?,?,?)",
        [
          "Limpieza",
          5,
          "Datos para el registro de limpieza",
          "assets/imagenes/limpieza.png",
          true,
          "ramiro.trujillo",
          "2021-03-26 16:03:00"
        ]);
    await db.execute(
        "INSERT INTO $TABLA_CATEGORIA($DESC_CATEGORIA,$PAR_TIPO_CATEGORIA,$OBSERVACION,$IMAGEN,$ESTADO_REGISTRO,$USUARIO_REGISTRO,$FECHA_REGISTRO) VALUES(?,?,?,?,?,?,?)",
        [
          "Otros y más...",
          6,
          "Datos para el registro de otros",
          "assets/imagenes/otros_mas.png",
          true,
          "ramiro.trujillo",
          "2021-03-26 16:04:00"
        ]);
  }

  Future<List<Categoria>> obtieneCategoria() async {
    var dbClient = await database;
    // List<Map> maps = await dbClient.query(TABLA_CATEGORIA, columns: [ID, NAME, LAST_NAME]);
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLA_CATEGORIA");
    List<Categoria> listaCategoria = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        listaCategoria.add(Categoria.fromMap(maps[i]));
      }
    }
    return listaCategoria;
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
