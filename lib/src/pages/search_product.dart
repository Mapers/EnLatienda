import 'package:ecommerceapp/src/api/producto_api.dart';
import 'package:ecommerceapp/src/widgets/producto_item_widget.dart';
import 'package:flutter/material.dart';

class SearchProduct extends SearchDelegate{

  String seleccion = '';
  final productoApi = new ProductoApi();

  @override
  String get searchFieldLabel => 'Buscar producto';

  final productos = [
    'Arroz',
    'Lavadora'
    'Celular',
    'Laptop'
    'Pelota'
  ];

  final productosRecientes = [
    'Lavadora',
    'Pelota'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear), 
          onPressed: (){
            query = '';
          }
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, 
          progress: transitionAnimation
        ), 
        onPressed: (){
          close(context, null);
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      if(query.trim().isEmpty){
        return Container();
      }

      return FutureBuilder(
        future: productoApi.searchProduct(context, query),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final productos = snapshot.data; 
            return GridView.count(
              crossAxisCount: 2,
              children: List.generate(productos.length, (index) => ProductoItem(producto: productos[index])),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }

}