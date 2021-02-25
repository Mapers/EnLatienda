import 'package:ecommerceapp/src/utils/session.dart';
import 'package:flutter/material.dart';

class ProviderAuth with ChangeNotifier{

  bool _isLogged = false;
  // Session _session = Session();
  // Map<String,dynamic> _data = {};

  bool get isLogged => this._isLogged;

  set isLogged(bool value){
    this._isLogged = value;
    notifyListeners();
  }

  // Map<String,dynamic> get data => this._data;

  // set data(Map<String,dynamic> value){
  //   this._data = data;
  // }
}