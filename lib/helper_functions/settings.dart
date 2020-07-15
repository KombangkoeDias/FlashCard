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
        return {"ThemeColor":Colors.lightBlue,"TextColor": Colors.indigo, "ActionColor": Colors.red};
      }
      break;
      case 'green':{
        return {"ThemeColor":Colors.lightGreen, "TextColor": Colors.indigo, "ActionColor": Colors.pink};
      }
      break;
      case 'red':{
        return {"ThemeColor":Colors.red, "TextColor": Colors.indigo, "ActionColor": Colors.deepOrange};
      }
      break;
      case 'yellow':{
        return {"ThemeColor":Colors.yellow, "TextColor": Colors.indigo, "ActionColor": Colors.red};
      }
      break;
    }
  }
  catch(e){
    print(e.toString());
    return {"ThemeColor": Colors.blue};
  }
}
