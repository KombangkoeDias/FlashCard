import 'package:flutter/material.dart';
import 'package:flashcard/flash_card/Sets.dart';
import 'package:http/http.dart' as http;
import 'package:flashcard/helper_classes/usernameSetname.dart';
import 'package:flutter/cupertino.dart';
import 'package:flashcard/flash_card/flashcard.dart';


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
    print("set: " + usernamesetname.setName + " ,flashcards: " + response.body);
    var myresponse = [];
    if (response.body.length != 2){
      myresponse = response.body.substring(1,response.body.length-1).split(",");
    }

    for (int i = 0; i < myresponse.length;++i){
      if (i%2 == 0){
        myresponse[i] = myresponse[i].substring(2,myresponse[i].length-1);
      }
      else{
        myresponse[i] = myresponse[i].substring(1,myresponse[i].length-2);
      }
    }
    for (int i = 0; i < myresponse.length; ++i){
      if (i % 2 == 0){
        var mycard = flashCard(myresponse[i],myresponse[i+1]);
        setState(() {
          myset.addFlashCard(mycard);
        });
      }
    }
    for (int i = 0; i < myset.flashCardList.length; ++i){
      print("term: " +  myset.flashCardList[i].word + " ,meaning: " + myset.flashCardList[i].definition);
    }
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
      value = false;
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
