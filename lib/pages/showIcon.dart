import 'package:flutter/material.dart';

class ShowIcon extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 750), () {
        Navigator.pop(context);
    });
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Image(
            image: AssetImage('assets/icon/icon.png')
        ),
      ),
    );
  }
}
