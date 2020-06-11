import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Center(
                child: Text(
                    'Flash Cards',
                ),
              ),
          ),
          body: myCard(

          )
      ),
    );
  }
}

class myCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(

        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                  Card(
                    child: Text("This is a card"),
                  ),
              ]
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                  Card(
                      child: Text("This is another card")
                  ),
              ],
            ),
          )
        ],
      )
    );
  }
}
