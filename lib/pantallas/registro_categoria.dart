import 'dart:io';

import 'package:eli_market/models/par_tipo_categoria.dart';
import 'package:eli_market/pantallas/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:eli_market/constantes.dart';
import 'package:eli_market/data/database_helper.dart';
import 'package:eli_market/models/categoria.dart';

//import 'lista_categoria.dart';

class RegistroCategoriaPage extends StatefulWidget {
  @override
  _RegistroCategoriaPageState createState() => _RegistroCategoriaPageState();
}

class _RegistroCategoriaPageState extends State<RegistroCategoriaPage> {
  // LLaves par alos formularios
  final _formKeyTipoCategoria = GlobalKey<FormState>();
  final _formKeyCategoria = GlobalKey<FormState>();

  // Estilos
  TextStyle textStyle = TextStyle(color: kTextoDarkColor);
  OutlineInputBorder inputBorderTexto = OutlineInputBorder(
      borderSide: new BorderSide(
        color: kTextoColor,
      ),
      borderRadius: BorderRadius.circular(6.0));

  TextEditingController descripcionController = TextEditingController();
  TextEditingController observacionController = TextEditingController();
  TextEditingController descTipoCategoriaController = TextEditingController();

  String vIdTipoCategoria;
  List<DropdownMenuItem<String>> lista;
  File _imagenCategoria;

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
    return Scaffold(
      backgroundColor: Colors.white, //kPrimaryColor
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: kIconoInactivo,
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
                    padding: EdgeInsets.only(top: 9.0, left: 18.0, right: 18.0),
                    child: Text(
                      "* Si no existe en la lista el tipo categoria, debe de hacer click en (+ TIPO CAT) para agregar uno nuevo.",
                      style: GoogleFonts.montserratAlternates(
                          color: kTextoLigthColor, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyCategoria,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                      child: TextFormField(
                        validator: (valor) {
                          if (valor.isEmpty) {
                            return 'Ingrese la categoria';
                          }
                          return null;
                        },
                        maxLength: 40,
                        controller: descripcionController,
                        decoration: InputDecoration(
                          labelText: 'Descripción categoria',
                          // hintText: 'Ingrese la categoria',
                          labelStyle: textStyle,
                          enabledBorder: inputBorderTexto,
                          focusedBorder: inputBorderTexto,
                          errorBorder: inputBorderTexto,
                          focusedErrorBorder: inputBorderTexto,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20.0, right: 2.0, top: 7.0, bottom: 7.0),
                            child: DropdownButtonFormField(
                              validator: (valor) {
                                if (valor == null) {
                                  return "Seleccione tipo categoria";
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                labelText: "Tipo categoria",
                                // hintText: 'Ingrese tipo categoria',
                                labelStyle: textStyle,
                                enabledBorder: inputBorderTexto,
                                focusedBorder: inputBorderTexto,
                                errorBorder: inputBorderTexto,
                                focusedErrorBorder: inputBorderTexto,
                              ),
                              isExpanded: true,
                              // itemHeight: 50.0,
                              style: textStyle,
                              value: vIdTipoCategoria,
                              items: lista,
                              onChanged: (valor) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                // print(valor);
                                setState(() {
                                  vIdTipoCategoria = valor;
                                });
                              },
                            ),
                          ),
                        ),
                        registrarNuevoTipoCategoria(context),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                      child: TextFormField(
                        validator: (valor) {
                          if (valor.isEmpty) {
                            return "Ingrese observación";
                          }
                          return null;
                        },
                        maxLines: 2,
                        controller: observacionController,
                        decoration: InputDecoration(
                          labelText: 'Observación',
                          // hintText: 'Ingrese la observación',
                          labelStyle: textStyle,
                          enabledBorder: inputBorderTexto,
                          focusedBorder: inputBorderTexto,
                          errorBorder: inputBorderTexto,
                          focusedErrorBorder: inputBorderTexto,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: _imagenCategoria != null
                              ? FileImage(_imagenCategoria)
                              : AssetImage(
                                  "assets/imagenes/fondo_bienvenida.jpg"),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              obtenerImagen();
                            },
                            child: Text("Subir imagen"))
                      ],
                    ),
                    registrarNuevaCategoria(context),
                  ],
                ),
              ),
            ),
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

  Widget registrarNuevaCategoria(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(top: 20.0),
      width: MediaQuery.of(context).size.width * 0.90,
      child: ElevatedButton(
        onPressed: () {
          // verifica si la informacion esta validada.
          if (_formKeyCategoria.currentState.validate()) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Información"),
                    content: Text("Desea registrar la nueva categoria?"),
                    actions: [
                      OutlinedButton(
                        onPressed: () {
                          Categoria categoria = new Categoria();
                          categoria.descCategoria = descripcionController.text;
                          categoria.parTipoCategoria =
                              int.parse(vIdTipoCategoria);
                          categoria.observacion = observacionController.text;
                          categoria.imagen = "assets/imagenes/abarrotes.png";

                          // Envia para registrar la informacion.
                          DataBaseHelper.db.registraCategoria(categoria);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MenuPage()));
                        },
                        child: Text(
                          'SI',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green[50],
                            side: BorderSide(
                              color: Colors.green,
                            )),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'CANCELAR',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.red[50],
                            side: BorderSide(color: Colors.redAccent)),
                      ),
                    ],
                  );
                });
          }
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
    );
  }

  Widget registrarNuevoTipoCategoria(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0, left: 2.0),
      child: ElevatedButton.icon(
        icon: SvgPicture.asset(
          "assets/icons/shopping-basket.svg",
          color: kTextoLigthColor,
          height: 25.0,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Form(
                    key: _formKeyTipoCategoria,
                    child: Container(
                      height: 250.0,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(18.0),
                            height: 60.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0))),
                            child: Text(
                              "Registrar Tipo de Categoria",
                              style: GoogleFonts.berkshireSwash(
                                  color: kTextoLigthColor, fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: TextFormField(
                              validator: (valor) {
                                if (valor.isEmpty) {
                                  return 'Ingrese el tipo de categoria';
                                }
                                return null;
                              },
                              maxLength: 25,
                              controller: descTipoCategoriaController,
                              decoration: InputDecoration(
                                labelText: 'Tipo de Categoria',
                                // hintText: 'Ingrese tipo categoria',
                                labelStyle: textStyle,
                                enabledBorder: inputBorderTexto,
                                focusedBorder: inputBorderTexto,
                                errorBorder: inputBorderTexto,
                                focusedErrorBorder: inputBorderTexto,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: ElevatedButton(
                              onPressed: () {
                                // Verifica si todo esta validadado
                                if (_formKeyTipoCategoria.currentState
                                    .validate()) {
                                  // Aca se gurda la informacion
                                }
                              },
                              child: Text("REGISTRAR"),
                              style: ElevatedButton.styleFrom(
                                  primary: kAcentColor,
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        label: Text("+ TIPO CAT."),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            elevation: 5.0,
            primary: kAcentColor,
            // padding: EdgeInsets.symmetric(horizontal: 30.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }

  void obtenerImagen() async {
    var imagenGaleria =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagenCategoria = imagenGaleria;
    });
  }
}
