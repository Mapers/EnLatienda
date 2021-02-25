import 'package:any_widget_marquee/any_widget_marquee.dart';
import 'package:ecommerceapp/app_config.dart';
import 'package:ecommerceapp/src/models/empresa_model.dart';
import 'package:ecommerceapp/src/models/mensaje_informativo_model.dart';
import 'package:ecommerceapp/src/pages/search_product.dart';
import 'package:ecommerceapp/src/provider/provider_busqueda.dart';
import 'package:ecommerceapp/src/provider/provider_empresa.dart';
import 'package:ecommerceapp/src/utils/dialogs.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapp/src/api/carrito_api.dart';
import 'package:ecommerceapp/src/api/empresa_api.dart';
import 'package:ecommerceapp/src/api/producto_api.dart';
import 'package:ecommerceapp/src/data/database.dart';
import 'package:ecommerceapp/src/models/carrousel_model.dart';
import 'package:ecommerceapp/src/models/categoria_model.dart';
import 'package:ecommerceapp/src/models/producto_model.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerceapp/src/widgets/producto_item_widget.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin {
  final productoApi = new ProductoApi();
  final carritoApi = new CarritoApi();
  final empresaApi = new EmpresaApi();
  final db = new CarritoDatabase();

  @override
  Widget build(BuildContext context) {

    final responsive = new Responsive(context);
    final size = MediaQuery.of(context).size;
    final providerEmpresa = Provider.of<ProviderEmpresa>(context);

    return providerEmpresa.isLoading ? Center(child: CircularProgressIndicator(),) :
     Scaffold(
        body: Stack(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height * 0.23,
                  color: Style.colorMorado,
                ),
                Container(
                  height: size.height,
                  child: ListView(
                    children: [
                      SafeArea(
                      child: SizedBox(
                        height: size.height,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: responsive.hp(1),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(width: responsive.wp(2),),
                                GestureDetector(
                                  onTap: ()async{
                                    Dialogs.openLoadingDialogWithText(context, 'Cargando información');
                                    List<Empresa> dataEmpresa = await empresaApi.getBusiness(context);  
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Lista de empresas'),
                                          content: SetupAlertDialoadContainer(datoEmpresas: dataEmpresa,),
                                        );
                                      }
                                    );
                                  },
                                  child: FaIcon(Icons.business, color: Colors.white,size: responsive.ip(2.5),)
                                ),
                                SizedBox(width: responsive.wp(1),),
                                Container(
                                  width: responsive.wp(65),
                                  height: responsive.hp(5),
                                  child: Image(image: AssetImage('assets/logo-white.png')) //FadeInImage(placeholder:AssetImage('assets/logo-dark.png') ,image: AssetImage('assets/logo-white.png'),fadeOutDuration: Duration(milliseconds: 500),fadeInDuration: Duration(milliseconds: 500),)
                                ),
                                // Container(
                                //   width: responsive.wp(75),
                                //   height: responsive.hp(5),
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(15)
                                //   ),
                                //   child: Row(
                                //     children: <Widget>[
                                //       SizedBox(width: 5,),
                                //       FaIcon(FontAwesomeIcons.search, color: Colors.black26,size: responsive.ip(2.1),),
                                //       SizedBox(width: 10,),
                                //       Text('Buscar productos', style: TextStyle(fontSize: responsive.ip(1.7),color: Colors.black38),)
                                //     ],
                                //   ),
                                // ),
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.search,color: Colors.white, size: responsive.ip(2.5)), 
                                  onPressed: () => showSearch(context: context,delegate: SearchProduct())
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(context, 'carrito'),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: responsive.wp(1.5)),
                                        width: responsive.wp(9),
                                        height: responsive.wp(10),
                                        alignment: Alignment.center,
                                        child: FaIcon(
                                          FontAwesomeIcons.shoppingCart, 
                                          color: Colors.white,
                                          size: responsive.ip(2.5),
                                        )
                                      ),
                                      FutureBuilder(
                                        future: db.abrirCarrito(),
                                        builder: (context, snapshot) {
                                          if(snapshot.connectionState == ConnectionState.done){
                                            Box box = db.obtenerCarritos(context);
                                            return ValueListenableBuilder(
                                              valueListenable: box.listenable(),
                                              builder: (context, box, child) {
                                                return Positioned(
                                                  top: 0,
                                                  right: responsive.wp(1),
                                                  child: db.cantidadProductosEnCarrito() > 0? CircleAvatar(
                                                    maxRadius: responsive.wp(2.5),
                                                    backgroundColor: Colors.red,
                                                    child: Text('${db.cantidadProductosEnCarrito()}', style: TextStyle(color: Colors.white, fontSize: responsive.ip(1.2)),),
                                                  ) : Container()
                                                );
                                              },
                                            );
                                          }else{
                                            return Container();
                                          }
                                        },
                                      )
                                    ],
                                  )
                                ),
                              ],
                            ),
                            _Carousel(),
                            _Categorias(),
                            FutureBuilder<MensajeInformativo>(
                              future: empresaApi.getMensajeInformativo(context),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  if(snapshot.hasData){
                                    return Container(
                                      margin: EdgeInsets.all(responsive.wp(4)),
                                      width: responsive.wp(100),
                                      height: responsive.hp(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Style.colorNaranja,
                                      ),
                                      child: AnyMargueeWidget(
                                        speedRate: 5,
                                        child: Text(snapshot.data.descMsg, style: TextStyle(color: Colors.white, fontSize: responsive.ip(2),))
                                      )
                                    );
                                  }else{
                                    return Container();
                                  }
                                }else{
                                  return Container(
                                    margin: EdgeInsets.all(responsive.wp(4)),
                                    width: responsive.wp(100),
                                    height: responsive.hp(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Style.colorNaranja,
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  );
                                }
                                
                              }
                            ),
                            Container(
                              padding: EdgeInsets.only(left: responsive.wp(4)),
                              alignment: Alignment.centerLeft, 
                              child: Text('Nuevos productos', style: TextStyle(fontWeight: FontWeight.w700, fontSize: responsive.ip(2)),),
                            ),
                            FutureBuilder<List<Producto>>(
                              future: productoApi.getNewProducts(context),
                              initialData: [],
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  if(snapshot.data.length == 0){
                                    return Expanded(
                                      child: Center(
                                        child: Text('No hay nuevos productos en este momento'),
                                      ),
                                    );
                                  }else{
                                    final data = snapshot.data;
                                    // return Expanded(
                                    //   child: GridView.count(
                                    //     crossAxisCount: 2,
                                    //     children: List.generate(data.length, (index) => _ProductoItem(producto: data[index])),
                                    //   ),
                                    // );
                                    return Container(
                                      height: responsive.hp(24),
                                      child: ListView.builder(
                                        itemCount: data.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => ProductoItem(producto: data[index]),
                                      )
                                    );
                                  }
                                }else{
                                  return Expanded(
                                    child: Center(
                                       child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: responsive.wp(1),),
                            Container(
                              padding: EdgeInsets.only(left: responsive.wp(4)),
                              alignment: Alignment.centerLeft, 
                              child: Text('Todos los productos',style: TextStyle(fontWeight: FontWeight.w700,fontSize: responsive.ip(2)))
                            ),
                            FutureBuilder<List<Producto>>(
                              future: productoApi.getAllProducts(context),
                              initialData: [],
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.done){
                                  if(snapshot.data.length == 0){
                                    return Expanded(
                                      child: Center(
                                        child: Text('No hay productos en este momento'),
                                      ),
                                    );
                                  }else{
                                    final data = snapshot.data;
                                    return Container(
                                      height: responsive.hp(24),
                                      child: ListView.builder(
                                        itemCount: data.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => ProductoItem(producto: data[index]),
                                      )
                                    );
                                  }
                                }else{
                                  return Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    ]
                  ),
                )
              ],
            )
        );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Categorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final responsive = new Responsive(context);
    final empresaApi = new EmpresaApi();

    return Container(
      margin: EdgeInsets.symmetric( horizontal: responsive.wp(3)),
      width: responsive.wp(100),
      height: responsive.hp(9.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: FutureBuilder<List<Categoria>>(
        future: empresaApi.getCategoria(context),
        initialData: [],
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data.length == 0){
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('Aun no se asignan categorias')),
              );
            }else{
              final data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      final providerBusqueda = Provider.of<ProviderBusqueda>(context, listen: false);
                      providerBusqueda.categoriaActual = data[index];
                      Navigator.pushNamed(context, 'search_category');
                    },
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            _CategoryButton(data[index]),
                            SizedBox(height: responsive.hp(0.8),),
                            Text('${(data[index].nomCat.length >= 7) ? data[index].nomCat[0].toUpperCase() + data[index].nomCat.substring(1,7) : data[index].nomCat[0].toUpperCase() + data[index].nomCat.substring(1)}',style: TextStyle(fontSize: responsive.ip(1.4)),)
                          ],
                        ),
                      ),
                    ),
                  );
                },
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

