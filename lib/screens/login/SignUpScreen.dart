import 'dart:async';
import 'dart:ui';

import 'package:az_man_bepors/data/DataBaseHelper.dart';
import 'package:az_man_bepors/models/User.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:az_man_bepors/screens/login/login_screen_presenter.dart';
import 'package:flutter/material.dart' as prefix0;

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen>
    implements LoginScreenContract{
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password ,_username,_email;
  int _mobile;

  LoginScreenPresenter _presenter;

  SignUpScreenState() {

    _presenter = new LoginScreenPresenter(this);
//    var authStateProvider = new AuthStateProvider();
//    authStateProvider.subscribe(this);
  }


  void _signUp() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doSignUp(_username , _mobile , _password , _email );
    }
  }

  void _showSnackBar(String text) {
    if(text != null){
      scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text(text)));}
  }



  @override
  Widget build(BuildContext context) {
    final double wScale = (MediaQuery.of(context).size.width/432.0);
    final double hScale = (MediaQuery.of(context).size.height/816.0);
    _ctx = context;

    var loginForm =
           new Column(

              children: <Widget>[

               Padding(
                 padding : EdgeInsets.only(top:8.0)
                   ,child : new Text(
                  "ثبت نام",
                  textScaleFactor: 2.0*wScale,
                  style: new TextStyle(
                    fontFamily: 'morvarid',
                    fontSize: 20.0*wScale,
//           color:  new Color.fromARGB(500, 112, 131, 191),
                    color: new Color.fromARGB(500,238,108,77),
                  ),


                )),
                new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      new Padding(
//                padding: const EdgeInsets.fromLTRB(0.3,0.2,0.8,1.0),
                        padding: const EdgeInsets.all(0.1),
                        child: new TextFormField(
                          onSaved: (val) => _username = val,
                          validator: (val) {
                            if (val.isEmpty) {

                              return 'Please enter some text';
                            }
                            return null;

                          },
                          decoration: new InputDecoration(


                              labelStyle: TextStyle(
                                color: new Color.fromARGB(500,41,50,65),
                                fontFamily: 'morvarid',
                              ) , labelText:  "نام کاربری : "),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(0.8),
                        child: new TextFormField(
                          obscureText: true,
                          onSaved: (val) => _password = val,
                          validator: (val) {
                            if (val.isEmpty) {

                              return 'Please enter some text';
                            }
                            return null;},

                          decoration: new InputDecoration(
                              labelStyle: TextStyle(
                                color: new Color.fromARGB(500,41,50,65),
                                fontFamily: 'morvarid',
                              ),
                              labelText: "کلمه ی عبور : "),
                        ),
                      ),
                      new Padding(
//                padding: const EdgeInsets.fromLTRB(0.3,0.2,0.8,1.0),
                        padding: const EdgeInsets.all(0.8),
                        child: new TextFormField(
                          onSaved: (val) => _mobile = int.parse(val) ,
                          validator: (val) {
                            if (val.isEmpty) {

                              return 'Please enter some text';
                            }
                            return null;

                          },
                          decoration: new InputDecoration(


                              labelStyle: TextStyle(
                                color: new Color.fromARGB(500,41,50,65),
                                fontFamily: 'morvarid',
                              ) , labelText:  "شماره موبایل : "),
                        ),
                      ),
                      new Padding(
//                padding: const EdgeInsets.fromLTRB(0.3,0.2,0.8,1.0),
                        padding: const EdgeInsets.all(0.8),
                        child: new TextFormField(
                          onSaved: (val) => _email = val,
                          validator: (val) {
                            if (val.isEmpty) {

                              return 'Please enter some text';
                            }
                            return null;

                          },
                          decoration: new InputDecoration(


                              labelStyle: TextStyle(
                                color: new Color.fromARGB(500,41,50,65),
                                fontFamily: 'morvarid',
                              ) , labelText:  "  ایمیل: "),
                        ),
                      ),
                    ],
                  ),
                ),
//        _isLoading ? new CircularProgressIndicator() : loginBtn
//
                new Center(
                    child :

                          new RaisedButton(
                            onPressed: _signUp,
                            child: new Text("ورود" ,style : new TextStyle(fontFamily: 'morvarid')),
//                color:  new Color.fromARGB(200, 112, 131, 191),
                            color: new Color.fromARGB(500,238,108,77),
                          ),
                        )],
              crossAxisAlignment: CrossAxisAlignment.center,
            );

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/images/oie_AMe1bb4IfwHQ.png"),
              fit: BoxFit.cover),
        ),
        child: new Center(

            child:DottedBorder(
    dashPattern: [10, 5, 10, 5],
//                  color: new Color.fromARGB(200, 112, 131, 191),
    color: new Color.fromARGB(500,238,108,77),
    strokeWidth: 5*wScale,
    child:new SizedBox(
              width:350*wScale ,
              height: 450*hScale,
              child: loginForm,

//                decoration: new BoxDecoration(
////                    color: Colors.grey.shade200.withOpacity(0.5)),
            )),


        ),
      ),
    );
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(String userName) async {
    print('in login success');
    _showSnackBar(userName);

    Navigator.pushNamed(context, '/grade page');
    setState(() => _isLoading = false);

  }
}