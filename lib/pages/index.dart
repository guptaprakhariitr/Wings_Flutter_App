import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

import './call.dart';
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
class IndexPage extends StatefulWidget {
  String title;
  String message;

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {

  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    widget.message = args.message;
    widget.title = args.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Class'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 30, 0, 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 800,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                      widget.message,style: TextStyle(
                        fontSize: 19,color: Colors.black
                      ),
                  ))
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title: Text("Teacher"),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
 /*                 ListTile(
                    title: Text(ClientRole.Audience.toString()),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  )*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: getit(args.title),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget getit(String std){
    if(std!="std") {
      return RaisedButton(
        onPressed: onJoin,
        child: Text('Join'),
        color: Colors.blueAccent,
        textColor: Colors.white,
      );
    }
    else {
      return Container(
        height: 450,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent)
        ),
        child: GestureDetector(
          onVerticalDragEnd:(details) async {
            try {
              Vibration.vibrate();
            }
            catch(e){

            }
            onJoin();
          },
        ),
      );
    }
  }
  Future<void> onJoin() async {
    // update input validation
    if (true) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: widget.message,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
