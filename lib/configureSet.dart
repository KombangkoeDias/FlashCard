import 'package:flutter/material.dart';
import 'package:flashcard/flash_card/Sets.dart';
import 'package:http/http.dart' as http;
import 'package:flashcard/helper_classes/usernameSetname.dart';

class ConfigureSetScreen extends StatefulWidget {
  @override
  _ConfigureSetScreenState createState() => _ConfigureSetScreenState();
}


class _ConfigureSetScreenState extends State<ConfigureSetScreen> {
  usernameSetname usernamesetname = usernameSetname("","");
  FlashCardSets myset = FlashCardSets("",[]);

  Future<List> addCards(){

  }

  Future<List> loadCards(){

  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      usernamesetname = ModalRoute
          .of(context)
          .settings
          .arguments;

      myset = FlashCardSets(usernamesetname.username,[]);
      loadCards();
    });



    return Scaffold(
      appBar: AppBar(
        title: Text(
          usernamesetname.setName,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            this.setState(() {addCards();}); //use setState so that the view is reset
          },
          backgroundColor: Colors.lightBlue ,
          child: Icon(Icons.add)
      ),
    );
  }
}
