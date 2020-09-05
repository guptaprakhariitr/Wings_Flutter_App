import 'dart:async';

import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home.dart';


class ShrineApp extends StatefulWidget {
  static final navKey = new GlobalKey<NavigatorState>();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home>  {

  @override
  void initState() {
    super.initState();


    AlanVoice.addButton(
        "50b713282aff9cdc652df8e0f35befd32e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT
    );

    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
    void _handleCommand(Map<String, dynamic> command) {
      //call client code that will react to the received command
    }
  }


  void _handleCommand(Map<String, dynamic> command) {
    debugPrint("New command: ${command}");
    switch (command["command"]) {
     // case "How are you":
       // _handleClearOrder();
        //break;

      default:
        debugPrint("Unknown command: ${command}");
    }
  }