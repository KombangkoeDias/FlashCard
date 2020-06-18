import 'package:flutter/material.dart';
BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}

class myCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String username = ModalRoute
        .of(context)
        .settings
        .arguments;
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
                          onTap: () {Navigator.pushNamed(context, '/first');},
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
                        onTap: () {Navigator.pushNamed(context, '/second');},
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
                        onTap: () {Navigator.pushNamed(context, '/third');},
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
                        onTap: () {Navigator.pushNamed(context, '/fourth');},
                        child: Card(
                            child: Center(
                                child:Text(
                                    "Edit"
                                )
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.lightBlue,
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
                                    color: Colors.white,
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
