import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/myCard.dart';

class HomeScene extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    //print(username);
    final String username = ModalRoute
        .of(context)
        .settings
        .arguments;
    String myuser = username;
    print(username + "Home");
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                        width: 80,
                        height: 80,
                        child: Image(image: AssetImage('lib/Assets/logo.png'))
                    ),
                    Text(
                      "Flash",
                      style: TextStyle(
                        fontSize: 30
                      )
                    )
                  ],
                ), //logo,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('My Flash Cards'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/first', arguments: myuser);
                },
              ),
              ListTile(
                title: Text('Edit Flash Cards'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/second', arguments: myuser);
                },
              ),
              ListTile(
                title: Text('Achievements'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/third', arguments: myuser);
                },
              ),
              ListTile(
                  title: Text('Edit'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/fourth', arguments: myuser);
                  }
              )
            ]
        ),
      ),
    );
  }
}
