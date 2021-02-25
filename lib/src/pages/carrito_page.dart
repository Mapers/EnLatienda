import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/src/data/carrito.dart';
import 'package:ecommerceapp/src/data/database.dart';
import 'package:ecommerceapp/src/provider/provider_carrito.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class CarritoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final db = new CarritoDatabase();
    final responsive = new Responsive(context);
    final carritoProvider = Provider.of<CarritoProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Style.colorMorado,
        title: Text('Carrito', style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder(
        future: db.initDb(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            Box box = db.obtenerCarritos(context);
            if(box.length == 0){
              return Center(child: Text('No tiene productos agregados al carrito'),);
            }else{
              return Container(
                height: responsive.hp(100),
                child: Stack(
                        children: <Widget>[
                          Container(
                            height: responsive.hp(75),
                            child: _CarritoItems(db: db)
                          ),
                          Positioned(
                            bottom: responsive.hp(6),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: responsive.wp(2), vertical: responsive.hp(0.5)),
                              width: responsive.wp(98),
                              height: responsive.hp(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Card(
                                elevation: 4,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(responsive.wp(2)),
                                  child: ValueListenableBuilder(
                                    valueListenable: box.listenable(),
                                    builder: (context,box,widget){
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          _ItemDetalle(texto: 'Subtotal',precio: 'S/.${db.obtenerSubtotal()}0'),
                                          _ItemDetalle(texto: 'Delivery',precio: 'S/.6.00'),
                                          _ItemDetalle(texto: 'Total', precio: 'S/.${db.obtenerSubtotal() + 6}0',esNegrita: true,)
                                        ],
                                      );
                                    }
                                  ),
                                ),
                              ),
                            )
                          ),
                          Positioned( 
                            bottom: 0,
                            child: Container(
                              width: responsive.wp(100),
                              height: responsive.hp(6),
                              child: FlatButton(
                                onPressed: (){},
                                child: Container(
                                  child: Center(child: Text('Realizar Pago',style: TextStyle(color: Colors.white, fontSize: responsive.ip(2)),))
                                ),
                                color: Style.colorNaranja,
                              ),
                            )
                          )
                        ],
                      ),
              );
            }
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      )
    );
  }
}

class _ItemDetalle extends StatelessWidget {

  String texto;
  String precio;
  bool esNegrita;

  _ItemDetalle({@required this.texto,@required this.precio, this.esNegrita = false});

  @override
  Widget build(BuildContext context) {

    final responsive = new Responsive(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
         Text('$texto', style: TextStyle(fontWeight: esNegrita ? FontWeight.bold : FontWeight.w500,fontSize: responsive.ip(1.7))),
         Text('$precio', style: TextStyle(fontSize: responsive.ip(1.7)),),
      ],
    );
  }
}

class _CarritoItems extends StatefulWidget {

  final CarritoDatabase db;

  const _CarritoItems({this.db});

  @override
  __CarritoItemsState createState() => __CarritoItemsState();
}

class __CarritoItemsState extends State<_CarritoItems> {

  @override
  void dispose() {
    super.dispose();
    widget.db.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final responsive = new Responsive(context);
    final carritoProvider = Provider.of<CarritoProvider>(context);
    final db = widget.db;
    Box box = db.obtenerCarritos(context);

    return ListView.builder(
                  itemCount: box.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    CarritoData item = box.getAt(index);
                    return Container(
                      margin: EdgeInsets.all(responsive.wp(2)),
                      height: responsive.hp(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(responsive.wp(2)),
                      ),
                      child: Card(
                        elevation: 2,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: responsive.wp(32),
                              child: CachedNetworkImage(
                                imageUrl: item.imgProd,
                                fadeInCurve: Curves.easeInOut,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Container(child: Center(child: Icon(Icons.image,size: responsive.ip(8),))),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(responsive.wp(2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: responsive.wp(48),
                                        height: responsive.hp(5),
                                        child: Text(
                                          '${item.nomProd}',
                                          overflow: TextOverflow.ellipsis, 
                                          maxLines: 2,
                                          style: TextStyle(fontSize: responsive.ip(1.6), fontWeight: FontWeight.w600),
                                        )
                                      ),
                                      SizedBox(width: responsive.wp(3),),
                                      GestureDetector(
                                        child: Icon(Icons.close,color: Colors.redAccent), 
                                        onTap: (){
                                          db.eliminarProductoCarrito(index);
                                        }
                                      )
                                    ],
                                  ),
                                  SizedBox(height: responsive.hp(1),),
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          int cantidad = int.parse(item.cantPro);
                                          if(cantidad >1){
                                            cantidad = cantidad-1;
                                            item.cantPro = cantidad.toString();
                                            db.actualizarCarrito(index,item);
                                            carritoProvider.subtotal = db.obtenerSubtotal();
                                          }
                                        },
                                        child: Icon(FontAwesomeIcons.minusCircle,color: Color(0xFFFF6601),size: responsive.ip(1.7),)
                                      ),
                                      SizedBox(width: responsive.wp(2),),
                                      ValueListenableBuilder(
                                        valueListenable: box.listenable(),
                                        builder:(context,box,widget){
                                          return Container(alignment: Alignment.center, width: responsive.wp(8), child: Text('${item.cantPro}',style: TextStyle(color: Colors.blueAccent, fontSize: responsive.ip(1.9)),));
                                        }
                                      ),
                                      SizedBox(width: responsive.wp(2),),
                                      GestureDetector(
                                        onTap: (){
                                          int cantidad = int.parse(item.cantPro);
                                          cantidad = cantidad+1;
                                          item.cantPro = cantidad.toString();
                                          db.actualizarCarrito(index,item);
                                          carritoProvider.subtotal = db.obtenerSubtotal();
                                        },
                                        child: Icon(FontAwesomeIcons.plusCircle,color: Color(0xFFFF6601),size: responsive.ip(1.7))
                                      ),
                                      SizedBox(width: responsive.wp(7),)
                                    ],
                                  ),
                                  Spacer(),
                                  ValueListenableBuilder(
                                    valueListenable: box.listenable(),
                                    builder:(context,box,widget){
                                      double precio = double.parse(item.cantPro) * double.parse(item.valPrecUnit);
                                      var f = new NumberFormat('###.0#');
                                      return Container(
                                        margin: EdgeInsets.only(right: responsive.wp(7),bottom: responsive.hp(0.7)),
                                        alignment: Alignment.centerRight, 
                                        width: responsive.wp(25), 
                                        child: Text('S/.${f.format(precio)}0',style: TextStyle(color: Colors.blueAccent, fontSize: responsive.ip(1.9)),)
                                      );
                                  }
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                );
  }
}