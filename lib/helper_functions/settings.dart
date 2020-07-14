import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _ColorFilelocation async {
  final path = await _localPath;
  return File('$path/color.txt');
}

Future<File> writeColor(String color) async{
  final file = await _ColorFilelocation;
  return file.writeAsString(color);
}

Future<Map<String,dynamic>> readColor() async {
  try{
    final file = await _ColorFilelocation;
    String contents = await file.readAsString();

    switch(contents){
      case 'blue':{
        print('blue theme');
        return {"ThemeColor":Colors.lightBlue,"TextColor": Colors.black87, "ActionColor": Colors.red};
      }
      break;
      case 'green':{
        print("green theme");
        return {"ThemeColor":Colors.lightGreen, "TextColor": Colors.black, "ActionColor": Colors.pink};
      }
      break;
      case 'red':{
        print("red theme");
        return {"ThemeColor":Colors.red, "TextColor": Colors.black87, "ActionColor": Colors.cyan};
      }
      break;
      case 'yellow':{
        print("yellow theme");
        return {"ThemeColor":Colors.yellow, "TextColor": Colors.black, "ActionColor": Colors.red};
      }
      break;
    }
  }
  catch(e){
    print(e.toString());
    return {"ThemeColor": Colors.blue};
  }
}
