import 'package:path_provider/path_provider.dart';
import 'dart:io';
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/user.txt');
}

Future<File> writeUser(String user) async{
  final file = await _localFile;

  return file.writeAsString(user);
}

Future<File> deleteUser() async{
  try{
    final file = await _localFile;
    file.delete();
  }
  catch(err) {
    return null;
  }
}

Future<String> readUser() async {
  try{
    final file = await _localFile;
    String contents = await file.readAsString();

    return contents;
  }
  catch(e){
    return "error";
  }
}