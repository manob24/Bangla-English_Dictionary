import 'package:flutter/material.dart';
import 'package:newdictionary/khojData.dart';
import 'package:newdictionary/word.dart';
import 'package:newdictionary/pages/showWord.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isWordFound = true;
  TextEditingController textEditingController = new TextEditingController();
  String word;
  KhojData khojData;
  @override
  void initState(){
    super.initState();
    khojData = new KhojData();
    khojData.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new FractionallySizedBox(
            alignment: Alignment.topLeft,
            heightFactor: 0.25,
            widthFactor: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
          new Align(
              alignment: const Alignment(-1, -0.56),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: TextField(
                    onChanged: (value){
                      setState(() {
                        isWordFound = true;
                      });
                    },
                    controller: textEditingController,
                    style:TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration:InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                        suffixIcon: Material(
                          color: Colors.lightBlueAccent,
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.black,
                            tooltip: 'search word',
                            onPressed: (){
                              word = textEditingController.text;
                              if(word.isNotEmpty) {
                                Word newWord = khojData.search(word);
                                if (newWord != null) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ShowWord(word: newWord)));
                                  textEditingController.clear();
                                }
                                else {
                                  setState(() {
                                    isWordFound = false;
                                  });
                                }
                              }
                              else{
                                print("empty field");
                              }
                            },
                          ),
                        ),
                        errorText: !isWordFound? 'Sorry! No such word found': null,
                        border:InputBorder.none,
                        hintText: "Search a Word"
                    )
                ),
              )
          )
        ],
      )
    );
  }
}