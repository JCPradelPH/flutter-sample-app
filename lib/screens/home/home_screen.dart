import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../components/shared_components.dart';
import '../../utils/ab_menu_adapter.dart';
import '../../components/listview.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new HomePage()
    );
  }
}

class HomePage extends StatefulWidget{
  
  @override
  _State createState() => new _State();
}

class _State extends State<HomePage>{
  
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
      new Listview(_movieList):
      loader(),
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
            tapEvent: () => generateSnackbar(context, new Text(mov['title']))
          )
        );
    } ); 
  }
}