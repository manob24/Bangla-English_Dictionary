import 'package:flutter/material.dart';
import 'package:newdictionary/fetchData.dart';
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
  FetchData fetchData;
  @override
  void initState(){
    super.initState();
    fetchData = new FetchData();
    fetchData.getData();
  }
  void submit(){
    word = textEditingController.text;
    if(word.isNotEmpty) {
      Word newWord = fetchData.search(word);
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
              color: Colors.green,
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
                    onSubmitted: (data){
                      submit();
                    },
                    controller: textEditingController,
                    style:TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration:InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                        suffixIcon: Material(
                          color: Colors.lightGreen,
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.black,
                            tooltip: 'search word',
                            onPressed: (){
                              submit();
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