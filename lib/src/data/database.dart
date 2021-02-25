import 'package:ecommerceapp/src/data/carrito.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class CarritoDatabase {

  Box carritoBox;


  Future<bool> initDb() async{
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path);
    carritoBox = await Hive.openBox('carrito');
    return true;
  }

  Future abrirCarrito() async{
    carritoBox = await Hive.openBox('carrito');
  }

  Future insertarACarrito(CarritoData carritoData)async{
    carritoBox = await Hive.openBox('carrito');
    await carritoBox.add(carritoData);
  }

  int cantidadProductosEnCarrito(){
    return carritoBox.length;
  }

  Box obtenerCarritos(BuildContext context){
    //List<CarritoData> datas = obtenerBoxACarritoData();
    return carritoBox;
  }

  Future actualizarCarrito(int index,CarritoData carritoData) async{
    await carritoBox.putAt(index, carritoData);
  }

  Future eliminarProductoCarrito(int index) async{
    await carritoBox.deleteAt(index);
  }

  double obtenerSubtotal(){
    double subtotal = 0;
    List<CarritoData> datas = obtenerBoxACarritoData();
    for(CarritoData dato in datas){
      subtotal += (int.parse(dato.cantPro) * double.parse(dato.valPrecUnit));
    }
    return subtotal;
  }

  List<CarritoData> obtenerBoxACarritoData(){
    List<CarritoData> datas = new List();
    for(int i=0;i<carritoBox.length;i++){
      datas.add(carritoBox.getAt(i));
    }
    return datas;
  }

  void dispose(){
    carritoBox.close();
  }

}