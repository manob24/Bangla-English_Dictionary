import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:newdictionary/word.dart';

class FetchData{
  FetchData();
  bool isLoading = true;  // Data is Loading and Hashing
  List data;    //parsed json of words
  List<Word> words;   //decoded from json(data)
  final random = new Random();  //to get random numbers for a,b
  int m = 17000;    //number of slots
  int p = 2038074743; // a prime number which will be used to mod in universal hash
  int bigPrime = 2760727302517;
  int a, b;  // random numbers which used in primary universal hashing,
  List<List<int>> secondaryHashData = new List.generate(17000, (index) => []); //m,a,b for secondary hash

  List<List<Word>> hashedList = new List.generate(17000, (index) => []);  // list of words after hashing

  //fetch data from json file
  void getData() async{
    String dictionaryText = await rootBundle.loadString('assets/BanglaDictionary.json');
    data = json.decode(dictionaryText);
    words = List<Word>();
    for(var word in data){
      words.add(Word.fromJson(word));
    }
    primaryHash();
    isLoading = false;
  }

  //finding power of a number
  int pow(int base, int power){
    int result = 1;
    for(int i = 0; i<power; ++i){
      result = (result * base)%p;
    }
    return result;
  }

  //finding key of a string
  int getKey(String name){
    name = formatWord(name);
    int key = 1;
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

  //resolving collision in primary hash
  void secondaryHash(){
    for(int i = 0; i<m; ++i){
      int as = 1+random.nextInt(p-1);
      int bs = random.nextInt(p);

      List<Word> copied = List.from(hashedList[i]);
      hashedList[i].clear();
      int n = copied.length;
      int mj = n*n;
      hashedList[i].length = mj;

      secondaryHashData[i].length = 3;
      secondaryHashData[i][0] = mj;
      secondaryHashData[i][1] = as;
      secondaryHashData[i][2] = bs;

      for(Word word in copied){
        int k = getKey(word.en);
        int key = ((as*k+bs)%p)%mj;
        while(hashedList[i][key]!=null){  //linear probing
          key = (key+1)%mj;
        }
        hashedList[i][key] = word;
      }
    }
  }
  String formatWord(String word){
    word = word.replaceAll(new RegExp(r'[^\w\\s]+'),'');
    word = word.toLowerCase();
    return word;
  }
  //searching a word
  Word search(String word){
    word = formatWord(word);
    int k = getKey(word);
    int pkey = ((a*k+b)%p)%m;
    int mj = secondaryHashData[pkey][0];
    int as = secondaryHashData[pkey][1];
    int bs = secondaryHashData[pkey][2];
    int skey;
    String foundWord;
    Word found;
    if(mj == 1){
      found = hashedList[pkey][0];
      foundWord = formatWord(found.en);
    }
    else if(mj > 1){
      skey = ((as*k+bs)%p)%mj;
      while(hashedList[pkey][skey]!=null){
        found = hashedList[pkey][skey];
        foundWord = formatWord(found.en);
        if( foundWord!= word){
          skey = (skey+1)%mj;
        }
        else{
          break;
        }
      }
    }
    if(mj == 0 || found == null || foundWord != word){
      return null;
    }
    return found;
  }
}