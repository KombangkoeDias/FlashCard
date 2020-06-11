import 'package:flutter/material.dart';
import 'package:flashcard/FirstScreen.dart';
import 'package:flashcard/SecondScreen.dart';
import 'package:flashcard/ThirdScreen.dart';
import 'package:flashcard/FourthScreen.dart';


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
        '/': (context) => HomeScene(),
        '/first': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
        '/fourth': (context) => FourthScreen()
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
        body: myCard(

        )
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
                                      child: Text("This is a card"),
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
                                    child: Text("This is another card")
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
                                  child: Text("This is a card"),
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
                                child: Text("This is another card")
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
