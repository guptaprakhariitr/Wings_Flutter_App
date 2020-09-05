import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wingsteam/signup/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class AllClassTeacher extends StatefulWidget {
  @override
  _AllClassTeacherState createState() => _AllClassTeacherState();
}

class _AllClassTeacherState extends State<AllClassTeacher> {
  Widget homesc = Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ),
  );
  Auth auth = new Auth();

  final firestoreInstance = Firestore.instance;

  List<Timestamp> listTime=[];

  List<String> listTopic=[];

  void setProfile() async{
    Future<FirebaseUser> firebaseUser= auth.getCurrentUser();
    print("shuru");
    await firebaseUser.then((value) async{
      await firestoreInstance.collection("class")
              .document("class")
              .collection(value.email)
              .getDocuments()
              .then((querySnapshot) {
            querySnapshot.documents.forEach((result) {
              print(result.data);
               listTime.add(result.data["time"]);
              listTopic.add(result.data["role"]);
            });
          });
    });
    print("khatam");
    print(listTime.length.toString());
    homesc= ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: listTime.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index)
    {
      DateTime dateTimeCheck = listTime[index].toDate();
      final differenceInDays = dateTimeCheck
          .difference(DateTime.now())
          .inHours;
      print(differenceInDays);
      print("insider");
      if (differenceInDays >= -1) {
        final time = listTime[index];
        final role = listTopic[index];
      DateTime dateTime = time.toDate(); // TimeStamp to DateTime
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
        child: Column(
          children: <Widget>[
            Divider(
              color: Colors.black,
              height: 20,
            ),
            Row(
              children: <Widget>[
                Text((index+1).toString(),style: TextStyle(color: Colors.black,fontSize: 15),),
                SizedBox(width: 15,),
                Column(
                  children: [
                    Text(role,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),),
                      //  onPressed: validateAndSubmit,
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Class Timing :\n' + dateTime.hour.toString() + " : " +
                          dateTime.minute.toString() + " : " + dateTime.second.toString(),
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )

                  ],
                ),
                SizedBox(width: 25,),
              FlatButton(
                  onPressed:(){

              },
                  child:Text(
               "Start Class",
                style: TextStyle(color: Colors.red, fontSize: 15),
              )),
              ],
            ),
            Divider(
              color: Colors.black,
                height: 20,
    ),
          ],
        ),
      );
    }
      else{
        return Container();
      }
      },
    );
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setProfile();
  }

  @override
  Widget build(BuildContext context) {
    print("aa gye");
    return Scaffold(
      appBar: AppBar(
        title: Text("All Scheduled Classes"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30,1, 0),
        child: homesc,
      ),
    );
  }
}

