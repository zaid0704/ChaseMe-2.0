import 'package:flutter/material.dart';
class Tester extends StatelessWidget {
  const Tester({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('123'),),
      ),
    );
  }
}