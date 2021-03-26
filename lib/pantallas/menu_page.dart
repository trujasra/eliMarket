import 'package:eli_market/pantallas/lista_producto_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constantes.dart';
import 'package:eli_market/data/database_helper.dart';
import 'package:eli_market/models/categoria.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<String> vlista = [
    //   "Peras",
    //   "Manzana",
    //   "Higos",
    //   "Duraznos",
    //   "Mandarina"
    // ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg",
              color: kIconPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              color: kIconPrimaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/cart.svg",
                color: kIconPrimaryColor,
              ),
              onPressed: () {}),
          SizedBox(
            width: 10.0,
          ),
        ],
        title: Text(
          "",
          style: TextStyle(color: kTextoLigthColor),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
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
    );
  }

  Widget _listaMenuCategoria(List<Categoria> listaCategoria) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: GridView.builder(
            itemCount: listaCategoria.length,
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
