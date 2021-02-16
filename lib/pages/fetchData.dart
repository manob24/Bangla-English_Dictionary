import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newdictionary/pages/loading.dart';
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
  final random = new Random();
  int m = 17000;
  int p = 2038074743;
  int a, as;
  int b, bs;

  List<List<Word>> hashedList = new List.generate(17000, (index) => []);
  void getData() async{
    String dictionaryText = await rootBundle.loadString('assets/BanglaDictionary.json');
    data = json.decode(dictionaryText);
    words = List<Word>();
    for(var word in data){
      words.add(Word.fromJson(word));
    }
    primaryHash();
    setState(() {
      isLoading = false;
    });
  }

  int pow(int base, int power){
    int result = 1;
    for(int i = 0; i<power; ++i){
      result = (result * base)%p;
    }
    return result;
  }

  int getKey(String name){
    int key = 0;
    int len = name.length;
    for(int i = len-1; i>=0; --i){
      key = (key + ((name.codeUnitAt(i)-97)*pow(26, i))%p)%p;
    }
    return key;
  }

  void primaryHash(){
    a = 1+random.nextInt(p-1);
    b = random.nextInt(p);
    for(Word word in words){
      int k = getKey(word.en);
      int key = ((a*k+b)%p)%m;
      hashedList[key].add(word);
    }
    words.clear();
    secondaryHash();
  }

  void secondaryHash(){
    as = 1+random.nextInt(p-1);
    bs = random.nextInt(p);
    for(int i = 0; i<m; ++i){
      List<Word> copied = List.from(hashedList[i]);
      hashedList[i].clear();
      int n = copied.length;
      int mj = n*n;
      hashedList[i].length = mj;

      for(Word word in copied){
        int k = getKey(word.en);
        int key = ((as*k+bs)%p)%mj;
        hashedList[i][key] = word;
      }
    }
  }

  @override
  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading?Home():Loading();
  }
}