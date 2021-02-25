import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/app_config.dart';
import 'package:ecommerceapp/src/models/producto_model.dart';
import 'package:ecommerceapp/src/pages/detalle_producto_page.dart';
import 'package:ecommerceapp/src/provider/provider_producto_seleccionado.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProductoItem extends StatefulWidget {

  final Producto producto;
  final bool isDetailPage;

  const ProductoItem({Key key,@required this.producto,this.isDetailPage = false}) : super(key: key);

  @override
  _ProductoItemState createState() => _ProductoItemState();
}

class _ProductoItemState extends State<ProductoItem> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = new Responsive(context);
    return GestureDetector(
      onTap: (){
        final provider = Provider.of<ProductoSeleccionadoProvider>(context,listen: false);
        provider.producto = widget.producto;
        if(!widget.isDetailPage){
          Navigator.of(context).pushNamed('detalle_producto');
        }
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 4,
        child: Container(
          width: responsive.wp(40),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  height: size.height * 0.15,
                  imageUrl: widget.producto.images.length > 0 ? widget.producto.images[0].url : AppConfig.defaultImage,
                  placeholder: (context, url) => Container(
                    height: size.height * 0.15,
                    child: Center(child: CircularProgressIndicator())
                  ),
                  errorWidget: (context,url,error) {
                    return Container(
                      height: size.height * 0.15,
                      child: Center(child: Image(image: AssetImage('assets/empty_product.png')))
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.producto.nomProd,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black),maxLines: 1,),
                      SizedBox(height: responsive.hp(0.2),),
                      Text('S/. ${double.parse(Util.quitarComaNumero(widget.producto.precUnidad)).toStringAsFixed(2)}', style: TextStyle(fontSize: responsive.ip(1.65)),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}