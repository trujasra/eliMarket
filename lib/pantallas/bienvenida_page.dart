import 'package:flutter/material.dart';

class BienvenidaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text(
        //     'BIENVENIDO A',
        //     style: TextStyle(
        //         color: Colors.purpleAccent, fontWeight: FontWeight.bold),
        //   ),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/imagenes/fondo_bienvenida.jpg"), // <-- BACKGROUND IMAGE
                  fit: BoxFit.cover,
                ),
              ),
              child: null,
            ),
            new Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello background",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
