import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../components/card_listitem.dart';
import '../../../components/shared_components.dart';
import '../../../utils/global_adapter.dart';

class MoviesList extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<MoviesList>{

  List<MenuAdapter> _movieList = new List<MenuAdapter>();

  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: _movieList.length>0?
      _listviewBuild(_movieList):
      loader(),
    );
  }

  _listviewBuild(_movieList) => new ListView.builder(
    shrinkWrap: true,
    itemCount: _movieList.length,
    padding: new EdgeInsets.symmetric(vertical: 8.0),
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int index){
      return _mapDataToItem(context, index, _movieList);
    }
  );

  _mapDataToItem(BuildContext context, int index, _itemList) {
    return new CardListItem(
      _itemList[index].listImage,
      _itemList[index].listTitle,
      subs: [
        _itemList[index].subTitle1,
        _itemList[index].subTitle2,
        _itemList[index].subTitle3,
      ],
      onTap: () => generateSnackbar(context, new Text(_itemList[index].listTitle), 2),
    );
  }

  Future<String> _fetchMovies() async {
    return await rootBundle.loadString('json_data/movies.json');
  }

  Future<Image> _fetchImage(url) async {
    return Image.network(url);
  }

  _getMovies() {
    _fetchMovies()
      .then( (data) {
        Map<String,dynamic> movieMap = json.decode(data);
        List<dynamic> movies = movieMap['movies'];
        movies.forEach(_mapMovies);
      } )
      .catchError( (err) => print('error: $err') );
  }
  _mapMovies(mov) async {
    Image img = await _fetchImage(mov['posters']['thumbnail']);
    setState( () {
      _movieList.add(
          new MenuAdapter(
            listImage:img,
            listTitle: mov['title'],
            subTitle1: mov['year'].toString(),
            subTitle2: 'Rated '+mov['mpaa_rating'],
            subTitle3: 'Score: '+mov['ratings']['audience_score'].toString(),
          )
        );
    } ); 
  }

}