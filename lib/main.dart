import 'package:flutter/material.dart';
import 'package:newdictionary/pages/showIcon.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.green[600],
      accentColor: Colors.greenAccent[400],
    ),
    home: ShowIcon(),
  ));
}

