import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/helper_functions/settings.dart';
BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}

class myCard extends StatefulWidget {
  @override
  _myCardState createState() => _myCardState();
}

class _myCardState extends State<myCard> {
  MaterialColor ThemeColor;
  Color TextColor;
  bool onetime = true;
  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute
        .of(context)
        .settings
        .arguments;
    if (onetime){
      readColor().then((color) {
        setState(() {
          ThemeColor = color['ThemeColor'];
          TextColor = color['TextColor'];
          onetime = false;
        });
      });
    }
    return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                     Expanded(
                       child: GestureDetector(
                          onTap: () {Navigator.pushNamed(context, '/first',arguments: username);},
                          child: Card(
                              child:Center(
                                  child:Text(
                                      "My Flash Card Sets"
                                  )
                              )
                          ),
                        ),
                     ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {Navigator.pushNamed(context, '/second',arguments: username);},
                        child: Card(
                            child: Center(
                                child:Text(
                                    "Practice"
                                )
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {Navigator.pushNamed(context, '/third',arguments: username);},
                        child: Card(
                            child:Center(
                                child:Text(
                                    "Achievements"
                                )
                            )
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {Navigator.pushNamed(context, '/fourth',arguments: username).then((_) async {
                          var color = await readColor();
                          setState(() {
                            ThemeColor = color['ThemeColor'];
                          });
                        });},
                        child: Card(
                            child: Center(
                                child:Text(
                                    "Setting"
                                )
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: ThemeColor,
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Welcome "+username+" let's start!",
                                style: TextStyle(
                                    color: TextColor,
                                    fontSize: 20
                                )
                            ),
                          ],
                        )
                  ],
                ),
              ),
            ],
        ),
    );
  }
}
