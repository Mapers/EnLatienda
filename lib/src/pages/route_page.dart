import 'package:ecommerceapp/src/pages/home_page.dart';
import 'package:ecommerceapp/src/pages/mi_cuenta_page.dart';
import 'package:ecommerceapp/src/pages/productos_page.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new _NavegacionModel())
      ],
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      selectedItemColor: Style.colorNaranja,
      unselectedItemColor: Style.colorMorado,
      onTap: (index) => navegacionModel.paginaActual = index,
      items: [
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home), title: Text('Inicio')),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.productHunt), title: Text('Productos')),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.user),title: Text('Mi Cuenta'))
      ],
    );
  }
}

class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel._pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomePage(),
        ProductoPage(),
        MiCuentaPage()
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor){
    this._paginaActual = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;

}