
import 'package:flutter/material.dart';
import 'package:newdictionary/pages/fetchData.dart';
import 'package:newdictionary/route_generator.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.purple[600],
      accentColor: Colors.purpleAccent[400],

      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
    initialRoute: '/FetchData',
    onGenerateRoute: RouteGenerator.generateRoute,

  ));
}

