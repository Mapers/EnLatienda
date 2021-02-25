
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:flutter/material.dart';


class ProductoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final responsive = new Responsive(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage('assets/en-proceso.png')),
          SizedBox(height: responsive.hp(10),),
          Text('En Proceso', style: TextStyle(fontSize: responsive.ip(4), color: Colors.blue, fontWeight: FontWeight.bold),)
        ],
      ),
   );
  }
}