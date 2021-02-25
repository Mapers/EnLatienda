import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapp/src/api/empresa_api.dart';
import 'package:ecommerceapp/src/api/producto_api.dart';
import 'package:ecommerceapp/src/data/carrito.dart';
import 'package:ecommerceapp/src/data/database.dart';
import 'package:ecommerceapp/src/models/empresa_model.dart';
import 'package:ecommerceapp/src/models/producto_model.dart';
import 'package:ecommerceapp/src/provider/provider_auth.dart';
import 'package:ecommerceapp/src/provider/provider_carga.dart';
import 'package:ecommerceapp/src/provider/provider_empresa.dart';
import 'package:ecommerceapp/src/provider/provider_producto_seleccionado.dart';
import 'package:ecommerceapp/src/utils/dialogs.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:ecommerceapp/src/widgets/producto_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';


class DetalleProductoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProductoSeleccionadoProvider>(context);

    return Scaffold(
      body: provider.loading ? Center(child: CircularProgressIndicator(),) : 
      FutureBuilder<bool>(
        future: provider.obtenerDetalleProducto(context),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.data == null){
            return Center(child: CircularProgressIndicator());
          }else{
            if(snapshot.data){
              return Container(
                child: _DetalleProducto()
              );
            }else{
              return Center(
                child: Text('Error, vuelva a intentarlo'),
              );
            }
          }
        },
      ),
    );
  }
}

