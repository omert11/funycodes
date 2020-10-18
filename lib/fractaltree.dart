import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'angles.dart';

class fractaltree extends StatefulWidget{
  _fractaltree createState() => _fractaltree();

}
class _fractaltree extends State<fractaltree>{
  double arc = 35;
  double rep = 5;
  double heigt = 50;
  double widt = 10;
  double kuculme = 1.4;
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 50,
              ),
              Slider(
                min: 0,
                max: 90,
                onChanged: (val) {
                  setState(() {
                    arc = val;
                  });
                },
                value: arc,
              ),
              Slider(
                min: 0,
                max: 200,
                onChanged: (val) {
                  setState(() {
                    heigt = val;
                  });
                },
                value: heigt,
              ),
              Slider(
                min: 0,
                max: 3,
                onChanged: (val) {
                  setState(() {
                    kuculme = val;
                  });
                },
                value: kuculme,
              ),
              Slider(
                min: 0,
                max: 10,
                onChanged: (val) {
                  setState(() {
                    rep = val;
                  });
                },
                value: rep,
              ),
              Slider(
                min: 0,
                max: 50,
                onChanged: (val) {
                  setState(() {
                    widt = val;
                  });
                },
                value: widt,
              ),
              Center(
                  child: Text(
                    "KIRILIM AÇISI:" + arc.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  )),
              Container(
                height: 10,
              ),
              CustomPaint(
                size: Size(360, 240),
                painter: MyFractaltree(heigt, widt, rep, arc, kuculme),
              )
            ],
          ),
        ),
      ),
    );
  }

}
class MyFractaltree extends CustomPainter {
  double lHeight;
  double lgovdeG;
  double rpeat;
  double deg;
  double kuculme;

  MyFractaltree(this.lHeight, this.lgovdeG, this.rpeat, this.deg, this.kuculme);

  @override
  void paint(Canvas canvas, Size size) async {
    Paint line_G = new Paint()
      ..color = Colors.lightGreen
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lgovdeG;

    final startpoint = Offset(size.width / 2, size.height);
    final endpoint = startpoint.translate(0, -lHeight);

    canvas.drawLine(startpoint, endpoint, line_G);
    List<Offset> oLend = [endpoint];
    List<Offset> oLend2 = [];
    List<Offset> oLstart = [startpoint];
    List<Offset> oLstart2 = [];
    List <Color> Col=Colors.primaries;
    var uz = lHeight;
    for (var i = 0; i <= rpeat; i++) {
      var k = 0;
      Paint line_B = new Paint()
        ..color = Col[i]
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.fill
        ..strokeWidth = lgovdeG - (i * 2.5);
      oLend.forEach((end) {
        var start = oLstart[k];
        var fark = end - start;
        var derege = -Angle.fromRadians(fark.direction); //Angle.acos(fark.dx/uz);
        var postive = derege + Angle.fromDegrees(deg);
        var negative = derege - Angle.fromDegrees(deg);
        var yp = uz * cos((Angle.fromDegrees(90) - postive).radians);
        var xp = uz * cos(postive.radians);
        Offset possitiveOfend = Offset(xp, -yp) + end;
        var xn = uz * cos(negative.radians);
        var yn = uz * cos((Angle.fromDegrees(90) - negative).radians);
        Offset neggaiveOfend = Offset(xn, -yn) + end;
        canvas.drawLine(end, possitiveOfend, line_B);
        canvas.drawLine(end, neggaiveOfend, line_B);
        oLend2 = oLend2 + [possitiveOfend, neggaiveOfend];
        oLstart2 = oLstart2 + [end, end];
        k++;
      });
      oLend = oLend2;
      oLstart = oLstart2;
      oLend2 = [];
      oLstart2 = [];
      uz = uz / kuculme;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}