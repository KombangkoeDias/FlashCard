import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flashcard/helper_functions/files.dart';
import 'package:flashcard/helper_functions/settings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool value = true;
  bool onetime = true;
  bool remember = false;
  bool loading = false;
  final UsernameController = TextEditingController();
  final PasswordController = TextEditingController();
  MaterialColor ThemeColor = Colors.lightBlue;


  Future<List> userLogIn() async {

    try {

      final response = await http.post(
          "http://10.0.2.2/flash_card/login.php",
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
      if (response.statusCode == 200){
        setState(() {
          value = true;
        });

      }
    }
    catch(e){
      setState(() {
        value = false;
      });
    }
    if (value){
      if (remember){
        await writeUser(UsernameController.text);
        print("write");
      }
      Navigator.popAndPushNamed(context, '/home',arguments: UsernameController.text);
    }
  }

  @override
  void dispose(){
    UsernameController.dispose();
    PasswordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
      if (onetime){
        loading = true;
        readUser().then((user) {
          print(user);
          if (user != 'error'){
            Navigator.popAndPushNamed(context, '/home', arguments: user);
          }
        });
        readColor().then((color) async {
          if (color == Colors.lightBlue){
            await writeColor('blue');
            var newcolor = await readColor();
            setState(() {
              ThemeColor = newcolor['ThemeColor'];
            });
          }
          else{
            setState(() {
              ThemeColor = color['ThemeColor'];
            });
          }
          onetime = false;
          loading = false;
        });

      }
      if (loading){
        return Center(
            child: SpinKitChasingDots(
              color: Colors.blue,
              size: 50.0,
            )
        );
      }
      else
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
                      child: Image(
                          image: AssetImage('lib/Assets/logo.png')) //logo
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
                              color: ThemeColor,
                              fontSize: 40
                          )
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 50,
                      width: 400,
                      child: Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: !value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Incorrect Username or Password",
                                style: TextStyle(
                                    color: Colors.redAccent
                                )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    "Don't have an account? Sign Up "
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                      "Here",
                                      style: TextStyle(
                                          color: ThemeColor
                                      )
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
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
                                  borderSide: BorderSide(
                                      color: ThemeColor)
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
                                  borderSide: BorderSide(
                                      color: ThemeColor)
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
                      width: 200,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              'forget username or password?'
                          ),
                          CheckboxListTile(
                            value: remember,
                            onChanged: (bool value) {
                              setState(() {
                                remember = value;
                              });
                            },
                            title: Text(
                                "remember me"
                            ),

                          )
                        ],
                      )
                  ),
                  FlatButton(
                    color: ThemeColor,

                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 20
                              )
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      userLogIn();
                    },
                  ),
                  SizedBox(
                    height: 30,
                    width: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Text("Don't have account yet? Sign Up "),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                              "Here",
                              style: TextStyle(
                                  color: ThemeColor
                              )
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
      );
    }
}
