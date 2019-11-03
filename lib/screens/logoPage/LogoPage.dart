import 'dart:async';
import 'package:flutter/material.dart';
bool f = true;
class LogoScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new LogoScreenState();
  }
}
Timer _timer ;
class LogoScreenState extends State<LogoScreen> {
  @override
  Widget build(BuildContext context) {
    if(f){
      f = false;

     _timer = new Timer(const Duration(milliseconds: 3000), () {
      setState(() {

       Navigator.pushNamed(context, '/login');
       _timer.cancel();
      });
    });}

    return Container(
//      color: Colors.white,
      decoration: new BoxDecoration(
        color: Colors.white,

        image: new DecorationImage(
            image: new AssetImage("assets/images/photo_2019-10-27_11-33-07.jpg"),
            ),
      )
      ,


    );
  }

}