import 'package:flutter/material.dart';
import 'package:az_man_bepors/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("fa", "IR")],

        debugShowCheckedModeBanner: false,

      locale: Locale("fa", "IR"),
      title: 'My Login App',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: routes,
    );
  }


}