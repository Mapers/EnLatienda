import 'dart:convert';
import 'package:ecommerceapp/src/models/usuario_model.dart';
import 'package:ecommerceapp/src/utils/dialogs.dart';
import 'package:ecommerceapp/src/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../app_config.dart';


class UsuarioApi{

  final String _firebaseToken = 'AIzaSyDVFjsmW41j4dX-iMquHsYrHQD5MRoypXk';
  final _session = Session();

  Future<Map<String,dynamic>> loginFirebase(BuildContext context, String email, String password) async{

    final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true
    };
    try{
      final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData)
      );

      Map<String,dynamic> decodedResp = json.decode(resp.body);

      print(decodedResp);

      if (decodedResp.containsKey('idToken')){
        return {'ok': true, 'token' : decodedResp['idToken'], 'refreshToken' : decodedResp['refreshToken'], 'expiresIn' : decodedResp['expiresIn'] };
      }else{
        return {'ok': false, 'mensaje' : decodedResp['error']['message']};
      }
    }catch(e){
      Dialogs.alert(context, title: 'Error', message: e.message);
      return null;
    }

  }

  Future<Map<String,dynamic>> registroFirebase(String email, String password) async{

    final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String,dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')){
      return {'ok': true, 'token' : decodedResp['idToken'], 'refreshToken' : decodedResp['refreshToken'], 'expiresIn' : decodedResp['expiresIn'] };
    }else{
      return {'ok': false, 'mensaje' : decodedResp['error']['message']};
    }

  }

  Future<Usuario> loginServer(BuildContext context,{String email, String password, String idToken, String refreshToken, int expiresIn}) async{
    final authData = {
      'username' : email,
      'password' : password
    };

    final response = await http.post(
      '${AppConfig.apiHost}/users/login',
      headers: {'Content-Type' : 'application/json'},
      body: json.encode(authData)
    );

    print(response.body);

    final parsed = usuarioFromJson(response.body);
    print('datos del login ${parsed.codUsu}');

    try{
      if(response.statusCode == 200){
        await _session.set(parsed.token, refreshToken, expiresIn,email,password,parsed.codUsu,parsed.names,parsed.lastnames,parsed.direccion,parsed.celular);
        return parsed;
      }else if(response.statusCode == 403){
        throw PlatformException(code: '403', message: 'Acceso denegado');
      }else if(response.statusCode == 500){
        throw PlatformException(code: '500', message: 'Error interno en el servidor');
      }
      throw PlatformException(code: '201', message: 'error: /users/login');

    }on PlatformException catch(e){
      print('error getUserInfo: ${e.message}');
      Dialogs.alert(context, title: 'Error', message: e.message);
      return null;
    }
  }

    Future<UsuarioRegistro> registroServer(BuildContext context,{String nombre, String apellido,String email, String password, String idToken, String refreshToken, int expiresIn}) async{

    final date = DateTime.now().add(Duration(seconds: expiresIn));
    final authData = {
      'nombres'   : nombre,
      'apellidos' : apellido,
      'email'     : email,
      'direccion' : '',
      'celular'   : '',
      'password'  : password,
      'tokenExpiresAt':  DateFormat('dd/MM/yyyy hh:mm:ss').format(date),
      'token'     : idToken,
    };

    print(authData.toString());

    final response = await http.post(
      '${AppConfig.apiHost}/users/register',
      headers: {'Accept': 'application/json','content-type': 'application/json'},
      body: json.encode(authData)
    );
    print(response.body);

    try{
      if(response.statusCode == 200){
        final parsed = usuarioRegistroFromJson(response.body);
        await _session.set(idToken, refreshToken, expiresIn,email,password,parsed.userId,nombre,apellido,'','');
        return parsed;
      }else if(response.statusCode == 403){
        throw PlatformException(code: '403', message: 'Acceso denegado');
      }else if(response.statusCode == 500){
        throw PlatformException(code: '500', message: 'Error interno en el servidor');
      }
      throw PlatformException(code: '201', message: 'error: /users/register');

    }on PlatformException catch(e){
      print('error getUserInfo: ${e.message}');
      Dialogs.alert(context, title: 'Error', message: e.message);
      return null;
    }
  }

}