
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flashcard/helper_classes/usernameSetname.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flashcard/helper_functions/settings.dart';


class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final nameController = TextEditingController();
  List<Widget> nameList = [];
  List<String> setNames = [];
  String username;
  String action = "";
  bool loading = false;
  MaterialColor ThemeColor = Colors.lightBlue;
  Color TextColor = Colors.black;

  Future<List> Progress(String setName,) async{
    final response = await http.post(
        "http://10.0.2.2/flash_card/addOrUpdateProgress.php",
        body: {
          "setName": nameController.text,
          "username": username,
        }
    );
    print(response.statusCode);
    nameController.clear();
    loadFlashCardName();
  }

  Future<List> deleteSet(String setName) async {
    print(setName + " " + username);
    final response = await http.post(
        "http://10.0.2.2/flash_card/deleteSet.php",
        body: {
          "setName": setName,
          "username": username
        }
    );
    loadFlashCardName();
  }

  Future<void> Actions(String setName){
    print(action);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: action != "" ? (action == "edit" ? Text('Edit Set Name') : Text('Delete Set')) : Text('Choose Action'),
          content: Column(
            children: <Widget>[
              action != "" ? (action == "edit" ? Text('enter the new set name') : Text('Are you sure you want to delete this \n set: ' + setName)) : Text("Select action to perform"),
              Card(
                color: Colors.transparent,
                elevation: 0.0,
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  action = "";
                });
              },
            ),

            if (action == "") CupertinoDialogAction(
              child: Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/set',arguments: usernameSetname(username,setName)).then(
                        (_){
                      loadFlashCardName();
                    }
                );
              },
            ),
            CupertinoDialogAction(
              child: Text('Delete'),
              onPressed: () {
                if (action != "delete"){
                  setState(() {
                    action = "delete";
                  });
                  Navigator.of(context).pop();
                  Actions(setName);
                }
                else {
                  Navigator.of(context).pop();
                  setState(() {
                    action = "";
                  });
                  deleteSet(setName);
                }
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> addNameList(){
    List<Widget> list = new List<Widget>();
    for (int i = 0;i < setNames.length; ++i){
      list.add(new GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,2,5,2),
          child: Ink(
            color: ThemeColor[100],
            child: ListTile(
                leading: Icon(Icons.content_copy),
                title: Text(
                    setNames[i],
                    style: TextStyle(color: TextColor)
                ),
                trailing: OutlineButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),
                  color: ThemeColor[300],
                  borderSide: BorderSide(color: Colors.blue),
                  child: Text(
                    "Progress",
                    style: TextStyle(
                        color: Colors.red
                    ),
                  ),
                  onPressed: () {Progress(setNames[i]);},
                )
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/practice',arguments: usernameSetname(username,setNames[i]));
        },
      ));
    }
    return list;
  }

  Future<void> OpenCupertino(){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Create a new set'),
          content: Column(
            children: <Widget>[
              Text('please specify the name of this set'),
              Card(
                color: Colors.transparent,
                elevation: 0.0,
                child:TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      hintText: 'name of the set'
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Create'),
              onPressed: () {
                Navigator.of(context).pop();
                addSet();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List> addSet() async {
    final response = await http.post(
        "http://10.0.2.2/flash_card/addSet.php",
        body: {
          "setName": nameController.text,
          "username": username
        }
    );
    print(response.statusCode);
    nameController.clear();
    loadFlashCardName();
  }

  Future<List> loadFlashCardName() async {
    final response = await http.post(
        "http://10.0.2.2/flash_card/loadSetNames.php",
        body: {
          "username":username
        }
    );
    print(response.statusCode);
    if (response.statusCode == 200){
      List<String> newresponse = [];
      if (response.body.length > 2) {
        newresponse = response.body.substring(
            1, response.body.length - 1).split(",");
      }
      setState(() {
        setNames.clear();
        setNames = newresponse;
        for (int i = 0; i < setNames.length; ++i){
          setNames[i] = setNames[i].substring(1,setNames[i].length-1);
        }
      });
      Future.delayed(const Duration(milliseconds: 500), () {

        setState(() {
          loading = false;
          print(loading);
        });
      });
      print(setNames);

    }
    else{
      print("error");
    }

  }

  void loadColor(){
    readColor().then((color) {
      setState(() {
        ThemeColor = color['ThemeColor'];
        TextColor = color['TextColor'];
      });
    });
  }

  bool value = true;
  @override
  Widget build(BuildContext context) {
    setState(() {
      username = ModalRoute
          .of(context)
          .settings
          .arguments;
    });

    if (value){
      setState(() {
        loading = true;
      });
      loadFlashCardName();
      loadColor();
      setState(() {
        value = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColor,
        title: Text(
          'Practices',
          style: TextStyle(
            color: TextColor
          )
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint){
          return Builder(
            builder: (context) {
              if (loading){
                return Center(
                    child: SpinKitRotatingCircle(
                      color: ThemeColor,
                      size: 50.0,
                    )
                );
              }
              else{
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraint.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment:  (setNames.length == 0) ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: <Widget>[

                        if(setNames.length == 0)
                          Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                    height: constraint.maxHeight,
                                    child: Text(
                                        ' No FlashCard Sets yet, you can add new flash card set by tapping the right bottom button'
                                    )
                                ),
                              )
                          ),
                        if(setNames.length != 0)
                          Container(
                            height: constraint.maxHeight,
                            child: ListView(
                                children: ListTile.divideTiles(
                                    context: context,
                                    tiles: addNameList()
                                ).toList()
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }
            }
          );
        },
      ),
    );
  }
}
