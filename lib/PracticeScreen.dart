import 'package:flashcard/flash_card/Sets.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/helper_classes/usernameSetname.dart';
import 'package:flashcard/flash_card/flashcard.dart';
import 'package:http/http.dart' as http;

class PracticeScreen extends StatefulWidget {
  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool value = true;
  usernameSetname usernamesetname;
  FlashCardSets myset;
  flashCard currentCard;
  String show = "";
  String termOrDefinition = "";
  int sequence = 1;

  Future<List> addProgress(flashCard flashcard) async {
    final response = await http.post(
        "http://10.0.2.2/flash_card/addProgress.php",
        body: {
          "setName": usernamesetname.setName,
          "username": usernamesetname.username,
          "vocabulary": flashcard.word,
          "meaning": flashcard.definition
        }
    );
    print(response.body);
  }

  Future<List> loadCurrentCard() async{
    final response = await http.post(
        "http://10.0.2.2/flash_card/loadCurrentCard.php",
        body: {
          "setName": usernamesetname.setName,
          "username": usernamesetname.username
        }
    );
    print("current card: " + response.body);
    if (response.body.length == 2){
      setState(() {
        currentCard = myset.flashCardList[0];
        print(currentCard.word);
        show = currentCard.word;
        print(currentCard.definition);
        sequence = 1;
      });
    }
    else{


    }
  }

  Future<List> loadCards() async{
    final response = await http.post(
        "http://10.0.2.2/flash_card/loadCard.php",
        body: {
          "setName": usernamesetname.setName,
          "username": usernamesetname.username
        }

    );
    print("myset: " + usernamesetname.setName + " ,flashcards: " + response.body);
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
    setState(() {
      myset.flashCardList.clear();
    });
    for (int i = 0; i < myresponse.length; ++i){
      if (i % 2 == 0){
        var mycard = flashCard(myresponse[i],myresponse[i+1]);
        setState(() {
          myset.addFlashCard(mycard);
        });
      }
    }
    print("myset's size : " + myset.getsetSize().toString());
    for (int i = 0; i < myset.flashCardList.length; ++i){
      print("term: " +  myset.flashCardList[i].word + " ,meaning: " + myset.flashCardList[i].definition);
    }
    loadCurrentCard();
  }

  void flip(){
    if (show == currentCard.word){
      setState(() {
        show = currentCard.definition;
        termOrDefinition = "term";
      });
    }
    else{
      setState(() {
        show = currentCard.word;
        termOrDefinition = "definition";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (value){
      setState(() {
        usernamesetname = ModalRoute
            .of(context)
            .settings
            .arguments;
        myset = FlashCardSets(usernamesetname.username,[]);
        loadCards();
        var a = "[word,definition]";
        var newresponse = a.substring(1,a.length-1).split(',');
        print(newresponse[0] + " " + newresponse[1]);
        value = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Practice set : " + usernamesetname.setName + " : " +
            termOrDefinition + " " + sequence.toString())
      ),
      body: Center(
        child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        child: Center(
                          child: Text(
                              show,
                              style: TextStyle(
                                  fontSize: 30
                              )
                          ),
                        ),
                        height: 300,

                      ),
                    ],
                  ),
                  onTap: () {
                      flip();
                  },
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('BACK'),
                      color: Colors.blue,
                      onPressed: () {print("Back");},
                    ),
                    RaisedButton(
                      child: const Text('FLIP'),
                      color: Colors.blue,
                      onPressed: () {flip();},
                    ),
                    RaisedButton(
                      child: const Text('NEXT'),
                      color: Colors.blue,
                      onPressed: () {print("Next");},
                    ),
                  ],
                ),
              ],
            ),
          ),
      )
    );
  }
}
