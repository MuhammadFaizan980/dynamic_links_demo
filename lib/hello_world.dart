import 'package:flutter/material.dart';

class HelloWorld extends StatelessWidget {
  String _linkData;

  HelloWorld(this._linkData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$_linkData'),
      ),
    );
  }
}
