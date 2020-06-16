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
    //print(username);

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
    final String username = ModalRoute.of(context).settings.arguments;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              child: Container(
                                color: Colors.lightBlue,
                                child: Card(
                                  child: SizedBox(
                                    width: 205.0,
                                    height: 300.0,
                                      child: Center(
                                        child: Text(
                                            "My Flash Card Sets",
                                            style: TextStyle(
                                                fontSize: 20
                                            )
                                        ),
                                      ),
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
                            child: Container(
                              color: Colors.blueAccent,
                              child: Card(
                                child: SizedBox(
                                  width: 205.0,
                                  height: 300.0,
                                  child: Center(
                                      child: Text(
                                          "Practice",
                                          style: TextStyle(
                                              fontSize: 20
                                          ))
                                  ),
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
                            child: Container(
                              color: Colors.blueAccent,
                              child: Card(
                                child: SizedBox(
                                  width: 205.0,
                                  height: 300.0,
                                  child: Center(
                                    child: Text(
                                        "Achievements",
                                        style: TextStyle(
                                          fontSize: 20
                                        )
                                    ),
                                  ),
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
                        child: Container(
                          color: Colors.lightBlue,
                          child: Card(
                            child: SizedBox(
                              width: 205.0,
                              height: 300.0,
                              child: Center(
                                  child: Text(
                                      "Setting",
                                      style: TextStyle(
                                          fontSize: 20
                                      )
                                  )
                              ),
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
          ),

            Container(
              color: Colors.lightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    height: 100,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Welcome "+username+" let's start!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          )
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
            ],
      ),
    );
  }
}
