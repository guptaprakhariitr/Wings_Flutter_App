
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wingsteam/homepage/teacher.dart';
import 'signup/teacher.dart';
import 'signup/auth.dart';
import 'signup/root_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homepage/student.dart';
import 'homepage/teacher.dart';
class Home extends StatefulWidget {
  static String routeName="home";
   Widget homesc = Scaffold(
     body: Container(
       alignment: Alignment.center,
       child: CircularProgressIndicator(),
     ),
   );

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth auth = new Auth();
  final firestoreInstance = Firestore.instance;
  void setProfile() async{
    Future<FirebaseUser> firebaseUser= auth.getCurrentUser();
    await firebaseUser.then((value) {
      firestoreInstance.collection("users").document(value.email).get().then((value){
        if(value.data["role"]=="Teacher"){
          widget.homesc = TeacherHome();
          setState(() {

          });
        }
        else{
          widget.homesc = StudentHome();
          setState(() {
          });
        }
      });
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
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.indigo[800],
          title: Text("Home"),
          actions: <Widget>[
            IconButton(
                tooltip: 'log out',
                icon: const Icon(Icons.power_settings_new),
                onPressed: () async {
                  //  final int selected = await showSearch<int>();
                  showConfirmationDialog(context);
                }
            ),
            IconButton(
                tooltip: 'search',
                icon: const Icon(Icons.search),
                onPressed: () async {
                  // showConfirmationDialog(context)
                }
            ),
          ],
        ),
        SliverToBoxAdapter(
            child: Container(
                height: 900,
                child: widget.homesc)
        ),
      ],

    );
  }

  void showConfirmationDialog(BuildContext context)
  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text('Are you sure want to log out?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        child: Text('yes',
                          style: TextStyle(
                            color: Colors.grey,
                          ),),
                        onPressed: ()
                        {
                          auth.signOut();
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (BuildContext context) => RootPage(auth:new Auth())),
                              ModalRoute.withName('/'));
                        },
                      ),
                      FlatButton(
                        child: Text('no',
                          style: TextStyle(
                              color: Colors.blue
                          ),),
                        onPressed: ()
                        {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

