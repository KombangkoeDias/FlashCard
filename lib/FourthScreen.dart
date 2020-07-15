import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flashcard/helper_functions/settings.dart';

class FourthScreen extends StatefulWidget {
  @override
  _FourthScreenState createState() => _FourthScreenState();
}



class _FourthScreenState extends State<FourthScreen> {
  List<String> Settings = ["Color"];
  List<String> Setted = [''];
  bool loading = false;
  bool value = true;
  MaterialColor ThemeColor = Colors.lightBlue;
  Color TextColor = Colors.black;

  Future<void> OpenCupertino(){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Change a color theme'),
          content: Column(
            children: <Widget>[
              Text('(this will be native to this device'),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                        "Blue (default)"
                    ),
                    onPressed: () {writeColor('blue'); Navigator.of(context).pop();loadColor();
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      "Green"
                    ),
                    onPressed: () {writeColor('green'); Navigator.of(context).pop(); loadColor();},
                  ),
                  RaisedButton(
                    child: Text(
                        "Red"
                    ),
                    onPressed: () {writeColor('red'); Navigator.of(context).pop();loadColor(); },
                  ),
                  RaisedButton(
                    child: Text(
                        "Yellow"
                    ),
                    onPressed: () {writeColor('yellow'); Navigator.of(context).pop();loadColor();},
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> loadPreference() async {
    setState(() {
      loading = true;
    });


    await Future.delayed(const Duration(milliseconds: 500),() {
      setState(() {
        loading = false;
      });
    });
  }

  void loadColor(){
    readColor().then((color) {
      setState(() {
        ThemeColor = color['ThemeColor'];
        TextColor = color['TextColor'];
      });
      setState(() {
        Setted[0] = currentColor();
      });
    });
  }

  String currentColor(){
    if (ThemeColor == Colors.lightBlue){
      return 'blue';
    }
    else if (ThemeColor == Colors.lightGreen){
      return 'green';
    }
    else if (ThemeColor == Colors.yellow){
      return 'yellow';
    }
    else if (ThemeColor == Colors.red){
      return 'red';
    }
    else{
      return 'blue';
    }
  }

  List<Widget> drawSettingList(){
    List<Widget> list = new List<Widget>();
    for (int i = 0;i < Settings.length; ++i){
      list.add(new GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,2,5,2),
          child: Ink(
            color: ThemeColor[100],
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                  Settings[i] + " : " + Setted[i],
                  style: TextStyle(color: TextColor)
              ),
            ),
          ),
        ),
        onTap: () {
          OpenCupertino();
        },
      ));
    }
    return list;
  }
  @override
  Widget build(BuildContext context) {
    if (value){
      loadColor();
      loadPreference();
      setState(() {
        value = false;
      });
      setState(() {
        Setted[0] = currentColor();
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColor,
          title: Text(
            'Setting',
            style: TextStyle(
              color: TextColor
            ),
          ),
        ),
        body:  LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraint){
            return Builder(
                builder: (context){
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: constraint.maxHeight,
                              child: ListView(
                                  children: ListTile.divideTiles(
                                      context: context,
                                      tiles: drawSettingList()
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