class SetupAlertDialoadContainer extends StatefulWidget {

  final List<Empresa> datoEmpresas;

  const SetupAlertDialoadContainer({Key key, this.datoEmpresas}) : super(key: key);

  @override
  _SetupAlertDialoadContainerState createState() => _SetupAlertDialoadContainerState();
}

class _SetupAlertDialoadContainerState extends State<SetupAlertDialoadContainer> {
  @override
  Widget build(BuildContext context) {
    final responsive = new Responsive(context);
    final providerEmpresa = Provider.of<ProviderEmpresa>(context,listen: false);

    return Container(
    height: responsive.hp(80),
    width: responsive.wp(80),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: widget.datoEmpresas.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            AppConfig.codigoEmpresa = widget.datoEmpresas[index].codEmp;
            providerEmpresa.obtenerDataEmpresa(context);
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(responsive.wp(2)),
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  height: responsive.hp(10),
                  imageUrl: widget.datoEmpresas[index].logoEmp??AppConfig.noimageDefault,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(backgroundColor: Style.colorMorado,),),
                  errorWidget: (context, url, error) {
                    return FadeInImage(placeholder: AssetImage('assets/loading.gif'), image: NetworkImage(AppConfig.noimageDefault));
                  },
                  fit: BoxFit.fill,
                ),
                Text(widget.datoEmpresas[index].razonSocial?? 'SIN RAZÓN SOCIAL', textAlign: TextAlign.center,),
              ],
            ),
          ),
        );
      },
    ),
  );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Categoria categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {

    final responsive = new Responsive(context);

    return Container(
        width: responsive.hp(4.5),
        height: responsive.hp(4.5),
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon(FontAwesomeIcons.blogger, color: Colors.blueAccent)
    );
  }
}

