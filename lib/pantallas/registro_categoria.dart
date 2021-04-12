import 'package:eli_market/constantes.dart';
import 'package:eli_market/models/categoria.dart';
import 'package:flutter/material.dart';

class RegistroCategoriaPage extends StatefulWidget {
  @override
  _RegistroCategoriaPageState createState() => _RegistroCategoriaPageState();
}

class _RegistroCategoriaPageState extends State<RegistroCategoriaPage> {
  TextEditingController descripcionController = TextEditingController();
  TextEditingController observacionController = TextEditingController();
  //TextEditingController descriptionController = TextEditingController();

  Categoria categoria;
  // _RegistroCategoriaPageState(this.categoria);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: kPrimaryColor);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
            child: TextField(
              maxLength: 40,
              controller: descripcionController,
              style: textStyle,

              // onChanged: (value) {
              //   categoria.descCategoria = descripcionController.text;
              // },
              decoration: InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Ingrese la categoria',
                  labelStyle: textStyle,
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(6.0))),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
            child: TextField(
              maxLines: 2,
              controller: observacionController,
              style: textStyle,

              // onChanged: (value) {
              //   categoria.descCategoria = descripcionController.text;
              // },
              decoration: InputDecoration(
                  labelText: 'Observación',
                  hintText: 'Ingrese la observación',
                  labelStyle: textStyle,
                  focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(6.0))),
            ),
          ),
        ],
      ),
    );
  }
}
