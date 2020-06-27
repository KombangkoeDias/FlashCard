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
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('My Flash Cards'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/first', arguments: username);
                },
              ),
              ListTile(
                title: Text('Edit Flash Cards'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/second', arguments: username);
                },
              ),
              ListTile(
                title: Text('Achievements'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/third', arguments: username);
                },
              ),
              ListTile(
                  title: Text('Edit'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/fourth', arguments: username);
                  }
              )
            ]
        ),
      ),
    );
  }
}
