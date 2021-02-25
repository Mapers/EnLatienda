import 'package:ecommerceapp/src/api/producto_api.dart';
import 'package:ecommerceapp/src/models/detalle_producto_model.dart';
import 'package:ecommerceapp/src/models/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProductoSeleccionadoProvider with ChangeNotifier{

  final _productoApi = new ProductoApi();

  var _producto;

  DetalleProducto _detalleProducto;

  bool _loading = false;

  Producto get producto => this._producto;

  set producto(Producto valor){
    this._producto = valor;
    notifyListeners();
  }

  DetalleProducto get detalleProducto => this._detalleProducto;

  set detalleProducto(DetalleProducto valor){
    this._detalleProducto = valor;
    notifyListeners();
  }

  bool get loading => this._loading;

  set loading(bool valor){
    this._loading = valor;
  }

  Future<bool> obtenerDetalleProducto(BuildContext context) async{
    loading = true;
    final detalle =  await _productoApi.getDetailProduct(context, producto.codProd);
    loading = false;
    notifyListeners();
    if(detalle != null){
      detalleProducto = detalle;
      return true;
    }
    return false;

  }

}