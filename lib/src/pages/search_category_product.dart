import 'package:ecommerceapp/src/api/empresa_api.dart';
import 'package:ecommerceapp/src/api/producto_api.dart';
import 'package:ecommerceapp/src/models/categoria_subcategoria_model.dart';
import 'package:ecommerceapp/src/provider/provider_busqueda.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:ecommerceapp/src/widgets/producto_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SearchCategoryProductPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final providerBusqueda = Provider.of<ProviderBusqueda>(context);
    final empresaApi = EmpresaApi();
    final productoApi = ProductoApi();
    final responsive = Responsive(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.colorMorado,
        centerTitle: true,
        title: Text('${providerBusqueda.categoriaActual.nomCat}',overflow: TextOverflow.ellipsis,),
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: empresaApi.getCategoriaSubcategoria(context),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  List<CategoriaSubCategoria> subcategorias = snapshot.data;
                  CategoriaSubCategoria subCategoria;
                  if(providerBusqueda.categoriaActual != null){
                    for(CategoriaSubCategoria item in subcategorias){
                      if(item.codCtg == providerBusqueda.categoriaActual.codCat){
                        subCategoria = item;
                      }
                    }
                  }
                  return Wrap(
                    children: List.generate(subCategoria.subCtgsLvl1.length, (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                      child: Chip(backgroundColor: Style.colorNaranja, label: Text('${subCategoria.subCtgsLvl1[index].nomSubctg}', style: TextStyle(color: Colors.white,fontSize: responsive.ip(1.6),fontWeight: FontWeight.w800),)),
                    ))
                  );
                }else{
                  return Center(child: Text('No existen subcategoria para ${providerBusqueda.categoriaActual.nomCat}'),);
                }
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
          SizedBox(height: responsive.hp(2),),
          FutureBuilder(
            future: productoApi.getProductsByCategory(context, providerBusqueda.categoriaActual.codCat),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  final productos = snapshot.data; 
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(productos.length, (index) => ProductoItem(producto: productos[index])),
                    ),
                  );
                }else{
                  return Center(child: Text('No existen productos en esta categoría'),);
                }
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          )
        ],
      )
    );
  }
}