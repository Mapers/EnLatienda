import 'package:ecommerceapp/src/provider/provider_auth.dart';
import 'package:ecommerceapp/src/utils/dialogs.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/session.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:ecommerceapp/src/widgets/options_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class MiCuentaPage extends StatefulWidget {


  @override
  _MiCuentaPageState createState() => _MiCuentaPageState();
}

class _MiCuentaPageState extends State<MiCuentaPage> {

  final _session = new Session();

  @override
  Widget build(BuildContext context) {
    final responsive = new Responsive(context);
    final authProvider = Provider.of<ProviderAuth>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: authProvider.isLogged ? LoggedUser(session: _session, responsive: responsive, authProvider: authProvider) : UnloggedUser(session: _session,responsive: responsive,authProvider: authProvider,)
   );
  }
}

class LoggedUser extends StatelessWidget {
  const LoggedUser({
    Key key,
    @required Session session,
    @required this.responsive,
    @required this.authProvider,
  }) : _session = session, super(key: key);

  final Session _session;
  final Responsive responsive;
  final ProviderAuth authProvider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _session.get(), 
      builder:(context,AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: responsive.hp(4),left: responsive.wp(2), right: responsive.wp(2)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: responsive.wp(5.8),
                        backgroundColor: Style.colorNaranja,
                        child: Text(snapshot.data['name'].toString().substring(0,1).toUpperCase(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800, fontSize: responsive.ip(3)),),
                      ),
                      SizedBox(width: responsive.wp(4),),
                      Container(
                        height: responsive.hp(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${snapshot.data['name'].toString()} ${snapshot.data['lastName'].toString()}',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: responsive.ip(2.1)),),
                            Text('${snapshot.data['email'].toString()}', overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: responsive.ip(1.5)))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: responsive.hp(4),),
                  Material(
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(2), vertical: responsive.hp(1)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Pedidos', style: TextStyle(fontSize: responsive.ip(2), fontWeight: FontWeight.w800),),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  authProvider.isLogged ? Navigator.pushNamed(context, 'historial_pedido') : Navigator.pushNamed(context, 'introduccion_login');
                                }, 
                                child: Row(
                                  children: <Widget>[
                                    Text('Ver todo', style: TextStyle(color: Colors.black38, fontSize: responsive.ip(1.4)),),
                                    Icon(Icons.chevron_right, size: responsive.ip(1.8),color: Colors.black26,)
                                  ],
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: responsive.hp(1),),
                          Container(
                            height: 1,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          SizedBox(height: responsive.hp(1),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: responsive.wp(30),
                                child: OptionsUser(text: 'Pendientes de pago',icon: FontAwesomeIcons.wallet,onTap: (){authProvider.isLogged ? Navigator.pushNamed(context, 'historial_pedido') : Navigator.pushNamed(context, 'introduccion_login');},)
                                ),
                                Container(
                                width: responsive.wp(30),
                                child: OptionsUser(text: 'Pendientes de envío',icon: FontAwesomeIcons.cartArrowDown,onTap: (){authProvider.isLogged ? Navigator.pushNamed(context, 'historial_pedido') : Navigator.pushNamed(context, 'introduccion_login');},)
                                ),
                                Container(
                                width: responsive.wp(30),
                                child: OptionsUser(text: 'Enviado',icon: FontAwesomeIcons.truck,onTap: (){authProvider.isLogged ? Navigator.pushNamed(context, 'historial_pedido') : Navigator.pushNamed(context, 'introduccion_login');},)
                                ),
                                //TODO ver si se va implementar
                              //OptionsUser(text: 'Pendientes de valoración',icon: FontAwesomeIcons.wallet,onTap: (){},),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () async{
                      Dialogs.openLoadingDialogWithText(context, 'Cerrando sesión');
                      await _session.clear();
                      authProvider.isLogged = false;
                      Navigator.pop(context);
                    }, 
                    child: Text('Cerrar Sesión',style: TextStyle(fontSize: responsive.ip(2),fontWeight: FontWeight.w800, color: Colors.white),),
                    color: Style.colorNaranja,
                    padding: EdgeInsets.symmetric(horizontal: responsive.wp(30)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  )
                ],
              ),
            ),
          );
        }
      }
    );
  }
}

class UnloggedUser extends StatelessWidget {
  const UnloggedUser({
    Key key,
    @required Session session,
    @required this.responsive,
    @required this.authProvider,
  }) : _session = session, super(key: key);

  final Session _session;
  final Responsive responsive;
  final ProviderAuth authProvider;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: responsive.hp(4),left: responsive.wp(2), right: responsive.wp(2)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: responsive.wp(5.8),
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        child: Icon(FontAwesomeIcons.userAlt,size: responsive.ip(4.4),color: Colors.white,),
                      ),
                      SizedBox(width: responsive.wp(4),),
                      Container(
                        height: responsive.hp(5),
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          clipBehavior: Clip.antiAlias,
                          elevation: 4,
                          child: FlatButton(
                            color: Colors.white,
                            onPressed: () => Navigator.pushNamed(context, 'introduccion_login'), 
                            child: Text('Identifícate', style: TextStyle(fontSize: responsive.ip(2.2),fontWeight: FontWeight.w800),),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: responsive.hp(4),),
                  Material(
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(2), vertical: responsive.hp(1)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Pedidos', style: TextStyle(fontSize: responsive.ip(2), fontWeight: FontWeight.w800),),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  authProvider.isLogged ? Navigator.pushNamed(context, 'historial_pedido') : Navigator.pushNamed(context, 'introduccion_login');
                                }, 
                                child: Row(
                                  children: <Widget>[
                                    Text('Ver todo', style: TextStyle(color: Colors.black38, fontSize: responsive.ip(1.4)),),
                                    Icon(Icons.chevron_right, size: responsive.ip(1.8),color: Colors.black26,)
                                  ],
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: responsive.hp(1),),
                          Container(
                            height: 1,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          SizedBox(height: responsive.hp(1),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: responsive.wp(30),
                                child: OptionsUser(text: 'Pendientes de pago',icon: FontAwesomeIcons.wallet,onTap: (){authProvider.isLogged ? Navigator.pushNamed(context, 'historial_pedido') : Navigator.pushNamed(context, 'introduccion_login');},)
                                ),
                                Container(
                                width: responsive.wp(30),
                                child: OptionsUser(text: 'Pendientes de envío',icon: FontAwesomeIcons.cartArrowDown,onTap: (){authProvider.isLogged ? Navigator.pushNamed(context, 'historial_pedido') : Navigator.pushNamed(context, 'introduccion_login');},)
                                ),
                                Container(
                                width: responsive.wp(30),
                                child: OptionsUser(text: 'Enviado',icon: FontAwesomeIcons.truck,onTap: (){authProvider.isLogged ? Navigator.pushNamed(context, 'historial_pedido') : Navigator.pushNamed(context, 'introduccion_login');},)
                                ),
                                //TODO ver si se va implementar
                              //OptionsUser(text: 'Pendientes de valoración',icon: FontAwesomeIcons.wallet,onTap: (){},),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}