class ProductoBitacora {
  int idProductoBitacora;
  int idProducto;
  int idCategoria;
  String descProducto;
  double precio;
  String observacion;
  String lugarCompra;
  String imagen;

  bool estadoRegistro;
  String usuarioRegistro;
  DateTime fechaRegistro;
  String usuarioModificacion;
  DateTime fechaModificacion;

  ProductoBitacora(
      {this.idProductoBitacora,
      this.idProducto,
      this.idCategoria,
      this.descProducto,
      this.precio,
      this.observacion,
      this.lugarCompra,
      this.imagen,
      this.estadoRegistro,
      this.usuarioRegistro,
      this.fechaRegistro,
      this.usuarioModificacion,
      this.fechaModificacion});

  Map<String, dynamic> toMap() {
    return {
      'id_producto_bitacora': idProductoBitacora,
      'id_producto': idProducto,
      'id_categoria': idCategoria,
      'desc_producto': descProducto,
      'precio': precio,
      'observacion': observacion,
      'lugar_compra': lugarCompra,
      'imagen': imagen,
      'estado_registro': estadoRegistro,
      'usuario_registro': usuarioRegistro,
      'fecha_registro': fechaRegistro,
      'usuario_modificacion': usuarioModificacion,
      'fecha_modificacion': fechaModificacion
    };
  }

  ProductoBitacora.fromMap(Map<String, dynamic> map) {
    idProductoBitacora = map["id_producto_bitacora"];
    idProducto = map["id_producto"];
    idCategoria = map["id_categoria"];
    descProducto = map["desc_producto"];
    precio = map["precio"];
    observacion = map["observacion"];
    lugarCompra = map["lugarCompra"];
    imagen = map["imagen"];
    estadoRegistro = map["estado_registro"];
    usuarioRegistro = map["usuario_registro"];
    fechaRegistro = map["fecha_registro"];
    usuarioModificacion = map["usuario_modificacion"];
    fechaModificacion = map["fecha_modificacion"];
  }
}