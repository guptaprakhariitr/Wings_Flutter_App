

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wingsteam/signup/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class TeacherHome extends StatefulWidget{
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  String _heading='Class';
 String _teacher='Teacher';
  DateTime dateTime = DateTime.now();
  Auth auth = new Auth();
  final firestoreInstance = Firestore.instance;
  void setProfile() async{
    Future<FirebaseUser> firebaseUser= auth.getCurrentUser();
    await firebaseUser.then((value) {

      Timestamp myTimeStamp = Timestamp.fromDate(dateTime);
      firestoreInstance.collection("class").document("class").collection(value.email).add(
          {
            "time" : myTimeStamp,
            "role" : _heading,
            "teacher":_teacher
          }).then((value){
            setState(() async{
              await Fluttertoast.showToast(
                  msg: "Class Created",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 2,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true));
            });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 410, height: 703, allowFontScaling: true);
    // TODO: implement build
    return Scaffold(
    body:  Column(
      children: <Widget>[
        showHeadinglInput("Class Name or Lecture Topic",0),
           Padding(
             padding: EdgeInsets.fromLTRB(16, 40, 0, 20),
             child: Row(
               children: <Widget>[
                 SizedBox(width: 20,height: 20,),
                 Icon(Icons.timer),
                 FlatButton(
                    onPressed: () {
                      DatePicker.showTimePicker(context, showTitleActions: true, onChanged: (date) {
                        print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        dateTime = date;
                        setState(() {
                        });
                      }, currentTime: DateTime.now());
                    },
                    child: Text(
                      'Class Timing Are :\n'+dateTime.hour.toString()+" : " + dateTime.minute.toString()+" : "+dateTime.second.toString(),
                      style: TextStyle(color: Colors.blue,fontSize: 20),

                    )),
                  Text(
               'today on '+dateTime.day.toString()+" / " + dateTime.month.toString(),
               style: TextStyle(color: Colors.black,fontSize: 10)),
               ],
             ),
           ),
        showHeadinglInput("Teacher's Name", 1),
        showSetCall(),
        allgo(),
      ],
    ),
    );
  }
  Widget showSetCall() {
    return new Container(
        margin: EdgeInsets.only(left: 120,
            right: 120,
            top: 45,
            bottom: ScreenUtil().setWidth(10)),
        child: SizedBox(
          //height: 45.0,
            child: new FlatButton(
              onPressed: () {
                setProfile();
              },
              shape: new RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue,
                    style: BorderStyle.solid,
                    width: 1
                ),
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(5,
                  9,
                  5,
                  8,),
                child: new Text('Schedule Class',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),),
                  //  onPressed: validateAndSubmit,
                ),
              ),
            )));
  }
  Widget allgo() {
    return new Container(
        margin: EdgeInsets.only(left: 120,
            right: 120,
            top: 10,
            bottom: 10),
        child: SizedBox(
          //height: 45.0,
            child: new FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "allclassTeacher");
              },
              shape: new RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue,
                    style: BorderStyle.solid,
                    width: 1
                ),
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(5,
                  9,
                  5,
                  8,),
                child: new Text('All Class',
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),),
                  //  onPressed: validateAndSubmit,
                ),
              ),
            )));
  }
  Widget showHeadinglInput(String topic,int set) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0.0),
      child: new TextFormField(
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (text) {
          if(set==0)
          {_heading = text;}
          else if(set==1){
            _teacher = text;
          }
        },
        maxLines: 1,
        keyboardType: TextInputType.multiline,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: topic,
          hintStyle:  GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, 0.4),)),
          icon: new Icon(
            Icons.trip_origin,
            color: Colors.black,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),),
        validator: (value) => value.isEmpty ? "Empty Topic!!!!" : null,
        onSaved: (value) => _heading = value.trim(),
      ),
    );
  }
}
