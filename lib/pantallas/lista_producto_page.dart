import 'dart:io';

import 'package:eli_market/models/producto.dart';
import 'package:eli_market/pantallas/registro_producto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constantes.dart';
import 'package:eli_market/data/database_helper.dart';
import 'package:eli_market/models/categoria.dart';

class ListaProductoPage extends StatelessWidget {
  //final String miProducto;
  final Categoria oCategoria;
  ListaProductoPage({this.oCategoria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset("assets/icons/back.svg",
              color: kTextoLigthColor),
        ),
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                color: kTextoLigthColor,
              ),
              onPressed: () {}),
          IconButton(
              icon: SvgPicture.asset("assets/icons/shopping-cart-1.svg",
                  color: kTextoLigthColor),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistroProductoPage(
                              oCategoria: oCategoria,
                            )));
              }),
        ],
        title: Text(oCategoria.descCategoria,
            style: GoogleFonts.berkshireSwash(
              color: kTextoLigthColor,
            )),
      ),
      body: FutureBuilder(
        future: DataBaseHelper.db
            .obtieneProductoPorIdCategoria(oCategoria.idCategoria),
        // initialData: InitialData,
        builder:
            (BuildContext context, AsyncSnapshot<List<Producto>> snapshot) {
          //print(snapshot.connectionState);
          // Verifica si esta esperando la data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            // retorna un lista de item.
            return _listaProductos(snapshot.data);
          }
        },
      ),
    );
  }

  Widget _listaProductos(List<Producto> listProducto) {
    return ListView.builder(
        itemCount: listProducto.length,
        itemBuilder: (BuildContext context, int i) {
          Producto oProducto = listProducto[i];
          // print(snapshot.data);
          return itemProducto(oProducto);
        });
  }

  Widget itemProducto(Producto oProducto) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding:
            EdgeInsets.only(top: 12.0, bottom: 0.0, left: 10.0, right: 10.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 233, 219, 1),
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 36.0,
                  child: ClipOval(
                    // borderRadius: BorderRadius.circular(36.0),
                    child: oProducto.imagen == null || oProducto.imagen.isEmpty
                        ? Image.asset(
                            "assets/imagenes/categoria_ninguno.png",
                            width: 100.0,
                          )
                        : oProducto.imagen.contains('assets/im')
                            ? Image.asset(
                                oProducto.imagen,
                                width: 100.0,
                              )
                            : Image.file(
                                File(oProducto.imagen),
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                  ),
                  // backgroundImage: AssetImage(oProducto.imagen),
                  // width: 100.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        oProducto.descProducto,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: kTextoColor,
                            height: 1.5),
                      ),
                      Text(
                        oProducto.observacion,
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, color: kTextoDarkColor, height: 1.5),
                      ),
                      Text(
                        "Lugar : ${oProducto.lugarCompra}",
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, color: kIconoInactivo, height: 1.5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Precio: ",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: kPrimaryDarkColor,
                                fontWeight: FontWeight.bold,
                                height: 1.5),
                          ),
                          Text(
                            "${oProducto.precio} Bs.",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                color: kTextoDarkColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            // SizedBox(
            //   height: 5.0,
            // ),
            Divider(
              color: Colors.pink[200],
              height: 2.0,
              thickness: 1,
            ),
            // SizedBox(
            //   height: 5.0,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _botonDetalle(
                    Icons.delete, "Eliminar", Colors.redAccent, oProducto),
                _botonDetalle(Icons.edit, "Modificar", Colors.green, oProducto),
                _botonDetalle(
                    Icons.search, "Ver detalle", kPrimaryDarkColor, oProducto),
              ],
            )
          ],
        ),
      ),
    );
  }

  _botonDetalle(
      IconData icono, String titulo, Color pColor, Producto pProducto) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(
        icono,
        size: 14.0,
        color: Colors.white,
      ),
      label: Text(
        titulo,
        style: TextStyle(fontSize: 11.0, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          primary: pColor.withAlpha(200),
          minimumSize: Size(90.0, 25.0),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))),
    );
  }
}
