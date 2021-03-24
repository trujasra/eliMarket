import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constantes.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> vlista = [
      "Peras",
      "Manzana",
      "Higos",
      "Duraznos",
      "Mandarina"
    ];
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: vlista.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: kDefaultPaddin,
                      mainAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 0.75),
                  itemBuilder: (BuildContext context, int index) {
                    return detalleMenu(context, vlista[index]);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget detalleMenu(BuildContext context, String vlista) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.all(kDefaultPaddin),
          height: 180,
          width: 160,
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(16)),
          child: null,
        )),
        Padding(
          padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
          child: Text(
            vlista,
            style: TextStyle(color: kPrimaryDarkColor),
          ),
        )
      ],
    );
  }
}
