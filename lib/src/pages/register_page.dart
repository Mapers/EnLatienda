import 'package:ecommerceapp/app_config.dart';
import 'package:ecommerceapp/src/api/usuario_api.dart';
import 'package:ecommerceapp/src/provider/provider_auth.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:ecommerceapp/src/widgets/circle_widget.dart';
import 'package:ecommerceapp/src/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ecommerceapp/src/utils/dialogs.dart' as utils;
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _nombre = '', _apellido = '';
  bool _isFetching = false;
  final _usuarioApi = new UsuarioApi();

  @override
    void initState() { 
      super.initState();
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }

  _submit() async{
    final authProvider = Provider.of<ProviderAuth>(context,listen: false);
    if(_isFetching) return;
    final isValid = _formKey.currentState.validate();
    if(isValid){
      setState(() {
        _isFetching = true;
      });
      final isOk = await _usuarioApi.registroFirebase(_email, _password);
      setState(() {
        _isFetching = false;
      });
      if(isOk['ok']){
        final usuario = await _usuarioApi.registroServer(
          context, 
          nombre: _nombre,
          apellido: _apellido,
          email: _email,
          password: _password,
          idToken: isOk['token'],
          refreshToken: isOk['refreshToken'],
          expiresIn: int.parse(isOk['expiresIn'])
        );
        if(usuario != null){
          AppConfig.codigoUsuario = usuario.userId;
          authProvider.isLogged = true;
          Navigator.pushNamedAndRemoveUntil(context, 'route', (_) => false);
        }
      }else{
        authProvider.isLogged = false;
        utils.Dialogs.alert(context,title: 'Error',message: isOk['mensaje']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final responsive = new Responsive(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: -size.width * 0.22,
                top: -size.width * 0.36,
                child: CircleWidget(
                  radius: size.width * 0.45, 
                  colors: [Style.colorMorado,Color(0xFF5222A4)]
                )
              ),
              Positioned(
                left: -size.width * 0.15,
                top: -size.width * 0.34,
                child: CircleWidget(
                  radius: size.width * 0.35, 
                  colors: [Style.colorNaranja, Color(0xFFFF5A00)]
                )
              ),
              SingleChildScrollView(
                child: Container(
                  height: size.height,
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: responsive.wp(6)),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: responsive.hp(15),),
                        Column(
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 350.0,
                                maxHeight: 350.0
                              ),
                              child: Form(
                                key: this._formKey,
                                child: Column(
                                  children: <Widget>[
                                    Spacer(),
                                    InputTextWidget(
                                      label: 'Nombres',
                                      validator: (String text){
                                        if(RegExp(r'^[a-zA-z0-9]+$').hasMatch(text)){
                                          _nombre = text;
                                          return null;
                                        }
                                        return 'Nombre invalido';    
                                      },
                                      fontSize: responsive.ip(1.8),
                                    ),
                                    SizedBox(height: responsive.hp(3),),
                                    InputTextWidget(
                                      label: 'Apellidos',
                                      validator: (String text){
                                        if(RegExp(r'^[a-zA-z0-9]+$').hasMatch(text)){
                                          _apellido = text;
                                          return null;
                                        }
                                        return 'Apellido invalido';    
                                      },
                                      fontSize: responsive.ip(1.8),
                                    ),
                                    SizedBox(height: responsive.hp(3),),
                                    InputTextWidget(
                                      label: 'Correo Electrónico',
                                      validator: (String text){
                                        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regExp = new RegExp(pattern);
                                        if(regExp.hasMatch(text)){
                                          _email = text;
                                          return null;
                                        }
                                        return 'Correo inválido';
                                      },
                                      inputType: TextInputType.emailAddress,
                                      fontSize: responsive.ip(1.8),
                                    ),
                                    SizedBox(height: responsive.hp(3),),
                                    InputTextWidget(
                                      label: 'Contraseña',
                                      validator: (String text){
                                        if(text.isNotEmpty && text.length > 5){
                                          _password = text;
                                          return null;
                                        }
                                        return 'Contraseña mayor a 6 caracteres';
                                      },
                                      isSecure: true,
                                      fontSize: responsive.ip(1.8),
                                    ),
                                  ],
                                )
                              ),
                            ),
                            SizedBox(height: responsive.hp(7),),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 350.0,
                                maxHeight: 350.0,
                              ),
                              child: CupertinoButton(
                                color: Style.colorNaranja,
                                borderRadius: BorderRadius.circular(4.0),
                                child: Text('Registrate', style: TextStyle(fontSize: responsive.ip(2.5)),),
                                onPressed: () => _submit(),
                              ),
                            ),
                            SizedBox(height: responsive.hp(5),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Ya tienes una cuenta?', 
                                  style: TextStyle(fontSize: responsive.ip(1.8), color: Colors.black54)
                                ),
                                CupertinoButton(
                                  child: Text(
                                    'Inicia Sesión',
                                    style: TextStyle(fontSize: responsive.ip(1.8), color: Style.colorMorado),
                                  ), 
                                  onPressed: () => Navigator.pop(context)
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: responsive.hp(3),),
                      ],
                    )
                  ),
                ),
              ),
              Positioned(
                left: 15.0,
                top: 5.0,
                child: SafeArea(
                  child: CupertinoButton(
                    color: Colors.black12,
                    padding: EdgeInsets.all(10.0),
                    borderRadius: BorderRadius.circular(30),
                    child: Icon(Icons.arrow_back, color: Colors.white,), 
                    onPressed: () => Navigator.pop(context)
                  ),
                ),
              ),
              _isFetching ? Positioned(child: Container(
                color: Colors.black45,
                child: Center(child: CupertinoActivityIndicator(radius:15),),
              )) : Container()
            ],
          ),
        ),
      ),
    );

  }
}