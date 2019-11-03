import 'package:audioplayers/audio_cache.dart';
import 'package:az_man_bepors/models/Qustion.dart';
import 'package:az_man_bepors/models/TestPageModel.dart';
import 'package:az_man_bepors/screens/testPage/ResultPage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_view/flutter_flip_view.dart';



double wScale =1;
double hScale =1;
AudioCache player = AudioCache(prefix: 'audio/');
// ignore: must_be_immutable
class TestPage extends StatefulWidget{

  int wrongAnswers ;
  int rightAnswers ;
  int currentWordIndex ;

  List <Question> wrongWords = new List<Question>();

  static const routeName = '/TestPage';

  @override
  State<StatefulWidget> createState() {
    return new TestPageState(0,0);
  }

}
class TestPageState extends State<TestPage> with SingleTickerProviderStateMixin {
  int wrongAnswers = 0;
  int rightAnswers = 0 ;
  int  backIndex  = 0;
  int  frontIndex  = -1;

   List<Question> words ;

  TestPageState(this.wrongAnswers,this.rightAnswers);


  List <Question> wrongWords = [];
  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.addStatusListener((AnimationStatus status) {
      if (!_focusNode.hasFocus && _animationController.isCompleted) {
        setState(() {
          FocusScope.of(context).requestFocus(_focusNode);

        });
      } else if (_focusNode.hasFocus && !_animationController.isCompleted) {
        _focusNode.unfocus();
      }
    });
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }


  @override
  Widget build(BuildContext context) {

    wScale = (MediaQuery.of(context).size.width/432.0);
     hScale = (MediaQuery.of(context).size.height/816.0);

    words = ModalRoute.of(context).settings.arguments;

     return new Scaffold(

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
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: FlipView(
              animationController: _curvedAnimation,
              front: _buildFrontSide(),
              back: _buildBackSide(),
            ),
          ),
        ),
    ])
    );
  }


  Widget _buildFrontSide() {
if (frontIndex>=words.length-1){}
else{frontIndex++;}

    print('in front');
    print(frontIndex);
    return new Center(

            child :
         DecoratedBox(
        decoration: const BoxDecoration(
        color: Colors.white
    ),
         child :new SizedBox(

              height: 270*hScale,
                width: 270*wScale,


          child :DottedBorder(
          dashPattern: [10, 5, 10, 5],
          color: new Color.fromARGB(500,238,108,77),
//                  color: new Color.fromARGB(200, 112, 131, 191),
//                  color: new Color.fromARGB(500,41,50,65),
          strokeWidth: 3*wScale,


              child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: new Column(

                      children: <Widget>[

                        new Center(
                            child :new Text(
                               words[frontIndex].questionText ,
                            style: new TextStyle(
                                fontSize: 60.0*wScale
                            )
//               )

                        )),

                        Padding(
                                              padding: EdgeInsets.all(30)),
                      SizedBox(
                      width: 160*wScale, // specific value
                          height: 50*hScale,
                          child:RaisedButton(
                              color: new Color.fromARGB(500,238,108,77),

                          onPressed: (){
//                                print(words[currentWordIndex].questionText );
//                            currentWordIndex++;
                                _flip(true);} ,
                            child: new Center(
                                child: new Text(


                                  ' معنیش چیه؟',
                                  style: new TextStyle(
                                      fontFamily: 'morvarid',
                                      fontSize: 25.0*wScale,

                                  ),
                                ))



                        )),
                      ])
              )
          )
          )
            )
            );
//            : Center(
//            child: CircularProgressIndicator(),
//            );});
}

  Widget _buildBackSide() {


    print('in back');
    return new Center(

        child :
        DecoratedBox(
        decoration: const BoxDecoration(
        color: Colors.white
    ),
          child :new SizedBox(

          height: 270*hScale,
          width: 270*wScale,


            child :DottedBorder(
            dashPattern: [10, 5, 10, 5],
            color: new Color.fromARGB(500,238,108,77),
            strokeWidth: 3*wScale,


              child: Padding(
              padding: EdgeInsets.only(top: 30),
                child: new Column(

                children: <Widget>[

                  new Center(


              child: new Text(

                  words[backIndex].definition,
                  style: new TextStyle(
                      fontSize: 60.0*wScale
                  )
              )
          ),
          new Padding(padding:EdgeInsets.all(3) ),
          new IconButton(
            icon : Icon( Icons.play_circle_outline),
            onPressed:() {

              player.play('1.mp3');

            },
          ),

          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                  width: 110*wScale, // specific value
                  height: 40*hScale,

             child :RaisedButton(
                              color: new Color.fromARGB(500,238,108,77),

                          onPressed: (){
                                print('lenght of word');
                            print(words.length);
                            print(backIndex);
                            if(backIndex>=words.length-1){
                              print('--------------------------------------------');
                              Navigator.pushNamed(context, ResultPage.routeName,arguments:TestPageModel(rightAnswers,wrongAnswers,wrongWords));
                            }
                                else{
//                              currentWordIndex++;
                              backIndex++;
                              rightAnswers++;
                                  print('in else');
//                              print(currentWordIndex);


                                _flip(false);}
                                 },
                            child: new Center(
                                child: new Text(
                                'درست گفتم:)',
                                  style: new TextStyle(
                                      fontFamily: 'morvarid',
                                      fontSize: 16.0*wScale,

                                  ),
                                ))



                        )),
              SizedBox(
                  width: 110, // specific value
                  height: 40,
              child :
              RaisedButton(
                  color: new Color.fromARGB(500,238,108,77),

                  onPressed: (){
                    print('lenght of word');
                    print(words.length);
                    print(backIndex);
                    wrongWords.add(words[backIndex]);

                    if(backIndex>=words.length-1){
                      print('--------------------------------------------');
                      Navigator.pushNamed(context, ResultPage.routeName,arguments:TestPageModel(rightAnswers,wrongAnswers,wrongWords));
                    }
//                    (words[currentWordIndex]);
                  else{
                    backIndex++;
                      wrongAnswers++;
                    print('in else');


                    _flip(false);}
                  } ,
                  child: new Center(
                      child: new Text(

                        'اشتباه کردم:(',
                        style: new TextStyle(
                          fontFamily: 'morvarid',
                          fontSize: 16.0*wScale,

                        ),
                      ))



              ) )

    ]
          )
    ]
    )
    )
    )
    )
        )



    );
  }

}
