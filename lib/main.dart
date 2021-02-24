
import 'package:flutter/material.dart';
import 'package:newdictionary/route_generator.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.green[600],
      accentColor: Colors.greenAccent[400],
    ),
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,

  ));
}

