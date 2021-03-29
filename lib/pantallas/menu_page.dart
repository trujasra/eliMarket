import 'package:eli_market/pantallas/lista_producto_page.dart';
import 'package:flutter/gestures.dart';
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
    Size tamanio = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
        // actions: [
        //   IconButton(
        //     icon: SvgPicture.asset(
        //       "assets/icons/search.svg",
        //       color: kIconPrimaryColor,
        //     ),
        //     onPressed: () {},
        //   ),
        //   IconButton(
        //       icon: SvgPicture.asset(
        //         "assets/icons/cart.svg",
        //         color: kIconPrimaryColor,
        //       ),
        //       onPressed: () {}),
        //   SizedBox(
        //     width: 10.0,
        //   ),
        // ],
        title: Text(
          "Categorias",
          style:
              TextStyle(color: kTextoLigthColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15.0),
        padding: EdgeInsets.only(top: 5.0),
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
      floatingActionButton: FloatingActionButton(
        foregroundColor: kPrimaryColor,
        backgroundColor: Colors.white,
        shape: CircleBorder(
          side: BorderSide(width: 5.0, color: kPrimaryColor),
        ),
        onPressed: () {},
        child: Icon(
          Icons.post_add_rounded,
          size: 30.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: botonesBar(context, tamanio),
    );
  }

  Widget _listaMenuCategoria(List<Categoria> listaCategoria) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPaddin,
        ),
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

  Widget botonesBar(BuildContext context, Size pTamanio) {
    return Container(
      color: Colors.white,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Colors.transparent,
        elevation: 10.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
              color: kPrimaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50.0,
                width: pTamanio.width / 2 - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // print("Hola");
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search_sharp,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.0,
                width: pTamanio.width / 2 - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
