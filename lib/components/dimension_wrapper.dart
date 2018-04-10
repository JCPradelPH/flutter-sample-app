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