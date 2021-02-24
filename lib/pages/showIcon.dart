import 'package:flutter/material.dart';
import 'package:newdictionary/pages/home.dart';

class ShowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 750), () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              Home()));
    });
    return Scaffold(
      body: Center(
        child: Image(
            image: AssetImage('assets/icon/icon.png')
        ),
      ),
    );
  }
}
