import 'package:az_man_bepors/data/DataBaseHelper.dart';
import 'package:az_man_bepors/models/Grade.dart';
import 'package:az_man_bepors/screens/testPage/TestPage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
Grade grade;

List<Widget> _tiles = const <Widget>[

//  const UnitButton(Colors.deepOrange, const Unit("درس اول",1),AssetImage("assets/images/hetchs/orange_hetch.png")),
//  const UnitButton(Colors.indigo, const Unit("درس دوم",2),AssetImage("assets/images/hetchs/indiago_hetch.png")),
//  const UnitButton(Colors.pink, const Unit("درس سوم",3),AssetImage("assets/images/hetchs/pink_hetch.png")),
//  const UnitButton(Colors.amber, const Unit("درس چهارم",4),AssetImage("assets/images/hetchs/yellow_hetch.png")),
//  const UnitButton(Colors.green, const Unit("درس پنجم",5),AssetImage("assets/images/hetchs/green_hetch.png")),
//  const UnitButton(Colors.purple, const Unit("درس ششم",6),AssetImage("assets/images/hetchs/purple_hetch.png")),
//  const UnitButton(Colors.red, const Unit("درس هفتم",7),AssetImage("assets/images/hetchs/red_hetch.png")),
//  const UnitButton(Colors.blue,const Unit( "درس هشتم",8),AssetImage("assets/images/hetchs/blue_hetch.png")),
//  const UnitButton(Colors.teal, const Unit("درس نهم",9),AssetImage("assets/images/hetchs/teal_hetch.png")),
//  const UnitButton(Colors.black87, const Unit("درس دهم",10),AssetImage("assets/images/hetchs/black_hetch.png"))
];

class LessonsScreen extends StatefulWidget {
//DatabaseHelper.instanc;
  static const routeName = '/extractArguments';

  @override
  State<StatefulWidget> createState() => new LessonsScreenState();

}
class LessonsScreenState extends State<LessonsScreen>{



  @override
  Widget build(BuildContext context) {
     grade = ModalRoute.of(context).settings.arguments;
     print ('in lesson screen');
     print(grade.id);
    return new Scaffold(

        body:
        new Stack(
            children : [

        new Container(
        decoration: new BoxDecoration(
        image: new DecorationImage(
        image: new AssetImage("assets/images/Untitled collage (1).png"),
        fit: BoxFit.cover),
    ),
    child:

    new Opacity(
                  opacity: 0.9,
                  child: new Column(
                  children: [
                    new Padding(padding:EdgeInsets.fromLTRB(40.0,40.0,40.0,30.0)),
                     new UnitButton(),
//                    new Row(
//                      children: <Widget>[
////                        ne
//                        new RaisedButton(
//
//                          onPressed: (){
////                            Navigator.pushNamed(context, routeName)
//                          },
//                          child: new Text("مرور نیم سال اول" ,
//                              style : new TextStyle(fontFamily: 'morvarid')),
////                color: new Color.fromARGB(200, 112, 131, 191),
//                          color: new Color.fromARGB(500,238,108,77),
//                        ),
//                        new RaisedButton(
//                          onPressed: (){
////                            Navigator.pushNamed(context, routeName)
//                          },
//                          child: new Text("مرور نیم سال دوم" ,style : new TextStyle(fontFamily: 'morvarid')),
////                color:  new Color.fromARGB(200, 112, 131, 191),
//                          color: new Color.fromARGB(500,238,108,77),
//                        ),
//                      ],
//                    )
                  ]
                     )))
               ]
          )
        );
  }
}

class UnitButton extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new UnitButtonsState();

}

class UnitButtonsState extends State<UnitButton> {

//  final Color backgroundColor;
//  final String buttonName;
//  final AssetImage assetImage;
//
//  UnitButtonsState(this.backgroundColor,this.buttonName,this.assetImage);

  @override
  Widget build(BuildContext context) {

    print('in build button state');
    return FutureBuilder(
      future: DatabaseHelper.instance.getLessons(grade),

      builder: (context, projectSnap) {

        return projectSnap.hasData
            ?  GridView.builder(
          shrinkWrap: true,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 50.0 , mainAxisSpacing: 50.0
            , childAspectRatio: (2 / 0.9),),

          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {

            final lesson = projectSnap.data[index];
            return (

                DottedBorder(
                    dashPattern: [10, 5, 10, 5],
                    color: new Color.fromARGB(500,238,108,77),
                    strokeWidth: 3,

                      child: new FutureBuilder(
                        future: DatabaseHelper.instance.getQuestion(lesson),
                          builder:  (context, projectSnap) {
                            return projectSnap.hasData ?
                            new OutlineButton(



                      child: new Center(
                          child:new Text(
                            lesson.title,
                            style: new TextStyle(
                              fontFamily: 'XPZibaRegular' ,
                              fontSize: 30.0,
                              color:new Color.fromARGB(500, 112, 131, 191),
//              color: new Color.fromARGB(500,41,50,65),
                            ),
                          )),
                      color: Colors.transparent,

                      onPressed:(){
                        Navigator.pushNamed(context, TestPage.routeName, arguments:projectSnap.data );
                      },
                            ): Center(
                             child: CircularProgressIndicator(),
                            );
                        }
                            )

                )
            );
          },
        ): Center(
          child: CircularProgressIndicator(),
        );
      },
    );
//    return GestureDetector(
//        child: Container(
//            child: new Center(
//                child :new Text(
//
//              buttonName,
//              style: new TextStyle(
//                  fontFamily: 'XPZibaRegular',
//                  fontSize: 30.0,
//                  color: backgroundColor
//              ),
//            )),
//            decoration: BoxDecoration(
//
//                shape: BoxShape.rectangle,
//                border: Border.all(
//                    color: backgroundColor,
//                    width: 3.0
//                ),
//                image:
//                DecorationImage(
//                  image: assetImage,
//                )
//            )
//        ),onTap:(){
//      Navigator.pushNamed(context, TestPage.routeName, arguments: buttonName);
//    }
//    );
//
////    new OutlineButton(
////      child: new Text(
////          buttonName,
////          style:
////          new TextStyle(
////          fontSize: 25.0
////        )),
////      onPressed:(){
////        Navigator.pushNamed(context, TestPage.routeName, arguments: buttonName);
////        }
////      ,textColor: backgroundColor,
////      borderSide: BorderSide(
////        color: C,
////        style: BorderStyle.solid,
////        width: 5.0,
////      ),
////    );
  }
}
