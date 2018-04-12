import 'package:flutter/material.dart';

Widget loader() => new Center(
  child: new Center(
    child: new Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        new Container( child: new CircularProgressIndicator(),margin:const EdgeInsets.only(right:20.0)),
        new Text("Loading"),
      ],
    ),
  ),
);

Widget materialButton(Color color, String label, {VoidCallback onPressed}) => new Material(
  borderRadius: BorderRadius.circular(5.0),
  shadowColor: Colors.black54,
  elevation: 10.0,
  child: new MaterialButton(
    minWidth: 150.0,
    height: 50.0,
    color: color,
    child: new Text(label),
    onPressed: onPressed,
  )
);

generateSnackbar(context,content, int durationInSecs){
  print("generateSnackbar===================");
  Scaffold.of(context)
    .showSnackBar(
      new SnackBar(
        content: content,
        duration: new Duration(seconds: durationInSecs)
      )
    );
}
  