class _Carousel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final responsive = new Responsive(context);
    final empresaApi = new EmpresaApi();

    return FutureBuilder<List<Carrousel>>(
      future: empresaApi.getCarrousel(context),
      initialData: [],
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.data.length == 0){
            return Container(
            height: responsive.hp(20),
            child: Center(child: Text('Esta tienda aun no tiene esta funcion implementada', style: TextStyle(color: Colors.white),),)
          );
          }else{
            final data = snapshot.data;
            return Container(
              margin: EdgeInsets.symmetric(vertical: responsive.hp(2)),
              child: CarouselSlider.builder(
                  itemCount: data.length, 
                  itemBuilder: (context, index) => _CarouselItem(carrousel: data[index]),
                  options: CarouselOptions(
                    height: responsive.hp(20),
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInOut,
                    autoPlayInterval: Duration(seconds: 5),
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,

                  ),
              ),
            );
          }
        }else{
          return Container(
            height: responsive.hp(20),
            child: Center(child: CircularProgressIndicator(),)
          );
        }
      },
    );
  }
}

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({
    Key key,
    @required this.carrousel
  }) : super(key: key);

  final Carrousel carrousel;

  @override
  Widget build(BuildContext context) {

    final responsive = new Responsive(context);

    return Container(
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            width: responsive.wp(96),
            imageUrl: carrousel.imgCarItem,
            placeholder: (context, url) => Center(child: CircularProgressIndicator(backgroundColor: Colors.deepPurple,),),
            errorWidget: (context, url, error) {
              return Icon(Icons.error);
            },
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}

