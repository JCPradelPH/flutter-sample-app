import 'package:flutter/material.dart';

import 'movie_streamer.dart';

class MovieStream extends StatefulWidget{

  @override
  _State createState() => new _State();
}

class _State extends State<MovieStream>{
  List<MovieItem> _itemList = [];
  MovieStreamer streamer;

  @override
  void initState() {
    super.initState();
    streamer = new MovieStreamer();
    streamer.initStream( (data) => setState( () => _itemList.add(data) ) );
  }

  @override
  void dispose(){
    super.dispose();
    streamer.controller?.close();
    streamer.controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
        shrinkWrap: true,
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index){
          return streamer.dataMap(context, index, _itemList);
        }
      ),
    );
  }
}
