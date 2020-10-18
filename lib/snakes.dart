import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double hedefx = 1000;
double hedefy = 1000;
bool stoptime = false;
bool drawyem = false;
bool clicked = true;
bool yposonline=true;
bool Yandin=false;
bool realise=true;
int Uzunluk = 1;
List<Offset> mkonums = [Offset(0, 0)];
Offset sonpos = Offset(0, 0);

class snakes extends StatefulWidget {
  @override
  _snakes createState() => _snakes();
}

class _snakes extends State<snakes> {
  int time = 0;
  Timer a;
  _resarter(){
    setState(() {
      a.cancel();
      drawyem = false;
      Uzunluk=1;
      mkonums.clear();
      mkonums.add(Offset(0,0));
      clicked=true;
      time=0;
      sonpos=Offset(0,0);
      Yandin=false;
    });
  }
  _Positioner(TapDownDetails deatils){
    setState(() {
      if (clicked) {
        hedefx = deatils.localPosition.dx -
            (deatils.localPosition.dx % 20);
        hedefy = deatils.localPosition.dy -
            (deatils.localPosition.dy % 20);
        _TimersTarter();
        clicked = false;
        realise=true;
        drawyem = true;
      }
    });
  }
  _mGoinger(){
    hedefx = 20.0*double.parse(Random().nextInt(18).toString());
    hedefy = 20.0*double.parse(Random().nextInt(35).toString());
    realise=false;
    _TimersTarter();
  }
  _TimersTarter() {
    a != null ? a.cancel() : null;
    a = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (stoptime) {
        clicked = true;
        realise?Uzunluk++:null;
        drawyem = false;
        stoptime = false;
        a.cancel();
        realise=false;
        _mGoinger();
      }else{
        setState(() {
          time++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: SingleChildScrollView(
          child: Column(
            children: !Yandin?<Widget>[
              Container(
                height: 75,
                child: Center(child: Text(time==0?'Başlamak için ekrana dokun':(Uzunluk*125).toString()+' Puan')),
              ),
              GestureDetector(
                onTapDown: (deatils) {
                  _Positioner(deatils);
                },
                child: CustomPaint(
                  size: Size(360, 700),
                  painter: runnerSnake(time),
                ),
              )
            ]:<Widget>[
              Container(height: 200,),
              Center(child: Text('SKORUN : '+(Uzunluk*125).toString()),),
              RaisedButton(onPressed: (){
                _resarter();
              },child: Text('Restart'),)
            ],
          ),
        ),
      ),
    );
  }
}

class runnerSnake extends CustomPainter {
  int time;

  runnerSnake(this.time);

  _CostomSquare(Canvas canvas, Offset cizkonum) {
    Paint painter = Paint()..color = Colors.indigo;
    sonpos = cizkonum;
    canvas.drawRect(
        Rect.fromLTRB(sonpos.dx, sonpos.dy, sonpos.dx + 19, sonpos.dy + 19),
        painter);
  }

  _CostomSquare_b(Canvas canvas, Offset cizkonum) {
    Paint painter = Paint()..color = Colors.blueAccent;
    canvas.drawRect(
        Rect.fromLTRB(
            cizkonum.dx, cizkonum.dy, cizkonum.dx + 19, cizkonum.dy + 19),
        painter);
  }

