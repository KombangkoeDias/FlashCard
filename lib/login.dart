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
                width: 200.0,
                height: 240.0,
                child: SizedBox(width: 0,height: 0) //logo
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
                child: Text(
                  'forget username?'
                )
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
                  child: Text(
                      'forget password?'
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
