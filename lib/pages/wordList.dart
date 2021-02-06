import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:newdictionary/word.dart';
import 'package:flutter/material.dart';

class WordData extends StatefulWidget {
  @override
  _WordDataState createState() => _WordDataState();
}

class _WordDataState extends State<WordData> {
  List data;
  List<Word> words;
  void getData() async{
    String dictionaryText = await rootBundle.loadString('assets/BanglaDictionary.json');
    setState(() {
      data = json.decode(dictionaryText);
    });
    words = List<Word>();
    for(var word in data){
      words.add(Word.fromJson(word));
    }
    print(words[0].sents[0]);
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("word list"),
      ),
    );
  }
}
