import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Session{
  final key = 'SESSION';
  final storage = new FlutterSecureStorage();

  set(String token, String refreshToken, int expiresIn, String email, String password, int codUsu,String name, String lastName,String direction,String phone) async{
    final data = {
      'email' : email,
      'password' : password,
      'codUsu': codUsu,
      'token' : token,
      'refreshToken' : refreshToken,
      'expiresIn' : expiresIn,
      'createdAt' : DateTime.now().toString(),
      'name' : name,
      'lastName' : lastName,
      'direccion' : direction,
      'phone' : phone
    };
    await storage.write(key: key, value: jsonEncode(data));
  }

  get() async{
    final result = await storage.read(key: key);
    if(result != null){
      return jsonDecode(result);
    }
    return null;
  }

  clear() async{
    await storage.deleteAll();
  }
}