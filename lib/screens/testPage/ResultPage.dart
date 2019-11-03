import 'package:az_man_bepors/models/Qustion.dart';
import 'package:az_man_bepors/models/TestPageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TestPage.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  static const routeName = '/ResultPage';

  ResultPage();
@override
State<StatefulWidget> createState() => new ResultPageState();
}

class ResultPageState extends State<ResultPage>{



  @override
  Widget build(BuildContext context) {
    final double wScale = (MediaQuery.of(context).size.width/432.0);
    final double hScale = (MediaQuery.of(context).size.height/816.0);

    final TestPageModel args = ModalRoute.of(context).settings.arguments;
    int wrongAnswers = args.wrongAnswers+1;
    int rightAnswers = args.rightAnswers;
    List <Question> wrongWords = args.wrongWords;
//   final  ModalRoute.of(context).settings.arguments;
  return
    new Scaffold(

      body:
      new Stack(
          children: [
            new Container(

                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage(
                          "assets/images/oie_BA1WvTozCJqf.png"),
                      fit: BoxFit.cover),
                ),
                child:
//            new Image.asset('assets/images/oie_BA1WvTozCJqf.png',  height: 700,width: 600, fit: BoxFit.fitHeight,),

                new Opacity(
                  opacity: 0.9,

                  child: Center(
                      child: new SizedBox(
                        height: 600*hScale,
                          width: 900*wScale,
                          child: new Container(
                           decoration: new BoxDecoration(
                      image: new DecorationImage(
                      image: new AssetImage(
                      "assets/images/imageedit_11_5035671886.png"),
                      fit: BoxFit.cover),
                      ),
                          child: new Center (
                              child : new Column(
                            children: <Widget>[
                                   new Text(
                        "نتیجه ی آزمون",
                        style: new TextStyle(
                        fontFamily: 'XPZibaRegular' ,
                        fontSize: 40.0*wScale,
//                        color:new Color.fromARGB(500, 112, 131, 191),
                                  color: new Color.fromARGB(500,41,50,65),
                        ),
                        ),
                              new Padding(padding: EdgeInsets.all(65)),
                              new Text(
                                "$rightAnswers تا رو درست گفتی",
                                style: new TextStyle(
                                  fontFamily: 'XPZibaRegular' ,
                                  fontSize: 30.0*wScale,
//                        color:new Color.fromARGB(500, 112, 131, 191),
                                  color: new Color.fromARGB(500,41,50,65),
                                ),
                              ),
                                new Padding(padding: EdgeInsets.all(30)),
                                new Text(
                                "$wrongAnswers تا رو اشتباه کردی ",
                                style: new TextStyle(
                                  fontFamily: 'XPZibaRegular' ,
                                  fontSize: 30.0*wScale,
//                        color:new Color.fromARGB(500, 112, 131, 191),
                                  color: new Color.fromARGB(500,41,50,65),
                                ),
                              ),
                                new Padding(padding: EdgeInsets.all(12)),
                                SizedBox(
                                width: 170*wScale, // specific value
                                height: 50*hScale,
                                 child:RaisedButton(
                              color: new Color.fromARGB(500,238,108,77),

                              onPressed: (){
                                Navigator.pushNamed(context, '/grade page');
                              } ,
                                    child: new Center(
                                      child: new Text(

                              'بریم درس جدید',
                              style: new TextStyle(
                              fontFamily: 'XPZibaRegular',
                              fontSize: 23.0*wScale,

                              ),
                              ))
                             )),
                                new Padding(padding: EdgeInsets.all(5)),
                                SizedBox(
                                  width: 170*wScale, // specific value
                                  height: 50*hScale,
                                  child:RaisedButton(
                                      color: new Color.fromARGB(500,238,108,77),

                                      onPressed: (){
                                        Navigator.pushNamed(context,  TestPage.routeName ,arguments: wrongWords);
                                      } ,
                                      child: new Center(
                                          child: new Text(

                                            'غلطا رو مرور کنیم',
                                            style: new TextStyle(
                                              fontFamily: 'XPZibaRegular',
                                              fontSize: 23.0*wScale,

                                            ),
                                          ))
                                  )),
                            ],
                          )
                       )
                          )
                    )
                  ),
                )
            )
          ]
      )
   );
  }
}