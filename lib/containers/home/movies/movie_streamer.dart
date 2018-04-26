import 'dart:async';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../components/card_listitem.dart';
import '../../../components/shared_components.dart';

class MovieStreamer {
  StreamController<MovieItem> controller;
  
  // stream controller setup
  initStream(onListen){
    controller = StreamController.broadcast();
    controller.stream.listen( onListen );
    _loadDataSream();
  }

  // load data from http request
  _loadDataSream() async{
    var client = http.Client();
    var req = new http.Request('get', Uri.parse('http://jsonplaceholder.typicode.com/photos'));
    var streamedResp = await client.send(req);
    //process stream response
    streamedResp.stream
      .transform(new Utf8Decoder())
      .transform(json.decoder)
      .expand( (e) => e )
      .map( (map) => MovieItem.fromJsonMap(map) )
      .pipe(controller);
  } 

  // map list item to CardListItem
  dataMap(BuildContext context, int index, List<MovieItem> _itemList) {
    if(index >= _itemList.length) return null;
    return new CardListItem(
      new CircleAvatar(child: Image.network(_itemList[index].thumbnail)),
      _itemList[index].title,
      onTap: () => generateSnackbar(context, new Text(_itemList[index].title), 2),
    );
  }
}

// MovieItem json map
class MovieItem{
  final String thumbnail;
  final String title;
  MovieItem.fromJsonMap(Map map) : 
    thumbnail = map['thumbnailUrl'],
    title = map['title'];
}