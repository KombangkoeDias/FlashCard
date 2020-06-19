import 'package:flutter/material.dart';
import 'package:flashcard/flash_card/Sets.dart';
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  FlashCardSets set = FlashCardSets("new",[]);
  List<FlashCardSets> Sets = [];
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
                child: Text(
                    ' No FlashCard Sets yet, you can add new flash card by tapping the right bottom button'
                )
            ),
          if(Sets.length != 0)
            Center(
                child: Text(
                    ''
                )
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Sets.length == 0)
            this.setState(() {Sets.add(set);});
          else
            this.setState(() {Sets.clear();});
          },
          backgroundColor: Colors.lightBlue ,
        child: Icon(Icons.add_circle_outline)
      ),
    );
  }
}
