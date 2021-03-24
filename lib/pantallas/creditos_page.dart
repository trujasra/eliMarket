import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:eli_market/constantes.dart';

class CreditosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "Creditos",
          style: TextStyle(color: kTextoLigthColor),
        ),
      ),
      body: Stack(
        children: [
          Container(
            //color: kPrimaryColor, // comentar esto
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imagenes/fondo_creditos.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          Text("Elizabeth")
        ],
      ),
    );
  }
}
