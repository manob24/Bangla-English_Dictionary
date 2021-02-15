import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newdictionary/word.dart';

import 'package:newdictionary/pages/home.dart';


class FetchData extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  bool isLoading = true;
  List data;
  List<Word> words;
  void getData() async{
    String dictionaryText = await rootBundle.loadString('assets/BanglaDictionary.json');
    data = json.decode(dictionaryText);
    words = List<Word>();
    for(var word in data){
      words.add(Word.fromJson(word));
    }
    setState(() {
      isLoading = false;
    });
    print(words[0].sents[0]);
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
