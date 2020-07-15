import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/myCard.dart';
import 'package:flashcard/helper_functions/files.dart';
import 'package:flashcard/helper_functions/settings.dart';

class HomeScene extends StatefulWidget {
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomeScene> {
  MaterialColor ThemeColor = Colors.lightBlue;
  Color TextColor = Colors.black;
  bool onetime = true;

  Future<void> loadColor(){
      readColor().then((color) {
        if (color['ThemeColor'] != ThemeColor){
          setState(() {
            ThemeColor = color['ThemeColor'];
            TextColor = color['TextColor'];

          });
        }
        onetime = false;
        Future.delayed(const Duration(milliseconds: 500), () {
          loadColor();
        });
      });

  }
  @override

  Widget build(BuildContext context) {
    //print(username);
    final String username = ModalRoute
        .of(context)
        .settings
        .arguments;
    String myuser = username;
    if (onetime){
      loadColor();
    }



    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: TextColor
        ),
        backgroundColor: ThemeColor,
        title: Center(
          child: Text(
            'Flash Cards',
            style: TextStyle(
              color: TextColor
            )
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
                  color: ThemeColor,
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
                  title: Text('Setting'),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/fourth', arguments: myuser);
                  }
              ),
              ListTile(
                  title: Text('logout'),
                  onTap: () async {
                    await deleteUser();
                    print("user deleted");
                    Navigator.popAndPushNamed(context, '/');
                  }
              ),
            ]
        ),
      ),
    );
  }
}
