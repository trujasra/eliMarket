import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constantes.dart';

class MenuPage extends StatelessWidget {
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
    );
  }
}
