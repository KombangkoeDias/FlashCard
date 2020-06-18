import 'package:flutter/material.dart';
import 'package:flashcard/myCard.dart';

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
