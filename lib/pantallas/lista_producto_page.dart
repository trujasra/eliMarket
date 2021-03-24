import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constantes.dart';

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
    );
  }
}
