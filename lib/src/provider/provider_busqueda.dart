import 'package:ecommerceapp/src/models/categoria_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProviderBusqueda with ChangeNotifier{
  
  Categoria _categoriaActual;

  Categoria get categoriaActual => this._categoriaActual;

  set categoriaActual(Categoria value){
    this._categoriaActual = value;
    notifyListeners();
  }

}