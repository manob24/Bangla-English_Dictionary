import 'package:flutter/material.dart';
import 'package:newdictionary/pages/home.dart';
import 'package:newdictionary/pages/showIcon.dart';
import 'package:newdictionary/pages/showWord.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.green[600],
      accentColor: Colors.greenAccent[400],
    ),
    routes:{
      '/': (BuildContext context)=>Home(),
      '/showWord': (BuildContext context)=>ShowWord(),
      '/showIcon': (BuildContext context)=>ShowIcon()
    },
    initialRoute: '/showIcon',
  ));
}

