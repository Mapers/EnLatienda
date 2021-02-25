import 'package:ecommerceapp/src/data/carrito.dart';
import 'package:ecommerceapp/src/data/database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CarritoProvider with ChangeNotifier{

  List<CarritoData> _listaCarrito = [];
  double _subtotal = 0.0;
  String _nombreBox = 'carrito';
  int _cantidadCarrito = 0;

  CarritoDatabase db = new CarritoDatabase();

  Future obtenerTodoCarrito() async{
    var box = await Hive.openBox<CarritoData>(_nombreBox);
    _listaCarrito = box.values.toList();
    cantidadCarrito = _listaCarrito.length;
    notifyListeners();
  }

  CarritoData obtenerCarrito(int index){
    return _listaCarrito[index];
  }

  int get cantidadCarrito {
    return _cantidadCarrito;
  }

  set cantidadCarrito(int value){
    _cantidadCarrito = value;
    notifyListeners();
  }

  Future agregarProductoACarrito(BuildContext context, CarritoData carrito) async{
    var box;
    if(!Hive.isBoxOpen(_nombreBox)){
      box = await Hive.openBox<CarritoData>(_nombreBox);
    }else{
      box = db.obtenerCarritos(context);
    }
    await box.add(carrito);

    _listaCarrito = box.values.toList();
    cantidadCarrito = _listaCarrito.length;
    calcularTotal();
    notifyListeners();
  }

  Future borrarProductoDelCarrito(BuildContext context,int index) async{
    var box;
    if(!Hive.isBoxOpen(_nombreBox)){
      box = await Hive.openBox<CarritoData>(_nombreBox);
    }else{
      box = db.obtenerCarritos(context);
    }
    await box.deleteAt(index);
    _listaCarrito = box.values.toList();
    cantidadCarrito = _listaCarrito.length;
    calcularTotal();
    notifyListeners();
  }

  Future editarProductoDelCarrito(BuildContext context, CarritoData carrito,int index) async{
    var box;
    if(!Hive.isBoxOpen(_nombreBox)){
      box = await Hive.openBox<CarritoData>(_nombreBox);
    }else{
      box = db.obtenerCarritos(context);
    }
    await box.putAt(index, carrito);
    _listaCarrito = box.values.toList();
    cantidadCarrito = _listaCarrito.length;
    calcularTotal();
    notifyListeners();
  }

  double get subtotal => this._subtotal;

  set subtotal(double valor){
    this._subtotal = valor;
  }

  calcularTotal(){
    double total = 0;
    for(CarritoData dato in this._listaCarrito){
      total += double.parse(dato.cantPro) * double.parse(dato.valPrecUnit);
    }
    subtotal = total;
  }

}