class _DetalleProducto extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final providerProducto = Provider.of<ProductoSeleccionadoProvider>(context);
    final providerLocal = Provider.of<ProviderCarga>(context);
    final responsive = new Responsive(context);
    final productoApi = ProductoApi();

    void _onButtonPressed()async{
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return Container(
          color: Color(0xFF737373),
          child: Container(
            child: _BottomNavigationMenu(),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              )
            ),
          ),
        );
      }
    );
  }

    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _ImagenProducto(),
              Container(
                padding: EdgeInsets.all(responsive.wp(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      providerProducto.producto.nomProd, 
                      style: TextStyle(fontSize: responsive.ip(2.2), fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: responsive.hp(1.5),),
                    Text(
                      'Codigo: FW511948218',
                      style: TextStyle(fontSize: responsive.ip(1.6), color: Colors.grey.withOpacity(0.8)),
                    ),
                    SizedBox(height: responsive.hp(1.5),),
                    Text(
                      'Stock disponible',
                      style: TextStyle(fontSize: responsive.ip(1.8), color: Colors.black54, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: responsive.hp(2),),
                    Text(
                      'S/. ${providerProducto.producto.precUnidad}',
                      style: TextStyle(fontSize: responsive.ip(2.2), color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: responsive.hp(2),),
                    ExpansionTile(
                      title: Text(
                       'Descripción',
                        style: TextStyle(fontSize: responsive.ip(2.2), color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: responsive.wp(2), right: responsive.wp(2),top: responsive.hp(1),bottom: responsive.hp(1.5)),
                          child: Text('${providerProducto.detalleProducto.descProd ?? 'Este producto no tiene descripción'}'),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.hp(2),),
                    ExpansionTile(
                      title: Text(
                       'Características principales',
                        style: TextStyle(fontSize: responsive.ip(2.2), color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: responsive.wp(2), right: responsive.wp(2),top: responsive.hp(1),bottom: responsive.hp(1.5)),
                          child: providerProducto.detalleProducto.allFeatures != null 
                          ? providerProducto.detalleProducto.allFeatures.length > 0 
                            ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: providerProducto.detalleProducto.allFeatures.length,
                              itemBuilder: (context,index){
                                return Row(
                                  children: <Widget>[
                                    Text('${providerProducto.detalleProducto.allFeatures[index].cabFeature}:'),
                                    Text('${providerProducto.detalleProducto.allFeatures[index].descFeature}'),
                                  ],
                                );
                              }
                            )  : Text('Sin información')
                          : Text('Sin información'),
                        ),
                      ],
                    ),
                    // Text(
                    //   'Características principales',
                    //   style: TextStyle(fontSize: responsive.ip(2.2), color: Colors.black, fontWeight: FontWeight.w600),
                    // ),
                    // Container(
                    //   child: providerProducto.detalleProducto.allFeatures != null 
                    //   ? providerProducto.detalleProducto.allFeatures.length > 0 ? ListView.builder(
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: providerProducto.detalleProducto.allFeatures.length,
                    //     itemBuilder: (context,index){
                    //       return Text('${providerProducto.detalleProducto.allFeatures[index].descFeature}');
                    //     }
                    //   )  : Text('Sin información')
                    //   : Text('Sin información'),
                    // ),
                    SizedBox(height: responsive.hp(2),),
                    Text(
                      'Productos Similares',
                      style: TextStyle(fontSize: responsive.ip(2), color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    FutureBuilder<List<Producto>>(
                      future: productoApi.getSimilarProducts(context,providerProducto.producto.codProd),
                      initialData: [],
                      builder: (context, snapshot) {
                        if(snapshot.data.length == 0){
                            return Container(
                              height: responsive.hp(24),
                              child: Center(
                                child: CircularProgressIndicator(),
                          ),
                            );
                        }else{
                          final productosSimilares = snapshot.data;
                          return Container(
                            height: responsive.hp(24),
                            child: ProductosSimilares(productosSimilares: productosSimilares)
                          );
                        }
                      },
                    ),
                    SizedBox(height: responsive.hp(5),),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: SafeArea(
            child: Container(
              width: responsive.wp(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: responsive.wp(11),
                    width: responsive.wp(50),
                    child: FlatButton(
                      color: Style.colorMorado,
                      onPressed: () => _onButtonPressed(), 
                      child: Text('Añadir a la cesta', style: TextStyle(color: Colors.white,fontSize: responsive.ip(1.5)),)
                    ),
                  ),
                  Container(
                    height: responsive.wp(11),
                    width: responsive.wp(50),
                    child: FlatButton(
                      color: Style.colorNaranja,
                      onPressed: () {
                        final authProvider = Provider.of<ProviderAuth>(context, listen: false);
                        if(authProvider.isLogged){
                          Dialogs.alert(context,title: 'Alerta', message: 'Aun no se encuentra implementado');
                        }else{
                          Navigator.pushNamed(context, 'introduccion_login');
                        }
                      }, 
                      child: Text('Comprar ahora',style: TextStyle(color: Colors.white, fontSize: responsive.ip(1.5)),)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        providerLocal.cargando ? Center(child: CupertinoActivityIndicator()) : Container()
      ],
    );
  }
}

class ProductosSimilares extends StatelessWidget {
  const ProductosSimilares({
    Key key,
    @required this.productosSimilares,
  }) : super(key: key);

  final List<Producto> productosSimilares;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productosSimilares.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => ProductoItem(producto: productosSimilares[index],isDetailPage: true,),
    );
  }
}

class _BottomNavigationMenu  extends StatefulWidget {

  @override
  __BottomNavigationMenuState createState() => __BottomNavigationMenuState();
}

class __BottomNavigationMenuState extends State<_BottomNavigationMenu> {

  int selectedIndex = 0;
  int cantidadProducto = 1;
  // CarritoApi _carritoApi = new CarritoApi();
  CarritoDatabase _db = new CarritoDatabase();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerProducto = Provider.of<ProductoSeleccionadoProvider>(context);
    final providerLocal = Provider.of<ProviderCarga>(context);
    final empresaApi = EmpresaApi();
    final providerEmpresa = Provider.of<ProviderEmpresa>(context);
    //final providerCarrito = Provider.of<CarritoProvider>(context);
    final responsive = new Responsive(context);
    return Container(
      height: responsive.hp(60),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(responsive.wp(4)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CachedNetworkImage(
                      height: responsive.hp(20),
                      width: responsive.wp(40),
                      imageUrl: providerProducto.detalleProducto.images[0].url,
                      placeholder: (context,url) => Container(height: responsive.hp(20),child: Center(child: CircularProgressIndicator(backgroundColor: Colors.deepPurple))),
                      errorWidget: (context, url, error) => Container(height: responsive.hp(20), child: Image(image: AssetImage('assets/empty_product.png'))),
                      fit: BoxFit.fill,
                    ),
                    Text('S/. ${providerProducto.detalleProducto.unitPrices[selectedIndex].valPrecUnit} / ${providerProducto.detalleProducto.unitPrices[selectedIndex].cantUnit} unidad(es)', style: TextStyle(fontSize: responsive.ip(1.6), fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: responsive.hp(2),),
                Container(
                  height: responsive.hp(5),
                  child: ListView.builder(
                    itemCount: providerProducto.detalleProducto.unitPrices.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          width: responsive.wp(30),
                          height: responsive.hp(5),
                          child: Text('${providerProducto.detalleProducto.unitPrices[index].descUnit}'),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                            border: selectedIndex == index ? Border.all(width: 1.5, color: Colors.deepOrange) : Border.all(width: 0)
                          ),
                        ),
                      );
                    }
                  ),
                ),
                SizedBox(height: responsive.hp(2),),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: responsive.wp(3)),
                  child: Text('Cantidad', style: TextStyle(fontSize: responsive.ip(1.6)),)
                ),
                SizedBox(height: responsive.hp(1),),
                Padding(
                  padding: EdgeInsets.only(left: responsive.wp(3)),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: cantidadProducto <= 1 ? null :  _decrementar, 
                        child: Icon(FontAwesomeIcons.minusCircle,color: Colors.blueGrey,size: responsive.ip(1.7),)
                      ),
                      SizedBox(width: responsive.wp(3),),
                      Container(alignment: Alignment.center, width: responsive.wp(8), child: Text('$cantidadProducto',style: TextStyle(color: Colors.blueAccent, fontSize: responsive.ip(1.9)),)),
                      SizedBox(width: responsive.wp(3),),
                      GestureDetector(
                        onTap: _incrementar, 
                        child: Icon(FontAwesomeIcons.plusCircle,color: Colors.blueGrey,size: responsive.ip(1.7))
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: responsive.wp(100),
            height: responsive.hp(5),
            child: FlatButton(
              onPressed: () async {
                providerLocal.cargando = true;
                CarritoData carritoData = new CarritoData();
                carritoData.codProd = providerProducto.producto.codProd;
                carritoData.cantPro = cantidadProducto.toString();
                carritoData.nomProd = providerProducto.producto.nomProd;
                carritoData.codUniPrec = providerProducto.detalleProducto.unitPrices[selectedIndex].codUniPrice;
                carritoData.codEmp = providerProducto.producto.codEmp;
                carritoData.descUniProd = providerProducto.detalleProducto.descProd;
                carritoData.valPrecUnit = providerProducto.detalleProducto.unitPrices[selectedIndex].valPrecUnit;
                carritoData.imgProd = providerProducto.producto.images[0].url ?? '';
                // carritoData.rucEmp = providerProducto.producto.rucEmp;
                // if(providerEmpresa.empresaActual != null){
                //   carritoData.nombreEmp = providerEmpresa.empresaActual.razonSocial;
                // }else{
                //   final empresa = await empresaApi.getBusinessByRuc(context, providerProducto.producto.rucEmp);
                //   carritoData.nombreEmp = empresa.razonSocial;
                // }
                await _db.insertarACarrito(carritoData);
                providerLocal.cargando = false;
                // await _db.insertarACarrito(context,carritoData);
                //await _carritoApi.guardarProducto(context, providerProducto.producto.codProd.toString(), cantidadProducto, providerProducto.detalleProducto.unitPrices[selectedIndex].codUniPrice);
                Navigator.pop(context,'ok');
              }, 
              color: Colors.deepOrange,
              child: Text('CONTINUAR', style: TextStyle(color: Colors.white, fontSize: responsive.ip(1.5) ),),
            ),
          ),
        ],
      ),
    );
  }

  void _incrementar(){
    cantidadProducto++;
    setState(() {
    });
  }

  void _decrementar(){
    cantidadProducto--;
    setState(() {
    });
  }
}

