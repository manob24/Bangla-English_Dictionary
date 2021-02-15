import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching? Text("English-Bangla Dictionary"):
        TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: "Enter word",
          ),
        ),
        actions: [
          !isSearching?
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                isSearching = true;
              });
            },
          ):
          IconButton(
            icon: Icon(Icons.cancel_rounded),
            onPressed: (){
              setState(() {
                isSearching = false;
              });
            },
          )
        ],

      ),
      body: SafeArea(child: Text("home screen")),
    );
  }
}