import 'package:flutter/material.dart';

class CreditosComponente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
