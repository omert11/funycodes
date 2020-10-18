
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Fractal/angles.dart';

class spagetties extends StatefulWidget{
  @override
  _spagetties createState()=> _spagetties();
}
class _spagetties extends State<spagetties>{
  double arc=1;
  double time=0;
  Timer a;
  _TimersTarter(){
    a!=null?a.cancel():null;
    a=Timer.periodic(Duration(milliseconds: 1), (timer) {
      //1 saniye =100
      setState(() {
        time++;
        time++;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(height: 50,),
              CustomPaint(size:Size(360,600) ,painter: fallspagetties(time),),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(onPressed: (){_TimersTarter();},color: Colors.deepOrangeAccent,child: Text('Basla')),
                  RaisedButton(onPressed: (){setState(() {
                    time=0;
                  });},color: Colors.deepOrangeAccent,child: Text('Reset')),
                  RaisedButton(onPressed: (){a.cancel();},color: Colors.redAccent,child: Text('Dur'),),
                ],
              ),
              Container(height: 100,)
            ],
          ),
        ),
      ),
    );
  }

}
class fallspagetties extends CustomPainter{
  double arc=360;
  double fall=0;
  double time;
  fallspagetties(this.time);
  @override
  void paint(Canvas canvas, Size size) {
    int kat=(time/800).truncate();
    int duslimit=800-kat*10;
    Paint painter=Paint()
      ..color=Colors.accents[kat%Colors.accents.length]
      ..strokeWidth=10
      ..strokeJoin=StrokeJoin.round
      ..strokeCap=StrokeCap.round
      ..style=PaintingStyle.stroke;
    if(time%800<duslimit){
      fall=time%800;
      arc=(360/duslimit)*(duslimit-time%800);
      double yay=arc;
      double yaricap=360/((yay/360)*pi*2);
      double kucultur=180-yaricap;
      canvas.drawArc(Rect.fromLTRB(0+kucultur, -300+kucultur-yaricap+fall, 360-kucultur, 60-kucultur-yaricap+fall), Angle.fromDegrees(90-(yay/2)).radians, Angle.fromDegrees(yay).radians, false, painter);
    }else{
      time=time+time-duslimit;
    }
    for(double i=0;i<kat;i++){
      Paint painter2=Paint()
        ..color=Colors.accents[i.round()%Colors.accents.length]
        ..strokeWidth=10
        ..strokeJoin=StrokeJoin.round
        ..strokeCap=StrokeCap.round
        ..style=PaintingStyle.stroke;
      Offset start=Offset(0,670-(i*10));
      Offset end=Offset(360,670-(i*10));
      canvas.drawLine(start, end, painter2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}