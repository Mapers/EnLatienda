import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:ecommerceapp/src/utils/styles.dart';
import 'package:flutter/material.dart';

class OptionsUser extends StatelessWidget {

  final String text;
  final IconData icon;
  final Function onTap;

  const OptionsUser({Key key, this.text, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final resposive = Responsive(context);
  

    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            Icon(icon,color: Style.colorNaranja,),
            SizedBox(height: resposive.hp(0.5)),
            Wrap(
              children: <Widget>[
                Text(text, style: TextStyle(fontSize: resposive.ip(1.5), color: Colors.black87,),textAlign: TextAlign.center,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}