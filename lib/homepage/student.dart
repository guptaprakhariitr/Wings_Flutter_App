import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wingsteam/pages/index.dart';
import 'package:wingsteam/signup/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';

enum TtsState { playing, stopped, paused, continued }
class StudentHome extends StatefulWidget{

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  Auth auth = new Auth();

  final firestoreInstance = Firestore.instance;

  List<Timestamp> listTime=[];

  List<String> listTopic=[];
  List<Timestamp> listTime2=[];

  List<String> listTopic2=[];

  void setProfile() async {
    Future<FirebaseUser> firebaseUser = auth.getCurrentUser();
    print("shuru");
    await firebaseUser.then((value) async {
      await firestoreInstance.collection("class")
          .document("class")
          .collection("prakhar_g@cs.iitr.ac.in").orderBy("time")
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((result) {
          print(result.data);
          DateTime dateTimeCheck = result.data["time"].toDate();
          final differenceInDays = dateTimeCheck
              .difference(DateTime.now())
              .inHours;
          print(differenceInDays);
          print("insider");
          if(differenceInDays > -1) {
            listTime.add(result.data["time"]);
            listTopic.add(result.data["role"]);
          }
        });
      });
    });
    await firebaseUser.then((value) async {
      await firestoreInstance.collection("class")
          .document("class")
          .collection("prakharajaygupta@gmail.com").orderBy("time")
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((result) {
          print(result.data);
          DateTime dateTimeCheck = result.data["time"].toDate();
          final differenceInDays = dateTimeCheck
              .difference(DateTime.now())
              .inHours;
          print(differenceInDays);
          print("insider");
          if(differenceInDays > -1) {
            listTime2.add(result.data["time"]);
            listTopic2.add(result.data["role"]);
          }
        });
      });
    });
  homesc=GestureDetector(
    onLongPress: () async {
      if(listTopic[0]!=null) {
        Navigator.pushNamed(
            context, 'call', arguments: ScreenArguments("std", listTopic[0]));
      }
      else{
        Navigator.pushNamed(
            context, 'call', arguments: ScreenArguments("std", listTopic2[0]));
      }
    },
  );
  setState(() {
    _speak();
  });
  }
  Widget homesc = Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setProfile();
  }
  FlutterTts flutterTts = FlutterTts();
  String language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;
  dynamic languages;

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }
  Future _speak() async{
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    var result = await flutterTts.speak("Long Press To Enter");
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }
  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }
  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    _speak();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Long Press"

        ),
        backgroundColor: Colors.indigo[800],
      ),
      body:homesc,
    );
  }

}