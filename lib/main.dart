import 'package:flutter/material.dart';
import 'package:flashcard/FirstScreen.dart'; //FirstScreen
import 'package:flashcard/SecondScreen.dart'; //SecondScreen
import 'package:flashcard/ThirdScreen.dart'; //ThirdScreen
import 'package:flashcard/FourthScreen.dart'; //FourthScreen
import 'package:flashcard/login.dart'; //loginScreen
import 'package:flashcard/signup.dart'; //signupScreen


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LogIn(),
        '/home': (context) => HomeScene(),
        '/first': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
        '/fourth': (context) => FourthScreen(),
        '/signup': (context) => SignUp(),
      }
    );
  }
}

class HomeScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Flash Cards',
            ),
          ),
        ),
        body: myCard(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                  color: Colors.blue,
                  ),
            ),
            ListTile(
                title: Text('My Flash Cards'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/first');
                  },
            ),
            ListTile(
                title: Text('Edit Flash Cards'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/second');
                  },
            ),
            ListTile(
                title: Text('Achievements'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/third');
                  },
            ),
            ListTile(
                title: Text('Edit'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/fourth');
                  }
            )
          ]
        ),
      ),
    );
  }
}

class myCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        children: <Widget>[
                            GestureDetector(
                              child: Card(
                                child: SizedBox(
                                  width: 205.0,
                                  height: 300.0,
                                    child: Center(
                                      child: Text("My Flash Card Sets"),
                                    ),
                                ),
                              ),
                              onTap: () => Navigator.pushNamed(context, '/first'),
                            ),
                        ]
                      ),
                    ),
                  Column(
                      children: <Widget>[
                          GestureDetector(
                            child: Card(
                              child: SizedBox(
                                width: 205.0,
                                height: 300.0,
                                child: Center(
                                    child: Text("Practice")
                                ),
                              ),
                            ),
                              onTap: () => Navigator.pushNamed(context, '/second')
                          ),
                      ],
                    ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Card(
                              child: SizedBox(
                                width: 205.0,
                                height: 300.0,
                                child: Center(
                                  child: Text("Achievements"),
                                ),
                              ),
                            ),
                            onTap: () => Navigator.pushNamed(context, '/third'),
                          ),
                        ]
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Card(
                          child: SizedBox(
                            width: 205.0,
                            height: 300.0,
                            child: Center(
                                child: Text("Setting")
                            ),
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, '/fourth'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
