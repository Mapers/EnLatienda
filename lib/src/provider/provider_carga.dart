import 'package:flutter/foundation.dart';

class ProviderCarga with ChangeNotifier{
  bool _cargando = false;

  bool get cargando => this._cargando;

  set cargando(bool value){
    this._cargando = value;
    notifyListeners();
  }
}