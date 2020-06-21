import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final UsernameController = TextEditingController();
  final PasswordController = TextEditingController();

  Future<List> sendData() async {
    bool value = true;
    try {
      final response = await http.post(
          "http://10.0.2.2/flash_card/signup.php",
          body: {
            "username": UsernameController.text,
            "password": PasswordController.text
          }
      );
      print(response.statusCode);
      if (response.statusCode == 404){
        setState(() {
          value = false;
        });
      }
      if (response.statusCode == 200) {
        setState(() {
          value = true;
        });
      }
    }
    catch(e){
      print(e);
      value = false;
    }
    if (value){
      Navigator.pop(context);
    }
    else{
      print("error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                        "Sign Up",
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
                        controller: UsernameController,
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
                        obscureText: true,
                        controller: PasswordController,
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
                            'Sign Up!',
                            style: TextStyle(
                                fontSize: 20
                            )
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {sendData();},
                )
              ],
            ),
          ),
        )
    );
  }
}
