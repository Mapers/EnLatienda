import 'package:ecommerceapp/app_config.dart';
import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class IntroductionLoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.close), 
                onPressed: (){
                  Navigator.pop(context);
                }
              ),
            ),
            SizedBox(height: responsive.hp(2),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.wp(16)),
              child: Image(
                image: AssetImage('assets/logo-dark.png')
              ),
            ),
            Spacer(),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: responsive.wp(30),vertical: responsive.hp(1.5)),
              color: Style.colorNaranja,
              onPressed: (){
                Navigator.pushNamed(context, 'register');
              }, 
              child: Text('REGÍSTRATE',style: TextStyle(color: Colors.white),)
            ),
            SizedBox(height: responsive.hp(0.5),),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: responsive.wp(30),vertical: responsive.hp(1.5)),
              color: Style.colorNaranja.withOpacity(0.1),
              onPressed: (){
                Navigator.pushNamed(context, 'login');
              }, 
              child: Text('IDENTIFÍCATE',style: TextStyle(color: Style.colorNaranja),)
            ),
            SizedBox(height: responsive.hp(2),),
            Text('O inicia sesión con', style: TextStyle(color: Colors.black38,fontSize: responsive.ip(1.5)),),
            SizedBox(height: responsive.hp(2),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Style.googleColor,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.google,color: Colors.white,), 
                    onPressed: (){
                      
                    }
                  )
                ),
                SizedBox(width: responsive.wp(5),),
                CircleAvatar(
                  backgroundColor: Style.facebookColor,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.facebookF, color: Colors.white,), 
                    onPressed: (){}
                  )
                ),
              ],
            ),
            SizedBox(height: responsive.hp(4),)
          ],
     ),
      ),
   );
  }
}