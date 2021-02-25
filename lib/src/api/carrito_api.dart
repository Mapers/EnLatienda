import 'dart:convert';

import 'package:ecommerceapp/src/models/carrito_model.dart';
import 'package:ecommerceapp/src/utils/dialogs.dart';
import 'package:ecommerceapp/src/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../app_config.dart';

class CarritoApi{ 

  guardarProducto(BuildContext context, String codProducto, int cantidad,String codUniPrec) async{

    Session session = new Session();
    final data = await session.get();

    print(data);

    final productoData = {
      "codCarComp": "",
      "codProd": codProducto,
      "codUsu": AppConfig.codigoUsuario.toString(),
      "opcionProd": "",
      "cantProd": cantidad,
      "codUniPrec": "1",
      "codEmp": AppConfig.codigoEmpresa
    };
    

    final url = '${AppConfig.apiHost}/private/shopping-cart';

    final response = await http.post(
      url, 
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': data['token'],
      },
      body: json.encode(productoData)
    );

    final parsed = json.decode(response.body);
    print(parsed);

    try{
      if(response.statusCode == 200){
        return parsed;
      }else if(response.statusCode == 403){
        throw PlatformException(code: '403', message: 'Acceso denegado');
      }else if(response.statusCode == 500){
        throw PlatformException(code: '500', message: 'Error interno en el servidor');
      }
      throw PlatformException(code: '201', message: 'error: /private/shopping-cart');

    }on PlatformException catch(e){
      print('error getUserInfo: ${e.message}');
      Dialogs.alert(context, title: 'Error', message: e.message);
      return null;
    }

  }

  Future<List<Carrito>> obtenerProducto(BuildContext context) async{

    Session session = new Session();
    final data = await session.get();

    print(data);

    final url = '${AppConfig.apiHost}/private/shopping-cart/${AppConfig.codigoUsuario}';

    final response = await http.get(
      url, 
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': data['token'],
      },
    );

    print(response.body);

    final parsed = carritoFromJson(response.body);

    try{
      if(response.statusCode == 200){
        return parsed;
      }else if(response.statusCode == 403){
        throw PlatformException(code: '403', message: 'Acceso denegado');
      }else if(response.statusCode == 500){
        throw PlatformException(code: '500', message: 'Error interno en el servidor');
      }
      throw PlatformException(code: '201', message: 'error: /private/shopping-cart');

    }on PlatformException catch(e){
      print('error getUserInfo: ${e.message}');
      Dialogs.alert(context, title: 'Error', message: e.message);
      return null;
    }

  }  

}