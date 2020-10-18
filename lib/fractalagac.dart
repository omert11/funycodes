import 'package:flutter/material.dart';

class fractalagac extends StatefulWidget{
  @override
  _fractalagac createState()=> _fractalagac();
}
class _fractalagac extends State<fractalagac>{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(height: 50,),
            CustomPaint(size: Size(360,500),painter:MyPainttree(250),)
          ],
        ),
      ),
    );
  }

}
class MyPainttree extends CustomPainter{
  double Uzunluk;
  MyPainttree(this.Uzunluk);
  @override
  void paint(Canvas canvas, Size size) {
    Paint painter=Paint()
    ..strokeWidth=10
    ..color=Colors.deepPurple;
    Offset baslangic=Offset(size.width/2,size.height);
    Offset bitis=baslangic.translate(0, -Uzunluk);
    canvas.drawLine(baslangic, bitis, painter);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