  _CostomCicle(Canvas canvas, double Posx, double Posy) {
    Paint painter = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(Posx + 9.5, Posy + 9.5), 9.5, painter);
  }
 bool _Degiyormu(Offset of){
   return mkonums.contains(of);
  }
  @override
  void paint(Canvas canvas, Size size) {
      if (drawyem) {
        _CostomCicle(canvas, hedefx, hedefy);
      }
      if(mkonums.last.dx!=hedefx&&yposonline){
        if(mkonums.last.dx-hedefx>0){
          Offset deneofset=mkonums.last.translate(-20, 0);
          if(_Degiyormu(deneofset)){
            if(_Degiyormu(deneofset.translate(20, 20))){
              if(_Degiyormu(deneofset.translate(20, -20))){
                if(_Degiyormu(deneofset.translate(40,0))){
                  Yandin=true;
                }else{
                  mkonums.add(deneofset.translate(40,0));
                }
              }else{
                mkonums.add(deneofset.translate(20, -20));
              }
            }else{
              mkonums.add(deneofset.translate(20, 20));
            }
          }else{
            mkonums.add(deneofset);
          }
        }else{
          Offset deneofset=mkonums.last.translate(20, 0);
          if(_Degiyormu(deneofset)){
            if(_Degiyormu(deneofset.translate(-20, 20))){
              if(_Degiyormu(deneofset.translate(-20, -20))){
                if(_Degiyormu(deneofset.translate(-40,0))){
                  Yandin=true;
                }else{
                  mkonums.add(deneofset.translate(-40,0));
                }
              }else{
                mkonums.add(deneofset.translate(-20, -20));
              }
            }else{
              mkonums.add(deneofset.translate(-20, 20));
            }
          }else{
            mkonums.add(deneofset);
          }
        }
      }else if(mkonums.last.dy!=hedefy){
        yposonline=false;
        if(mkonums.last.dy-hedefy>0){
          Offset deneofset=mkonums.last.translate(0,-20);
          if(_Degiyormu(deneofset)){
            if(_Degiyormu(deneofset.translate(20, 20))){
              if(_Degiyormu(deneofset.translate(-20, 20))){
                if(_Degiyormu(deneofset.translate(0, 40))){

                  Yandin=true;
                }else{
                  mkonums.add(deneofset.translate(0, 40));
                }
              }else{
                mkonums.add(deneofset.translate(-20, 20));
              }
            }else{
              mkonums.add(deneofset.translate(20, 20));
            }
          }else{
            mkonums.add(deneofset);
          }
        }else{
          Offset deneofset=mkonums.last.translate(0,20);
          if(_Degiyormu(deneofset)){
            if(_Degiyormu(deneofset.translate(20, -20))){
              if(_Degiyormu(deneofset.translate(-20, -20))){
                if(_Degiyormu(deneofset.translate(0, -40))){
                  Yandin=true;
                }else{
                  mkonums.add(deneofset.translate(0, -40));
                }
              }else{
                mkonums.add(deneofset.translate(-20, -20));
              }
            }else{
              mkonums.add(deneofset.translate(20, -20));
            }
          }else{
            mkonums.add(deneofset);
          }
        }
      }else if(mkonums.last.dy==hedefy&&mkonums.last.dx!=hedefx){
        yposonline=true;
      }
      if(mkonums.length>Uzunluk){
        mkonums.removeAt(0);
      }
      for (var k = 1; k <= Uzunluk; k++) {
        if (mkonums.length - k >= 0) {
          k==1?_CostomSquare(canvas, mkonums[mkonums.length - k]):_CostomSquare_b(canvas, mkonums[mkonums.length - k]);
        }
      }
      if(mkonums.last==Offset(hedefx,hedefy)){
        stoptime=true;
      }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
/*for (var k = 1; k <= Uzunluk; k++) {
        if ((time - stime) > 0 && (time - stime) - k + Uzunluk >= 0) {
          Offset yurut = sonpos;
          if ((time - stime) <= mkonums.length-Uzunluk) {
            yurut = (time - stime) - k + Uzunluk <= mkonums.length - 1
                ? mkonums[(time - stime) - k + Uzunluk]
                : sonpos;
          } else {
            stoptime = true;
            yurut = mkonums[mkonums.length - k];
          }
          k == 1
              ? _CostomSquare(canvas, yurut)
              : _CostomSquare_b(canvas, yurut);
        } else {
          for (var k = 1; k <= Uzunluk; k++) {
            _CostomSquare_b(canvas, mkonums[k-1]);
          }
        }
      }
    } else {
      if (mkonums.length > Uzunluk && mkonums.length != 0) {
        mkonums.removeRange(0, mkonums.length - Uzunluk + 1);
      }
      for (var k = 1; k <= Uzunluk; k++) {
        if (mkonums.length - k >= 0) {
          _CostomSquare_b(canvas, mkonums[mkonums.length - k]);
        }
      }

       */
/*var hamlesayimx = ((hedefx - sonpos.dx) < 0
                ? -(hedefx - sonpos.dx)
                : (hedefx - sonpos.dx)) /
            20;
        var hamlesayimy = ((hedefy - sonpos.dy) < 0
                ? -(hedefy - sonpos.dy)
                : (hedefy - sonpos.dy)) /
            20;
        var hamlesayim = hamlesayimx + hamlesayimy;
        print(hamlesayim);
        for (var i = 1; i <= hamlesayim; i++) {
          bool xdr = (hedefx - sonpos.dx) < 0;
          if (i <= hamlesayimx) {
            mkonums.add((hedefx - sonpos.dx) < 0
                ? sonpos.translate(-20.0 * i, 0)
                : sonpos.translate(20.0 * i, 0));
          } else {
            mkonums.add((hedefy - sonpos.dy) < 0
                ? sonpos.translate(
                    xdr ? -20.0 * hamlesayimx : 20.0 * hamlesayimx,
                    -20.0 * (i - hamlesayimx))
                : sonpos.translate(
                    xdr ? -20.0 * hamlesayimx : 20.0 * hamlesayimx,
                    20.0 * (i - hamlesayimx)));
          }
        }
         */

/*do{

        }while(mkonums.last!=Offset(hedefx,hedefy));
        hesapla = false;*/