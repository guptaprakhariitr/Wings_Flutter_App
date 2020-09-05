import 'package:flutter/material.dart';
import 'signup/teacher.dart';
import 'signup/auth.dart';
import 'signup/root_page.dart';
class Home extends StatelessWidget {
  static String routeName="home";
  Auth auth = new Auth();
  // This widget is the root of your application.
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

