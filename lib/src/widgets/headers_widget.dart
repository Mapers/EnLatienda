import 'package:ecommerceapp/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class HeaderAmarillo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 896,
      height: 896,
      child: CustomPaint(
        painter: _HeaderAmarillo(),
      )
    );
  }
}

class _HeaderAmarillo extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xFFFFAF46);
    lapiz.style = PaintingStyle.fill; // .fill para rellenar
    lapiz.strokeWidth = 2.0;
    
    final path = new Path();

    //Dibujar con el path y el lapiz
    path.lineTo(0.0, size.height * 0.20);
    path.quadraticBezierTo(size.width * 0.12, size.height * 0.195, size.width * 0.18, size.height * 0.135);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.04, size.width * 0.60, size.height * 0.03);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.03, size.width * 0.70, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class HeaderNegro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 896.0,
      height: 896,
      child: CustomPaint(
        painter: _HeaderNegro(),
      )
    );
  }
}

class _HeaderNegro extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xFF484C56);
    lapiz.style = PaintingStyle.fill; // .fill para rellenar
    lapiz.strokeWidth = 2.0;
    
    final path = new Path();

    //Dibujar con el path y el lapiz
    path.lineTo(0.0, size.height * 0.40);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5, size.width * 0.45, size.height * 0.44);
    path.quadraticBezierTo(size.width * 0.50, size.height * 0.43, size.width * 0.57, size.height * 0.387);
    path.quadraticBezierTo(size.width * 0.80, size.height * 0.20, size.width, size.height * 0.19);
    // path.quadraticBezierTo(size.width * 0.92, size.height * 0.16, size.width, size.height * 0.11);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class HeaderCeleste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 896,
      height: 896,
      child: CustomPaint(
        painter: _HeaderCeleste(),
      )
    );
  }
}

class _HeaderCeleste extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xFF59BEE8);
    lapiz.style = PaintingStyle.fill; // .fill para rellenar
    lapiz.strokeWidth = 2.0;
    
    final path = new Path();

    //Dibujar con el path y el lapiz
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.44, size.width , size.height * 0.50);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}



class HeaderNegroRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = new Responsive(context);

    return Container(
      width: responsive.height,
      height: responsive.height,
      child:CustomPaint(
        painter: _HeaderNegroRegister(),
      )
    );
  }
}

class _HeaderNegroRegister extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xFF484C56);
    lapiz.style = PaintingStyle.fill; // .fill para rellenar
    lapiz.strokeWidth = 2.0;
    
    final path = new Path();

    //Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.425, size.width *  0.5, size.height * 0.40 );
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.385, size.width, size.height * 0.3 );
    path.lineTo(size.width, 0);
    path.close();

    
    path.close();

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class HeaderCelesteRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = new Responsive(context);

    return Container(
      width: responsive.height,
      height: responsive.height,
      child:CustomPaint(
        painter: _HeaderCelesteRegister(),
      )
    );
  }
}

class _HeaderCelesteRegister extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = new Paint();

    // Propiedades
    lapiz.color = Color(0xFF59BEE8);
    lapiz.style = PaintingStyle.fill; // .fill para rellenar
    lapiz.strokeWidth = 2.0;
    
    final path = new Path();

    //Dibujar con el path y el lapiz
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.35, size.height);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.82, size.width, size.height * 0.70 );
    path.lineTo(size.width, 0);
    path.close();

    
    path.close();

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

