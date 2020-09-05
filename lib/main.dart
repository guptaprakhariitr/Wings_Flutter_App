import 'package:flutter/material.dart';
import 'package:wingsteam/home.dart';
import 'package:wingsteam/signup/login.dart';
import 'package:wingsteam/signup/teacher.dart';
import 'signup/root_page.dart';
import 'signup/auth.dart';
import 'Allclass/allclass.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new Home(),
        '/' : (BuildContext context) => new RootPage(auth: Auth()),
        'allclassTeacher' :(BuildContext context) => new AllClassTeacher(),
      },
    );
  }
}

