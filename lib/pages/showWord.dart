import 'package:flutter/material.dart';
import 'package:newdictionary/word.dart';
import 'package:newdictionary/stringExtension.dart';
class ShowWord extends StatelessWidget {
  final Word word;
//  final TextStyle style;

  ShowWord({this.word});

  @override
  Widget build(BuildContext context) {
    String bn_syns = word.bn_syns.join(', ');
    String en_syns = word.en_syns.join(', ');
    String sents = word.sents.join('\n\n');

    final TextStyle style = TextStyle( fontSize: 16);
    final TextStyle headingTextStyle = TextStyle(fontSize: 18);
    final BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.lightGreen,
      boxShadow: [
        BoxShadow(
          color: Colors.green,
          blurRadius: 3.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 2.0), // shadow direction: bottom right
        )
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(word.en.capitalizeFirstofEach, style: TextStyle(fontSize: 20),),
        centerTitle: true,
        toolbarHeight: 60,
        bottom: PreferredSize(
          child: Text(word.bn, style: TextStyle(fontSize: 18),),
          preferredSize: null,
        ),
      ),
    body: Padding(
      padding: EdgeInsets.only(top: 10),
      child: ListView(
          children: [
            if(bn_syns.isNotEmpty)
            Container(
              decoration: decoration,
              height: 30,
              child: Center(child: Text("বাংলা অর্থ",style: headingTextStyle,))
            ),
            if(bn_syns.isNotEmpty)
            Container(
              padding: EdgeInsets.all(10),
              child: Center(child: Text(bn_syns, style: style,))
            ),
            if(en_syns.isNotEmpty)
            Container(
              decoration: decoration,
              height: 30,
              child: Center(child: Text("English Synonyms",style: headingTextStyle,))
            ),
            if(en_syns.isNotEmpty)
            Container(
              padding: EdgeInsets.all(10),
              child: Center(child: Text(en_syns.capitalizeAfterComma,style: style))
            ),
            if(sents.isNotEmpty)
            Container(
                decoration: decoration,
                height: 30,
                child: Center(child: Text("Example",style: headingTextStyle,))
            ),
            if(sents.isNotEmpty)
            Container(
                padding: EdgeInsets.all(10),
                child: Text(sents, style: style)
            ),
          ],
      ),
    ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//      ),
    );
  }
}
