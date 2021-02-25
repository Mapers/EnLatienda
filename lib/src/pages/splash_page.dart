import 'dart:async';

import 'package:ecommerceapp/src/api/usuario_api.dart';
import 'package:ecommerceapp/src/provider/provider_auth.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_config.dart';


class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final Session _seccion = new Session();
  final UsuarioApi _usuarioApi = new UsuarioApi();

  @override
  void initState(){
    super.initState();
    final authProvider = Provider.of<ProviderAuth>(context,listen: false);
    Timer(
      Duration(seconds: 2),
      () async{
        final data = await _seccion.get();
        if(data != null){
          final isOk = await _usuarioApi.loginFirebase(context, data['email'], data['password']);
          if(isOk != null){
            if(isOk['ok']){
              final usuario = await _usuarioApi.loginServer(
                context, 
                email: data['email'],
                password: data['password'],
                idToken: isOk['idToken'],
                refreshToken: isOk['refreshToken'],
                expiresIn: int.parse(isOk['expiresIn'])
              );
              if(usuario != null){
                AppConfig.codigoUsuario = usuario.codUsu;
                authProvider.isLogged = true;
                Navigator.pushNamedAndRemoveUntil(context, 'route', (_) => false);
              }else{
                authProvider.isLogged = false;
                Navigator.pushNamedAndRemoveUntil(context, 'route', (_) => false);
              }
            }else{
              authProvider.isLogged = false;
              Navigator.pushNamedAndRemoveUntil(context, 'route', (_) => false);
            }
          }else{
            authProvider.isLogged = false;
            Navigator.pushNamedAndRemoveUntil(context, 'route', (_) => false);
          }
        }else{
          authProvider.isLogged = false;
          Navigator.pushNamedAndRemoveUntil(context, 'route', (_) => false);
        }
      }
    );
    
  }

  @override
  Widget build(BuildContext context) {
    final responsive = new Responsive(context); 
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(responsive.wp(4)),
          child: Image(image: AssetImage('assets/logo-dark.png')),
        )
     ),
   );
  }
}