import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/flash_card/Sets.dart';
import 'package:http/http.dart' as http;
import 'package:flashcard/helper_classes/usernameSetname.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  final nameController = TextEditingController();
  List<Widget> nameList = [];
  List<String> setNames = [];
  String username;

  Future<List> deleteSet(String setName){

  }

  List<Widget> addNameList(){
    List<Widget> list = new List<Widget>();
    for (int i = 0;i < setNames.length; ++i){
      list.add(new GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,2,5,2),
          child: Ink(
            color: Colors.lightBlue[100],
            child: ListTile(
              leading: Icon(Icons.content_copy),
              title: Text(
                  setNames[i],
                style: TextStyle(color: Colors.indigo)
              ),
              trailing: OutlineButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),
                color: Colors.lightBlue[300],
                borderSide: BorderSide(color: Colors.blue),
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red
                  ),
                ),
                onPressed: () {deleteSet(setNames[i]);},
              )
            ),
          ),
        ),
        onTap: () {Navigator.pushNamed(context, '/set',arguments: usernameSetname(username,setNames[i]));},
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
    print(username);
    final response = await http.post(
        "http://10.0.2.2/flash_card/addSet.php",
        body: {
          "setName": nameController.text,
          "username": username
        }
    );
    print(response.body);
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
      if (response.body.length != 0) {
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
      print(setNames);
    }
    else{
      print("error");
    }

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
      loadFlashCardName();
      setState(() {
        value = false;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Your Flash Card Sets',
            ),
        ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint){
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
                                  ' No FlashCard Sets yet, you can add new flash card by tapping the right bottom button'
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
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            this.setState(() {OpenCupertino();}); //use setState so that the view is reset
          },
          backgroundColor: Colors.lightBlue ,
                      child: Icon(Icons.add)
      ),
    );
  }
}
