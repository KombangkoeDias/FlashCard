import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/flash_card/Sets.dart';
import 'package:http/http.dart' as http;

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  final nameController = TextEditingController();
  List<FlashCardSets> Sets = [];

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
          "new": true
        }
    );
    if (response.statusCode != 404) {

    }
  }

  Future<List> loadFlashCardName() async {
    final response = await http.post(
        "http://10.0.2.2/flash_card/addSet.php",
        body: {
          "setName": nameController.text,
          "new": true
        }
    );
    if (response.statusCode == 200){
      setState(() {

      });
    }
    else{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Add New Flash Cards',
            ),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if(Sets.length == 0)
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                      ' No FlashCard Sets yet, you can add new flash card by tapping the right bottom button'
                  ),
                )
            ),
          if(Sets.length != 0)
            Center(
                child: Text(
                    'have sets'
                )
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Sets.length == 0)
            this.setState(() {OpenCupertino();});
          else
            this.setState(() {Sets.clear();});
          },
          backgroundColor: Colors.lightBlue ,
        child: Icon(Icons.add_circle_outline)
      ),
    );
  }
}
