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

  Future<List> editSetName(newSetName) async{
    final response = await http.post(
        "http://10.0.2.2/flash_card/editSetName.php",

        body: {
          "setName": usernamesetname.setName,
          "username": usernamesetname.username,
          "newSetName": newSetName
        }
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200){
      setState(() {
        usernamesetname.setName = newSetName;
      });
    }
  }



  Future<List> editCard(vocabulary,meaning,newvocabulary,newmeaning) async{

    final response = await http.post(
        "http://10.0.2.2/flash_card/editCard.php",

        body: {
          "setName": usernamesetname.setName,
          "username": usernamesetname.username,
          "vocabulary": vocabulary,
          "meaning": meaning,
          "newvocabulary": newvocabulary,
          "newmeaning": newmeaning
        }
    );
    print(response.statusCode);
    loadCards();
    //print("edit " + vocabulary + " " + meaning + " with " + newvocabulary + " " + newmeaning);
  }

  Future<List> deleteCard(setName,username,vocabulary,meaning) async{
    final response = await http.post(
        "http://10.0.2.2/flash_card/deleteCard.php",
        body: {
          "setName": setName,
          "username": username,
          "vocabulary": vocabulary,
          "meaning": meaning
        }
    );
    print(response.statusCode);
    print(response.body);
    loadCards();
  }

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

  List<Widget> drawCard(){
    List<Widget> list = new List<Widget>();
    for (int i = 0;i < myset.getsetSize(); ++i){
      list.add(new GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,2,5,2),
          child: Ink(
            color: Colors.lightBlue[100],
            child: ListTile(
                leading: Icon(Icons.content_copy),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                        myset.flashCardList[i].word,
                        style: TextStyle(color: Colors.indigo)
                    ),
                    Text(
                        myset.flashCardList[i].definition,
                        style: TextStyle(color: Colors.indigo)
                    ),
                  ],
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
                  onPressed: () {deleteCard(usernamesetname.setName,usernamesetname.username,myset.flashCardList[i].word,myset.flashCardList[i].definition);},
                )
            ),
          ),
        ),
        onTap: () {OpenCupertino(vocabulary: myset.flashCardList[i].word,meaning: myset.flashCardList[i].definition, edit: true);},
      ));
    }
    return list;
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
    print(myset.getsetSize());
    for (int i = 0; i < myset.flashCardList.length; ++i){
      print("term: " +  myset.flashCardList[i].word + " ,meaning: " + myset.flashCardList[i].definition);
    }
  }

  Future<void> OpenCupertino({vocabulary:"",meaning:"", edit:false, editSetName: false}){
    vocabularyController.text = vocabulary;
    meaningController.text = meaning;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: !edit && !editSetName ?  Text('Create a new card for this set : ' + usernamesetname.setName): edit ? Text('Edit this card') : Text('Edit this set\'s name'),
          content: Column(
            children: <Widget>[
              !edit && !editSetName ? Text('please specify the term and meaning of this new card'): edit ? Text("specify the change you want to make to this card") : Text("Specify the new name for this set"),

              if (!editSetName) Card(
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
                      hintText: editSetName? "set name" : 'meaning'
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                vocabularyController.clear();
                meaningController.clear();
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: edit || editSetName? Text('Edit'): Text('Create') ,
              onPressed: () {
                if (edit){
                  editCard(vocabulary,meaning,vocabularyController.text,meaningController.text);
                }
                else if (editSetName){
                  this.editSetName(meaningController.text);
                }
                else{
                  addCards();
                }
                Navigator.of(context).pop();
                vocabularyController.clear();
                meaningController.clear();
              },
            ),
          ],
        );
      },
    );
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
        value = false;
      });
    }

      return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            child: Text(
              usernamesetname.setName,
            ),
            onTap: () {OpenCupertino(editSetName: true);},
          ),
        ),
        body:LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraint){
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraint.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment:  (myset.getsetSize() == 0) ? MainAxisAlignment.center : MainAxisAlignment.start,
                  children: <Widget>[

                    if(myset.getsetSize() == 0)
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                                height: constraint.maxHeight,
                                child: Text(
                                    ' No flash cards yet, you can add new flash card by tapping the right bottom button'
                                )
                            ),
                          )
                      ),
                    if(myset.getsetSize() != 0)
                      Container(
                        height: constraint.maxHeight,
                        child: ListView(
                            children: ListTile.divideTiles(
                                context: context,
                                tiles: drawCard(),
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
