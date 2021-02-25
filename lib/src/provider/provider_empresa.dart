import 'package:ecommerceapp/src/api/empresa_api.dart';
import 'package:ecommerceapp/src/models/empresa_model.dart';
import 'package:flutter/material.dart';

class ProviderEmpresa with ChangeNotifier{

  Empresa _empresaActual;

  bool _isLoading = false;
  EmpresaApi _empresaApi = EmpresaApi();
  
  Empresa get empresaActual => this._empresaActual;

  set empresaActual(Empresa value){
    this._empresaActual = value;
    notifyListeners();
  }

  bool get isLoading => this._isLoading;

  set isLoading(bool value){
    this._isLoading = value;
  }

  Future<bool> obtenerDataEmpresa(BuildContext context) async{
    isLoading = true;
    await _empresaApi.getCarrousel(context);
    isLoading = false;
    notifyListeners();
    return true;
  }

}