class _ImagenProducto extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final detalleProducto = Provider.of<ProductoSeleccionadoProvider>(context).detalleProducto;
    final db = new CarritoDatabase();
    final responsive = new Responsive(context);
    return Container(
      width: responsive.wp(100),
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            CarouselSlider.builder(
              itemCount: detalleProducto.images.length, 
              itemBuilder: (context,index) {
                return CachedNetworkImage(
                  width: responsive.wp(100),
                  imageUrl: detalleProducto.images[index].url,
                  placeholder: (context,url) => Center(child: CircularProgressIndicator(backgroundColor: Colors.deepPurple)),
                  errorWidget: (context, url, error) => Image(image: AssetImage('assets/empty_product.png'),),
                  fit: BoxFit.contain,
                );
              }, 
              options: CarouselOptions(
                height: responsive.hp(25),
                autoPlay: detalleProducto.images.length == 1 ? false : true,
                autoPlayCurve: Curves.easeInOut,
                autoPlayInterval: Duration(seconds: 5),
                viewportFraction: 1,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
              )
            ),
            Positioned(
              top: responsive.hp(0.8),
              left: responsive.wp(5),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: FaIcon(FontAwesomeIcons.chevronLeft, color: Style.colorMorado, size: responsive.ip(2.5),)
              )
            ),
            Positioned(
              top: responsive.hp(0.8),
              right: responsive.wp(5),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'carrito'),
                child: FaIcon(FontAwesomeIcons.shoppingCart, color: Style.colorMorado,size: responsive.ip(2.5))
              )
            ),
            FutureBuilder(
              future: db.abrirCarrito(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  Box box = db.obtenerCarritos(context);
                  return ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, value, child) {
                      return Positioned(
                        top: 0,
                        right: responsive.wp(3),
                        child: db.cantidadProductosEnCarrito() > 0? CircleAvatar(
                          maxRadius: responsive.wp(2.5),
                          backgroundColor: Style.colorNaranja,
                          child: Text('${db.cantidadProductosEnCarrito()}', style: TextStyle(color: Colors.white, fontSize: responsive.ip(1.2)),),
                        ) : Container()
                      );
                    },
                  );
                }else{
                  return Container();
                }
              }
            )
          ],
        ),
      ),
    );
  }
}

