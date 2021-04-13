import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:eli_market/pantallas/lista_categoria.dart';
import 'package:eli_market/pantallas/registro_categoria.dart';
import 'package:eli_market/pantallas/credito_menu_page.dart';

import '../constantes.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Map<String, Object>> _paginas;
  int _seleccionPaginaIndex = 0;

  @override
  void initState() {
    _paginas = [
      {'pagina': ListaCategoriaPage()},
      {'pagina': ListaCategoriaPage()},
      {'pagina': CreditoMenuPage()},
      {'pagina': RegistroCategoriaPage()},
    ];
    super.initState();
  }

  void _seleccionPagina(int index) {
    setState(() {
      _seleccionPaginaIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg",
              color: kTextoLigthColor),
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
          style: GoogleFonts.berkshireSwash(
            color: kTextoLigthColor,
          ),
          // TextStyle(color: kTextoLigthColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _paginas[_seleccionPaginaIndex]['pagina'],
      floatingActionButton: FloatingActionButton(
        foregroundColor: kPrimaryColor,
        backgroundColor: Colors.white,
        shape: CircleBorder(
          side: BorderSide(width: 5.0, color: kPrimaryColor),
        ),
        onPressed: () {
          setState(() {});
          // Navigator.pushNamed(context, '/RegistroCategoria');
          _seleccionPaginaIndex = 3;
          _seleccionPagina(_seleccionPaginaIndex);
        },
        child: Icon(
          Icons.post_add_rounded,
          size: 30.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _menuAbajo(context),
    );
  }

  Widget _menuAbajo(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.transparent,
        elevation: 10.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight + 10,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _disenioMenuBoton(0, "home.svg", "Inicio"),
                    _disenioMenuBoton(1, "loupe.svg", "Buscar"),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _disenioMenuBoton(2, "user.svg", "Creditos"),
                    _disenioMenuBoton(3, "exit.svg", "Salir"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _disenioMenuBoton(int index, String pIcono, String pTextoIcono) {
    return Column(
      children: [
        IconButton(
            icon: SvgPicture.asset(
              "assets/icons/" + pIcono,
              color: _seleccionPaginaIndex == index
                  ? kTextoLigthColor
                  : kIconoInactivo,
              width: 24.0,
            ),
            onPressed: () {
              if (index == 3) {
                // exit(0);
                // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                SystemNavigator.pop();
              } else {
                setState(() {
                  _seleccionPaginaIndex = index;
                  _seleccionPagina(_seleccionPaginaIndex);
                });
              }
            }),
        Text(
          pTextoIcono,
          style: GoogleFonts.montserratAlternates(
              fontSize: 11.0,
              color: _seleccionPaginaIndex == index
                  ? kTextoLigthColor
                  : kIconoInactivo),
          // TextStyle(
          //   color: _seleccionPaginaIndex == index
          //       ? kIconLigthColor
          //       : kTextoLigthColor,
          // ),
        ),
      ],
    );
  }
}
