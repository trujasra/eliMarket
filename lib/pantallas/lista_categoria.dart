import 'package:flutter/material.dart';

import 'package:eli_market/data/database_helper.dart';
import 'package:eli_market/models/categoria.dart';
import 'lista_producto_page.dart';

import '../constantes.dart';

class ListaCategoriaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        // margin: EdgeInsets.only(top: 15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          child: Column(
            children: [
              FutureBuilder(
                  future: DataBaseHelper.db.obtieneCategoria(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Categoria>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return _listaMenuCategoria(snapshot.data);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listaMenuCategoria(List<Categoria> listaCategoria) {
    return Expanded(
      child: Container(
        child: GridView.builder(
            itemCount: listaCategoria.length,
            padding: EdgeInsets.only(
                top: 5.0, right: kDefaultPaddin, left: kDefaultPaddin),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: kDefaultPaddin,
                mainAxisSpacing: kDefaultPaddin,
                childAspectRatio: 0.75),
            itemBuilder: (BuildContext context, int index) {
              Categoria oCategoria = listaCategoria[index];
              return detalleMenu(context, oCategoria);
            }),
      ),
    );
  }

  Widget detalleMenu(BuildContext context, Categoria pCategoria) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ListaProductoPage(
                    oCategoria: pCategoria,
                  ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(kDefaultPaddin),
            height: 180,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(16)),
            child: Image.asset(pCategoria.imagen),
          )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
            child: Text(
              pCategoria.descCategoria,
              style: TextStyle(color: kPrimaryDarkColor),
            ),
          )
        ],
      ),
    );
  }
}
