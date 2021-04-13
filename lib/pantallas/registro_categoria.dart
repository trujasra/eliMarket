import 'package:eli_market/models/par_tipo_categoria.dart';
import 'package:eli_market/pantallas/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:eli_market/constantes.dart';

import 'package:eli_market/data/database_helper.dart';
import 'package:eli_market/models/categoria.dart';

//import 'lista_categoria.dart';

class RegistroCategoriaPage extends StatefulWidget {
  @override
  _RegistroCategoriaPageState createState() => _RegistroCategoriaPageState();
}

class _RegistroCategoriaPageState extends State<RegistroCategoriaPage> {
  TextEditingController descripcionController = TextEditingController();
  TextEditingController observacionController = TextEditingController();
  String vIdTipoCategoria;
  //TextEditingController descriptionController = TextEditingController();

  //Categoria categoria;

  // _RegistroCategoriaPageState();

  List<DropdownMenuItem<String>> lista;

  @override
  void initState() {
    super.initState();
    lista = [];
    DataBaseHelper.db.obtieneTipoCategoria().then((listaMap) {
      listaMap.map((map) {
        return obtieneDropDownWiget(map);
      }).forEach((element) {
        lista.add(element);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: kTextoColor);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
            child: TextField(
              maxLength: 40,
              controller: descripcionController,
              // style: textStyle,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                      color: kPrimaryDarkColor,
                    ),
                    borderRadius: BorderRadius.circular(6.0)),
                labelText: 'Descripción',
                hintText: 'Ingrese la categoria',
                labelStyle: textStyle,
                focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                      color: kPrimaryDarkColor,
                    ),
                    borderRadius: BorderRadius.circular(6.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
            child: Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  border: Border.all(
                    color: kPrimaryDarkColor,
                    width: 1,
                  ),
                  color: Colors.white),
              child: DropdownButton(
                isExpanded: true,
                itemHeight: 50.0,
                style: textStyle,
                hint: Text(
                  "Tipo categoria",
                  style: TextStyle(color: kPrimaryDarkColor, fontSize: 16.0),
                ),
                value: vIdTipoCategoria,
                onChanged: (valor) {
                  // print(valor);
                  setState(() {
                    vIdTipoCategoria = valor;
                  });
                },
                items: lista,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
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
                      borderSide: new BorderSide(color: kPrimaryDarkColor),
                      borderRadius: BorderRadius.circular(6.0))),
            ),
          ),
          Container(
            margin: new EdgeInsets.only(top: 20.0),
            width: MediaQuery.of(context).size.width * 0.90,
            child: ElevatedButton(
              onPressed: () {
                Categoria categoria = new Categoria();
                categoria.descCategoria = descripcionController.text;
                categoria.parTipoCategoria = int.parse(vIdTipoCategoria);
                categoria.observacion = observacionController.text;
                categoria.imagen = "assets/imagenes/abarrotes.png";

                // Envia para registrar la informacion.
                DataBaseHelper.db.registraCategoria(categoria);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MenuPage()));
              },
              child: Text("REGISTRAR"),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  elevation: 5.0,
                  primary: kAcentColor,
                  // padding: EdgeInsets.symmetric(horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
          )
        ],
      ),
    );
  }

  DropdownMenuItem<String> obtieneDropDownWiget(
      ParTipoCategoria tipoCategoria) {
    return DropdownMenuItem<String>(
      value: tipoCategoria.idTipoCategoria.toString(),
      child: Text(tipoCategoria.tipoCategoria),
    );
  }
}
