import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flashcard/flash_card/Sets.dart';
import 'package:flashcard/flash_card/flashcard.dart';
import 'package:flashcard/helper_functions/settings.dart';


class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  String username;
  List<String> setNames = List<String>();
  bool loading = false;
  bool value = true;
  List<int> currentIndices = List<int>();
  FlashCardSets myset = FlashCardSets("",[]);
  List<bool> finishedSets = List<bool>();
  MaterialColor ThemeColor =Colors.blueGrey;
  Color TextColor = Colors.black;

  void initFinishedSets() {
    for (int i = 0 ;i < setNames.length; ++i){
      setState(() {
        finishedSets.add(false);
      });
    }

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

      initFinishedSets();
      print("finishedSets after init: " + finishedSets.toString());

    }
    else{
      print("error");
    }

  }

  List<Widget> addFinishedSets(){
    List<Widget> list = new List<Widget>();
    for (int i = 0;i < setNames.length; ++i){
      if (finishedSets[i]){
        list.add(Padding(
          padding: const EdgeInsets.fromLTRB(5,2,5,2),
          child: Ink(
            color: ThemeColor[100],
            child: ListTile(
                leading: Icon(Icons.content_copy),
                title: Text(
                    setNames[i],
                    style: TextStyle(color: TextColor)
                ),

            ),
          ),
        ),
        );
      }
      }
    return list;
  }

  Future<bool> isSetEmpty(String setName) async {
    final response = await http.post(
        "http://10.0.2.2/flash_card/loadCard.php",
        body: {
          "setName": setName,
          "username": username
        }

    );
    if (response.body.length == 2){
      return true;
    }
    return false;
  }

  Future<List> loadCards(String setName) async{

    final response = await http.post(
        "http://10.0.2.2/flash_card/loadCard.php",
        body: {
          "setName": setName,
          "username": username
        }

    );
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
    for (int i = 0; i < myset.flashCardList.length; ++i){
      print("term: " +  myset.flashCardList[i].word + " ,meaning: " + myset.flashCardList[i].definition);
    }

  }

  Future<void> deduceFinishedSet(String setName, int i) async{

    final response = await http.post(
        "http://10.0.2.2/flash_card/loadCurrentCard.php",
        body: {
          "setName": setName,
          "username":username
        }
    );
    print("current card: " + response.body);
    bool isEmpty = await isSetEmpty(setName);
    if (isEmpty){
      currentIndices.add(-1);
      return;
    }
    if (response.body.length == 2 && !isEmpty){
      setState(() {
        currentIndices.add(0);
      });
      return;
    }
    else{
      await loadCards(setName);
      var newresponse = response.body.substring(1,response.body.length-1);
      var listOfTermAndDefinition = newresponse.split(',');
      listOfTermAndDefinition[0] = listOfTermAndDefinition[0].substring(1,listOfTermAndDefinition[0].length-1);
      listOfTermAndDefinition[1] = listOfTermAndDefinition[1].substring(1,listOfTermAndDefinition[1].length-1);
      for (var j = 0; j < myset.getsetSize(); ++j){
        if (myset.flashCardList[j].word == listOfTermAndDefinition[0] && myset.flashCardList[j].definition == listOfTermAndDefinition[1]){
          setState(() {
            currentIndices.add(j);
            if (currentIndices[i] == myset.getsetSize()-1 && !isEmpty){
              finishedSets[i] = true;
              print("finished set: " + setName);
              return;
            }
          });
        }
      }
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

  @override
  Widget build(BuildContext context) {
    setState(() {
      username = ModalRoute
          .of(context)
          .settings
          .arguments;
    });
    if (value){
      loading = true;
      loadColor();
      loadFlashCardName().then(
          (val) async {
            for (int i = 0 ; i < setNames.length; ++i){
              await deduceFinishedSet(setNames[i], i);
            }
            print(finishedSets);
            setState(() {
              loading = false;
            });
          }
      );

      setState(() {
        value = false;

      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColor,
          title: Text(
            'Achievement : Finished Sets',
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraint){
            return Builder(
                builder: (context){
                  if (loading ){
                    return Center(
                        child: SpinKitRotatingCircle(
                          color: ThemeColor,
                          size: 50.0,
                        )
                    );
                  }
                  List<Widget> finishedSets = addFinishedSets();
                  if (finishedSets.length == 0){
                    print("blank");
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: (
                        Center(
                          child: Text("You don't have any finished sets yet \n go practice more!",
                          style: TextStyle(
                            color: TextColor,
                            fontSize: 20,

                          ),)
                        )
                      ),
                    );
                  }
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
                                      tiles: addFinishedSets()
                                  ).toList()
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                }
            );
          },
        ),
    );
  }
}
