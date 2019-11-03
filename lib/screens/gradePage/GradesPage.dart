import 'dart:async';

import 'package:az_man_bepors/data/DataBaseHelper.dart';
import 'package:az_man_bepors/models/Grade.dart';
import 'package:az_man_bepors/models/Lesson.dart';
import 'package:az_man_bepors/screens/lessonsScreen/LessonsPage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





// ignore: must_be_immutable
class GradesPage extends StatefulWidget {


  static List<Widget> _tiles;

//  static getGrade()  {
//    print('in get grade in grade page');
////    List<Grade> grades =  DatabaseHelper.instance.getGrades() as List<Grade>;
//    List<Grade> grades =  ;
//   return _tiles =  <Widget>[
//      Button(Colors.blue,grades[0] ,AssetImage("assets/images/hetchs/blue_hetch.png")),
//      Button(Colors.green,grades[1],AssetImage("assets/images/hetchs/green_hetch.png")),
//      Button(Colors.amber, grades[2],AssetImage("assets/images/hetchs/yellow_hetch.png")),
//      Button(Colors.red, grades[3],AssetImage("assets/images/hetchs/red_hetch.png")),
//      Button(Colors.pink, grades[4],AssetImage("assets/images/hetchs/pink_hetch.png")),
//      Button(Colors.purple, grades[5],AssetImage("assets/images/hetchs/purple_hetch.png")),
//    ];
//
//
//}

//  List<Grade> tiles =
//  grades.then((){

//  );
  @override
  State<StatefulWidget> createState() {
//    DatabaseHelper.instance.createTables();
//    DatabaseHelper.instance.initializeTables(res);
//    getGrade();
    return new GradesPageState( _tiles);}
}

class GradesPageState extends State<GradesPage>{
  List<Widget> _tiles ;
  GradesPageState(this. _tiles);

  @override
  Widget build(BuildContext context) {

    return  new Scaffold(
         
         body:
         new Stack(
        children : [
         new Container(
         decoration: new BoxDecoration(
         image: new DecorationImage(
         image: new AssetImage("assets/images/oie_XRgF9jVIpXT0.png"),
        fit: BoxFit.cover),
    ),
    child:

          new Opacity(
            opacity: 1.0,
           child :new Padding(padding:EdgeInsets.fromLTRB(40.0,230.0,40.0,30.0),
                  child :new Button())

          )
         )]
        )
      );
  }
}

class Button extends StatefulWidget {
//  const Button(this.backgroundColor, this.grade ,this.image );

//  final Color backgroundColor;
//  final Grade grade;
//  final ImageProvider image;

  @override
//  State<StatefulWidget> createState() => new ButtonsState(backgroundColor , grade , image);
  State<StatefulWidget> createState() => new ButtonsState();
}

class ButtonsState extends State<Button> {
//  final Color backgroundColor;
//  final Grade grade;
//  final ImageProvider image;

//  ButtonsState(this.backgroundColor, this.grade,this.image);


  @override
  Widget build(BuildContext context) {
    final double wScale = (MediaQuery.of(context).size.width/432.0);
    final double hScale = (MediaQuery.of(context).size.height/816.0);
//

  return FutureBuilder(
    future: DatabaseHelper.instance.getGrades(),
    builder: (context, projectSnap) {

      return projectSnap.hasData
          ?  GridView.builder(

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 50.0*wScale , mainAxisSpacing: 50.0*wScale
           , childAspectRatio: (2*wScale / 1*hScale),),

        itemCount: projectSnap.data.length,
        itemBuilder: (context, index) {

          final project = projectSnap.data[index];
          return (

              DottedBorder(
                  dashPattern: [10, 5, 10, 5],
                  color: new Color.fromARGB(500,238,108,77),
//                  color: new Color.fromARGB(200, 112, 131, 191),
//                  color: new Color.fromARGB(500,41,50,65),
                  strokeWidth: 3*wScale,

//                  )
//          ),

                  child :
//                new Text('gggggggggg')
           new OutlineButton(

            child: new Center(
                child:new Text(
            project.title,
            style: new TextStyle(
          fontFamily: 'XPZibaRegular' ,
          fontSize: 40.0*wScale,
               color:new Color.fromARGB(500, 112, 131, 191),
//              color: new Color.fromARGB(500,41,50,65),
        ),
      )),
      color: Colors.transparent,

      onPressed:(){
              print ('in on pressed');
              print(project.id);
        Navigator.pushNamed(context, LessonsScreen.routeName, arguments: project);
      },
           )

              ));
        },
      ): Center(
        child: CircularProgressIndicator(),
      );

    },

  );
  }

}
