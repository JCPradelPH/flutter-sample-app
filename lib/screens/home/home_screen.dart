import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        new Text('Hello'),
        new Text('World')
      ]
    );
  }
  
}