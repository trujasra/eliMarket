import 'package:eli_market/models/categoria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constantes.dart';
import 'package:eli_market/data/database_helper.dart';

class ListaProductoPage extends StatelessWidget {
  final String miProducto;
  ListaProductoPage({this.miProducto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset("assets/icons/back.svg",
              color: kIconPrimaryColor),
        ),
        actions: [
          IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {}),
        ],
        title: Text(miProducto),
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
          return ListTile(
            title: Text(oCategoria.descCategoria),
          );
        });
  }
}
