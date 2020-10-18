import 'package:Fractal/fractalagac.dart';
import 'package:Fractal/snakes.dart';
import 'package:flutter/material.dart';
import 'package:Fractal/clorfulrain.dart';
import 'package:Fractal/fractaltree.dart';
import 'package:Fractal/spagetties.dart';

void main() {
  runApp(MaterialApp(
    home: Giris(),
    routes: <String, WidgetBuilder>{
      "/giris": (BuildContext context) => Giris(),
      "/d1": (BuildContext context) =>fractalagac(),
      "/d2": (BuildContext context) => clorfulrain(),
      "/d3": (BuildContext context) => spagetties(),
      "/d4": (BuildContext context) => snakes(),
    },
  ));
}

class Giris extends StatefulWidget {
  @override
  _Giris createState() => _Giris();
}

class _Giris extends State<Giris> {
  mIconButton(
      String text,
      VoidCallback onclick,
      Color color,
      Color colordivider,
      Color textcolor,
      double textsize,
      double widh,
      double heighdivider,
      EdgeInsetsGeometry paddingtext) {
    var button = InkWell(
      onTap: onclick,
      child: Container(
          width: widh,
          color: color,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      padding: paddingtext,
                      width: widh - 30,
                      child: Text(
                        text,
                        style: TextStyle(color: textcolor, fontSize: textsize),
                      )),
                  Icon(Icons.chevron_right)
                ],
              ),
              Divider(
                color: colordivider,
                height: heighdivider,
              )
            ],
          )),
    );
    return button;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
              ),
              mIconButton('Work-1(Fractal tree)', () {
                Navigator.of(context).pushNamed('/d1');
              }, Colors.white, Colors.black54, Colors.black, 14, 360, 1,
                  EdgeInsets.only(left: 10)),
              mIconButton('Work-2(Colorful rain)', () {
                Navigator.of(context).pushNamed('/d2');
              }, Colors.white, Colors.black54, Colors.black, 14, 360, 1,
                  EdgeInsets.only(left: 10)),
              mIconButton('Work-3(Fall spagetti)', () {
                Navigator.of(context).pushNamed('/d3');
              }, Colors.white, Colors.black54, Colors.black, 14, 360, 1,
                  EdgeInsets.only(left: 10)),
              mIconButton('Work-4(Run Snake Run)', () {
                Navigator.of(context).pushNamed('/d4');
              }, Colors.white, Colors.black54, Colors.black, 14, 360, 1,
                  EdgeInsets.only(left: 10)),
            ],
          ),
        ),
      ),
    );
  }
}
