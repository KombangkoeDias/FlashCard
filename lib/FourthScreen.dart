import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FourthScreen extends StatefulWidget {
  @override
  _FourthScreenState createState() => _FourthScreenState();
}



class _FourthScreenState extends State<FourthScreen> {
  List<String> Settings = ["Color"];
  bool loading = false;
  bool value = true;

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
                    onPressed: () {print("Blue");},
                  ),
                  RaisedButton(
                    child: Text(
                      "Green"
                    ),
                    onPressed: () {print("Green");},
                  ),
                  RaisedButton(
                    child: Text(
                        "Red"
                    ),
                    onPressed: () {print("Red");},
                  ),
                  RaisedButton(
                    child: Text(
                        "Yellow"
                    ),
                    onPressed: () {print("Yellow");},
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
    /*
    load preferences
     */
    await Future.delayed(const Duration(milliseconds: 500),() {
      setState(() {
        loading = false;
      });
    });
  }

  List<Widget> drawSettingList(){
    List<Widget> list = new List<Widget>();
    for (int i = 0;i < Settings.length; ++i){
      print(Settings[i]);
      list.add(new GestureDetector(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,2,5,2),
          child: Ink(
            color: Colors.lightBlue[100],
            child: ListTile(
              leading: Icon(Icons.content_copy),
              title: Text(
                  Settings[i],
                  style: TextStyle(color: Colors.indigo)
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
      loadPreference();
      setState(() {
        value = false;
      });
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Setting',
          ),
        ),
        body:  LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraint){
            return Builder(
                builder: (context){
                  if (loading){
                    return Center(
                        child: SpinKitRotatingCircle(
                          color: Colors.blue,
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
