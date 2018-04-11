import 'package:flutter/material.dart';

Widget mpWrapper(
  Widget c,{
    margin = const EdgeInsets.all(0.0),
    padding = const EdgeInsets.all(0.0),
    backColor = Colors.transparent,
    width
  }) => new Container(
    margin: margin,
    padding: padding,
    width: width,
    color: backColor,
    child: c
  );

  Widget loader() => new Center(
    child: new Center(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          mpWrapper(new CircularProgressIndicator(),margin:const EdgeInsets.only(right:20.0)),
          new Text("Loading"),
        ],
      ),
    ),
  );

  