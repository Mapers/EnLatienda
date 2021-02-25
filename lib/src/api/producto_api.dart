

import 'package:ecommerceapp/src/models/categoria_model.dart';
import 'package:ecommerceapp/src/models/comentario_model.dart';
import 'package:ecommerceapp/src/models/detalle_producto_model.dart';
import 'package:ecommerceapp/src/models/producto_busqueda.dart';
import 'package:ecommerceapp/src/models/producto_model.dart';
import 'package:ecommerceapp/src/utils/dialogs.dart';
import 'package:flutter/material.dart';

import '../../app_config.dart';
import 'package:http/http.dart' as http;

class ProductoApi{

  Future<List<Producto>> getAllProducts(BuildContext context) async{
    final url = '${AppConfig.apiHost}/products/${AppConfig.codigoEmpresa}';

    return Future<List<Producto>>.sync(() {
      return http.get(url).then((response){
        final productoResponse = productoFromJson(response.body);
        return productoResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
      // try{
      //   if(response.statusCode == 200){
      //     return parsed;
      //   }else if(response.statusCode == 403){
      //     throw PlatformException(code: '403', message: parsed['message']);
      //   }else if(response.statusCode == 500){
      //     throw PlatformException(code: '500', message: parsed['message']);
      //   }
      //   throw PlatformException(code: '500', message: parsed['error: /user-info']);

      // }on PlatformException catch(e){
      //   print('error getUserInfo: ${e.message}');
      //   Dialogs.alert(context, title: 'Error', message: e.message);
      //   return null;
      // }
  }

  Future<List<Producto>> getNewProducts(BuildContext context) async{
    final url = '${AppConfig.apiHost}/products/${AppConfig.codigoEmpresa}/news';

    return Future<List<Producto>>.sync(() {
      return http.get(url).then((response){
        final productoResponse = productoFromJson(response.body);
        return productoResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
  }

  Future<List<Producto>> getSimilarProducts(BuildContext context,int codProducto) async{
    final url = '${AppConfig.apiHost}/products/${AppConfig.codigoEmpresa}/similar/$codProducto';

    return Future<List<Producto>>.sync(() {
      return http.get(url).then((response){
        final productoResponse = productoFromJson(response.body);
        return productoResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
  }

  Future<List<Producto>> searchProduct(BuildContext context, String producto) async{
    try{
      final url = '${AppConfig.apiHost}/products/${AppConfig.codigoEmpresa}/search/$producto';
      print('URL de busqueda de producto => $url');

      final response = await http.get(
        url,
          // headers: {
          //   'token' : token
          // }
      );
      print('buscarProducto => palabra enviada:$producto ,  resultadoObtenido: ${response.body}');
      final productResponse = productoFromJson(response.body);

      return productResponse;
    }catch(e){
      Dialogs.alert(context,title: 'Error', message: 'Se obtuvo el error ${e.toString()}');
    }

  }

  Future<List<Comment>> getComments(BuildContext context, int idProducto) async{
    try{
      final url = '${AppConfig.apiHost}/products/$idProducto/comments';
      print('URL de busqueda de producto => $url');

      final response = await http.get(
        url,
          // headers: {
          //   'token' : token
          // }
      );
      print('buscarProducto => palabra enviada:$idProducto ,  resultadoObtenido: ${response.body}');
      final comentarioResponse = comentarioFromJson(response.body);

      return comentarioResponse.comments;
    }catch(e){
      Dialogs.alert(context,title: 'Error', message: 'Se obtuvo el error ${e.toString()}');
    }

  }

  Future<DetalleProducto> getDetailProduct(BuildContext context, int idProducto) async{
    final url = '${AppConfig.apiHost}/products/${AppConfig.codigoEmpresa}/details/$idProducto';
    return Future<DetalleProducto>.sync(() {
      return http.get(url).then((response){
        final detalleResponse = detalleProductoFromJson(response.body);
        return detalleResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });

  }

  Future<List<Producto>> getProductsByCategory(BuildContext context, int codCategoria) async{
    final url = '${AppConfig.apiHost}/products/${AppConfig.codigoEmpresa}/category/$codCategoria';

    return Future<List<Producto>>.sync(() {
      return http.get(url).then((response){
        final productoResponse = productoFromJson(response.body);
        return productoResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
  }

  Future<List<Producto>> getProductsBySubcategory(BuildContext context,int level, int idSubCategoria) async{
    final url = '${AppConfig.apiHost}/products/${AppConfig.codigoEmpresa}/category?level=$level&subcat=$idSubCategoria';

    final response = await http.get(
      url,
        // headers: {
        //   'token' : token
        // }
    );

    final productResponse = productoFromJson(response.body);

    return productResponse;

  }

}