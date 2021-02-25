import 'package:ecommerceapp/src/models/carrousel_model.dart';
import 'package:ecommerceapp/src/models/categoria_model.dart';
import 'package:ecommerceapp/src/models/categoria_subcategoria_model.dart';
import 'package:ecommerceapp/src/models/empresa_model.dart';
import 'package:ecommerceapp/src/models/mensaje_informativo_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../app_config.dart';

class EmpresaApi{

  Future<List<Empresa>> getBusiness(BuildContext context) async{
    final url = '${AppConfig.apiHost}/companies';

    return Future<List<Empresa>>.sync(() {
      return http.get(url).then((response){
        final empresaResponse = empresaFromJson(response.body);
        return empresaResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
  }

  Future<Empresa> getBusinessByRuc(BuildContext context, String ruc) async{
    final url = '${AppConfig.apiHost}/companies/$ruc';

    return Future<Empresa>.sync(() {
      return http.get(url).then((response){
        final empresaResponse = empresaFromJson(response.body);
        return empresaResponse[0]??null;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
  }

  Future<List<Carrousel>> getCarrousel(BuildContext context) async{
    final url = '${AppConfig.apiHost}/carousel/${AppConfig.codigoEmpresa}';

    return Future<List<Carrousel>>.sync(() {
      return http.get(url).then((response){
        final carrouselResponse = carrouselFromJson(response.body);
        return carrouselResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
  }

  Future<MensajeInformativo> getMensajeInformativo(BuildContext context) async{
    final url = '${AppConfig.apiHost}/messagebox/${AppConfig.codigoEmpresa}';

    return Future<MensajeInformativo>.sync(() {
      return http.get(url).then((response){
        final mensajeResponse = mensajeInformativoFromJson(response.body);
        return mensajeResponse;
      }).catchError((onError){
        return null;
        print(onError.toString());
      });
    }).catchError((onError){
      return null;
        print(onError.toString());
    });
  }

  Future<List<Categoria>> getCategoria(BuildContext context) async{
    final url = '${AppConfig.apiHost}/categories/${AppConfig.codigoEmpresa}';

    return Future<List<Categoria>>.sync(() {
      return http.get(url).then((response){
        final categoriaResponse = categoriaFromJson(response.body);
        return categoriaResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
  }

  Future<List<CategoriaSubCategoria>> getCategoriaSubcategoria(BuildContext context) async{
    final url = '${AppConfig.apiHost}/categories/${AppConfig.codigoEmpresa}/subcategories';

    return Future<List<CategoriaSubCategoria>>.sync(() {
      return http.get(url).then((response){
        final categoriaSubcategoriaResponse = categoriaSubCategoriaFromJson(response.body);
        return categoriaSubcategoriaResponse;
      }).catchError((onError){
        print(onError.toString());
      });
    }).catchError((onError){
        print(onError.toString());
    });
  }

}