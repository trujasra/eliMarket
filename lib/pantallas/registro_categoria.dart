import 'package:eli_market/models/par_tipo_categoria.dart';
import 'package:eli_market/pantallas/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:eli_market/constantes.dart';

import 'package:eli_market/data/database_helper.dart';
import 'package:eli_market/models/categoria.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // Metodo para obtener los datos para el combo Tipo categoria
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
    TextStyle textStyle = TextStyle(color: kTextoDarkColor);
    return Scaffold(
      backgroundColor: Colors.white, //kPrimaryColor
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            width: MediaQuery.of(context).size.width,
            height: 90.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Para el registro de una nueva categoria debe de llenar todos los campos solicitados",
                    style: GoogleFonts.montserratAlternates(
                        color: kPrimaryLigthColor, fontSize: 14.0), //
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 9.0, left: 20.0, right: 20.0),
                    child: Text(
                      "* Si no existe el tipo de categoria, debe de hacer click en (+ TIPO CAT) para agregar uno nuevo.",
                      style: GoogleFonts.montserratAlternates(
                          color: kTextoLigthColor, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                child: TextField(
                  maxLength: 40,
                  controller: descripcionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: kTextoColor,
                        ),
                        borderRadius: BorderRadius.circular(6.0)),
                    labelText: 'Descripción',
                    hintText: 'Ingrese la categoria',
                    labelStyle: textStyle,
                    focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(6.0)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0)),
                            border: Border.all(
                              color: kTextoColor,
                              width: 1,
                            ),
                            color: Colors.white),
                        child: DropdownButton(
                          isExpanded: true,
                          itemHeight: 50.0,
                          style: textStyle,
                          hint: Text(
                            "Tipo categoria",
                            style: TextStyle(
                                color: kTextoDarkColor, fontSize: 16.0),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: ElevatedButton.icon(
                      icon: SvgPicture.asset(
                        "assets/icons/shopping-basket.svg",
                        color: kTextoLigthColor,
                        height: 25.0,
                      ),
                      onPressed: () {},
                      label: Text("+ TIPO CAT."),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          elevation: 5.0,
                          primary: kAcentColor,
                          // padding: EdgeInsets.symmetric(horizontal: 30.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                child: TextField(
                  maxLines: 2,
                  controller: observacionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: kTextoColor,
                        ),
                        borderRadius: BorderRadius.circular(6.0)),
                    labelText: 'Observación',
                    hintText: 'Ingrese la observación',
                    labelStyle: textStyle,
                    focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: kTextoColor,
                        ),
                        borderRadius: BorderRadius.circular(6.0)),
                  ),
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
