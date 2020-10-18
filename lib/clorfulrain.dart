import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class clorfulrain extends StatefulWidget {
  @override
  _clorfulrain createState() => _clorfulrain();
}

class _clorfulrain extends State<clorfulrain>
    with SingleTickerProviderStateMixin {
  double time=0;
  double hiz=8;
  List<rData> ListRain=List<rData>();
  @override
  void initState() {
     Timer.periodic(Duration(milliseconds: 10), (timer) {
      //1 saniye =100
      setState(() {
        time++;
      });
      print(time);
    });
    setState(() {
      ListRain=createListRain(500,360,600,20);
    });
    super.initState();
  }
  List<rData> createListRain(int rainnumber,double width,double height,double Rheight){
    List<rData> returned=List<rData>();
    for (var i = 0; i <= rainnumber; i++) {
      var xkonumu=width*Random().nextDouble();
      var rHeight=Random().nextDouble()*Rheight;
      var data=rData(xkonumu,rHeight<10?rHeight+10:rHeight ,Random().nextDouble()*height);
      returned.add(data);
    }
    return returned;
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
              CustomPaint(
                size: Size(360, 600),
                painter: coloredrain(ListRain,time,hiz),
              ),
              Container(height: 20,),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  InkWell(onTap: (){
                    setState(() {
                      if(hiz-1>=0){
                        hiz--;
                      }
                    });
                  },child: Icon(Icons.remove),),
                  Center(child: Text('Hız='+hiz.toString())),
                  InkWell(onTap: (){
                    setState(() {
                      if(hiz+1<=10){
                        hiz++;
                      }
                    });
                  },child: Icon(Icons.add),),
                ],),
              ),
              RaisedButton(color: Colors.blueAccent,child: Text('Reset'),onPressed:(){
                setState(() {
                  time=0;
                });
              } ,)
            ],
          ),
        ),
      ),
    );
  }
}

class coloredrain extends CustomPainter {
  List<rData> list;
  double time;
  double hiz;

  coloredrain(this.list,this.time,this.hiz);

  @override
  void paint(Canvas canvas, Size size) {
    var velocty=(11-hiz);
    list.forEach((line){
      Paint liner = Paint()
        ..color = Colors.accents[velocty.floor()].withAlpha(190)
        ..strokeWidth = 1;
      var xkonumu = line.xkonumu;
      var height = line.height;
      var ykonumu=(line.mPos+(height*time/velocty) - height)%700;
      Offset baslangic = Offset(xkonumu,ykonumu-100 );
      Offset bitis = Offset(xkonumu, ykonumu+height-100);
      canvas.drawLine(baslangic, bitis, liner);
    });
    var birikim=time/(velocty*20);
    var cc=Paint();
    cc.color = Colors.accents[velocty.floor()];
    canvas.drawRect(Rect.fromLTRB(0, size.height-birikim+20, size.width, size.height+20), cc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class rData{
  double xkonumu;
  double height;
  double mPos;
  rData(this.xkonumu,this.height,this.mPos);
}
