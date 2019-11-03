import 'package:az_man_bepors/screens/gradePage/GradesPage.dart';
import 'package:az_man_bepors/screens/lessonsScreen/LessonsPage.dart';
import 'package:az_man_bepors/screens/login/SignUpScreen.dart';
import 'package:az_man_bepors/screens/logoPage/LogoPage.dart';
import 'package:az_man_bepors/screens/testPage/ResultPage.dart';
import 'package:az_man_bepors/screens/testPage/TestPage.dart';
import 'package:flutter/material.dart';
import 'package:az_man_bepors/screens/login/login_screen.dart';

final routes = {
  '/login': (BuildContext context) => new LoginScreen(),
  '/SignUpScreen': (BuildContext context) => new SignUpScreen(),
'/grade page' : (BuildContext context) => new GradesPage(),
  '/': (BuildContext context) => new LogoScreen(),
  LessonsScreen.routeName: (context) => new  LessonsScreen(),
  TestPage.routeName:(context) => new TestPage(),
  ResultPage.routeName:(context) => new ResultPage()
};

