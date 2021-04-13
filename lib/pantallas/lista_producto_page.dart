import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constantes.dart';
import 'package:eli_market/data/database_helper.dart';
import 'package:eli_market/models/categoria.dart';

class ListaProductoPage extends StatelessWidget {
  //final String miProducto;
  Categoria oCategoria;
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
              onPressed: () {}),
        ],
        title: Text(oCategoria.descCategoria,
            style: GoogleFonts.berkshireSwash(
              color: kTextoLigthColor,
            )),
      ),
      body: FutureBuilder(
        future: DataBaseHelper.db.obtieneCategoria(),
        // initialData: InitialData,
        builder:
            (BuildContext context, AsyncSnapshot<List<Categoria>> snapshot) {
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

  Widget _listaProductos(List<Categoria> listCategoria) {
    return ListView.builder(
        itemCount: listCategoria.length,
        itemBuilder: (BuildContext context, int i) {
          Categoria oCategoria = listCategoria[i];
          // print(snapshot.data);
          return itemProducto(oCategoria);
        });
  }

  Widget itemProducto(Categoria oCategoria) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
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
                  backgroundImage: AssetImage(oCategoria.imagen),
                  radius: 36,
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
                        oCategoria.descCategoria,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kTextoDarkColor,
                            height: 1.5),
                      ),
                      Text(
                        oCategoria.observacion,
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, color: kTextoColor, height: 1.5),
                      ),
                      Text(
                        "Lugar : ${oCategoria.observacion}",
                        // overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, color: kIconoInactivo, height: 1.5),
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
                            "${oCategoria.parTipoCategoria} Bs.",
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
              height: 3.0,
              thickness: 1,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _botonDetalle(Icons.delete, "Eliminar", kPrimaryDarkColor),
                _botonDetalle(
                    Icons.edit, "Modificar", Color.fromRGBO(47, 161, 7, 1)),
                _botonDetalle(Icons.search, "Ver detalle",
                    Color.fromRGBO(149, 35, 192, 1)),
              ],
            )
          ],
        ),
      ),
    );
  }

  _botonDetalle(IconData icono, String titulo, Color pColor) {
    return FlatButton.icon(
        height: 18.0,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: pColor.withOpacity(0.2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: pColor)),
        onPressed: () {},
        icon: Icon(
          icono,
          size: 14.0,
          color: pColor,
        ),
        label: Text(
          titulo,
          style: TextStyle(fontSize: 11.0, color: pColor),
        ));
  }
}
