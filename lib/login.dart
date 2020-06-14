import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
              ),
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Image(image: AssetImage('lib/Assets/logo.png')) //logo
              ),
              SizedBox(
                width: 100,
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 40
                    )
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: 100
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                        ),
                        hintText: 'Username'
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 300,
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: TextField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          hintText: 'Password'
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                  width: 300,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          'forget username or password?'
                      ),
                    ],
                  )
              ),
              FlatButton(
                color: Colors.lightBlue,

                child: SizedBox(
                  width: 100,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Go!',
                        style: TextStyle(
                          fontSize: 20
                        )
                      ),
                    ],
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
        )
    );
  }
}
