import 'package:flutter/material.dart';
import 'package:flashcard/flash_card/Sets.dart';
import 'package:http/http.dart' as http;
import 'package:flashcard/helper_classes/usernameSetname.dart';
import 'package:flutter/cupertino.dart';


class ConfigureSetScreen extends StatefulWidget {
  @override
  _ConfigureSetScreenState createState() => _ConfigureSetScreenState();
}


class _ConfigureSetScreenState extends State<ConfigureSetScreen> {
  usernameSetname usernamesetname = usernameSetname("","");
  FlashCardSets myset = FlashCardSets("",[]);
  final vocabularyController = TextEditingController();
  final meaningController = TextEditingController();
  bool value = true;
  Future<List> addCards() async{
    final response = await http.post(
        "http://10.0.2.2/flash_card/addCard.php",
        body: {
          "setName": usernamesetname.setName,
          "username": usernamesetname.username,
          "vocabulary": vocabularyController.text,
          "meaning": meaningController.text
        }
    );
    print(response.body);
    print(response.statusCode);
    loadCards();
  }

  Future<List> loadCards() async{
    final response = await http.post(
        "http://10.0.2.2/flash_card/loadCard.php",
        body: {
          "setName": usernamesetname.setName,
          "username": usernamesetname.username
        }

    );
    print(response.body);
    print(response.statusCode);
  }
  Future<void> OpenCupertino(){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Create a new card for this set'),
          content: Column(
            children: <Widget>[
              Text('please specify the term and meaning of this new card'),
              Card(
                color: Colors.transparent,
                elevation: 0.0,
                child:TextField(
                  controller: vocabularyController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      hintText: 'term'
                  ),
                ),
              ),
              Card(
                color: Colors.transparent,
                elevation: 0.0,
                child:TextField(
                  controller: meaningController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      hintText: 'meaning'
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
                addCards();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    setState(() {
      usernamesetname = ModalRoute
          .of(context)
          .settings
          .arguments;

      myset = FlashCardSets(usernamesetname.username,[]);

    });
    if (value){
      loadCards();
      setState(() {
        value = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          usernamesetname.setName,
        ),
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
