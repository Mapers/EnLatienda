import 'package:ecommerceapp/src/data/carrito.dart';
import 'package:ecommerceapp/src/pages/carrito_page.dart';
import 'package:ecommerceapp/src/pages/detalle_producto_page.dart';
import 'package:ecommerceapp/src/pages/historial_pedidos_page.dart';
import 'package:ecommerceapp/src/pages/home_page.dart';
import 'package:ecommerceapp/src/pages/introduction_login_page.dart';
import 'package:ecommerceapp/src/pages/login_page.dart';
import 'package:ecommerceapp/src/pages/mi_cuenta_page.dart';
import 'package:ecommerceapp/src/pages/productos_page.dart';
import 'package:ecommerceapp/src/pages/register_page.dart';
import 'package:ecommerceapp/src/pages/route_page.dart';
import 'package:ecommerceapp/src/pages/search_category_product.dart';
import 'package:ecommerceapp/src/pages/splash_page.dart';
import 'package:ecommerceapp/src/provider/provider_auth.dart';
import 'package:ecommerceapp/src/provider/provider_busqueda.dart';
import 'package:ecommerceapp/src/provider/provider_carga.dart';
import 'package:ecommerceapp/src/provider/provider_carrito.dart';
import 'package:ecommerceapp/src/provider/provider_empresa.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'src/provider/provider_producto_seleccionado.dart';
 
void main(){
  Hive.registerAdapter(CarritoDataAdapter());
  runApp(MyApp());
}

Future _initHive() async{
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>  new ProductoSeleccionadoProvider()),
        ChangeNotifierProvider(create: (_) => new CarritoProvider()),
        ChangeNotifierProvider(create: (_) => new ProviderCarga()),
        ChangeNotifierProvider(create: (_) => new ProviderAuth()),
        ChangeNotifierProvider(create: (_) => new ProviderEmpresa()),
        ChangeNotifierProvider(create: (_) => new ProviderBusqueda())
      ],
      child: MaterialApp(
        title: 'Ecommerce App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        routes: {
          'splash' : (BuildContext context) => FutureBuilder(
            future: _initHive(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.error != null){
                  print(snapshot.error);
                  return Scaffold(
                    body: Center(
                      child: Text('Error al inicializar los datos,intente otra vez'),
                    ),
                  );
                }else{
                  return SplashPage();
                }
              }else{
                return Scaffold();
              }
            },
          ),
          'login'   : (BuildContext context) => new LoginPage(),
          'register'   : (BuildContext context) => new RegisterPage(),
          'home'   : (BuildContext context) => new HomePage(),
          'producto' : (BuildContext context) => new ProductoPage(),
          'route'  : (BuildContext context) => new RoutePage(),
          'detalle_producto' : (BuildContext context) => DetalleProductoPage(),
          'carrito' : (BuildContext context) => new CarritoPage(),
          'introduccion_login' : (BuildContext context) => new IntroductionLoginPage(),
          'search_category' : (BuildContext context) => new SearchCategoryProductPage(),
          'mi_cuenta' : (BuildContext context) => new MiCuentaPage(),
          'historial_pedido' : (BuildContext context) => new HistorialPedidoPage(),
        }, 
      ),
    );
  }
}
