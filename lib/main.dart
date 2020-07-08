import 'package:flutter/material.dart';
import 'package:flashcard/FirstScreen.dart'; //FirstScreen
import 'package:flashcard/SecondScreen.dart'; //SecondScreen
import 'package:flashcard/ThirdScreen.dart'; //ThirdScreen
import 'package:flashcard/FourthScreen.dart'; //FourthScreen
import 'package:flashcard/login.dart'; //loginScreen
import 'package:flashcard/signup.dart'; //signupScreen
import 'package:flashcard/Home.dart'; //HomeScreen
import 'package:flashcard/configureSet.dart'; //configureSetScreen
import 'package:flashcard/PracticeScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LogIn(),
        '/home': (context) => HomeScene(),
        '/first': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
        '/fourth': (context) => FourthScreen(),
        '/signup': (context) => SignUp(),
        '/set': (context) => ConfigureSetScreen(),
        '/practice': (context) => PracticeScreen()
      }
    );
  }
}


