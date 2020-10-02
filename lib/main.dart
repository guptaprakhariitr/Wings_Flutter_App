import 'package:flutter/material.dart';
import 'package:wingsteam/home.dart';
import 'package:wingsteam/signup/login.dart';
import 'package:wingsteam/signup/teacher.dart';
import 'signup/root_page.dart';
import 'signup/auth.dart';
import 'pages/index.dart';
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
        'call' :(BuildContext context) => new IndexPage(),
      },
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared = "No data";

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(dataShared)));
  }

  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData;
      });
    }
  }
}

