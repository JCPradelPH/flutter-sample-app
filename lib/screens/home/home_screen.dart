import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../utils/ab_menu_adapter.dart';
import '../../components/listview.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        new HomePage()
      ]
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
    return new Listview(_movieList);
  }

  Future<String> _fetchMovies() async {
    return await rootBundle.loadString('json_data/movies.json');
  }

  _getMovies() {
    _fetchMovies()
      .then( (data){
        Map<String,dynamic> movieMap = json.decode(data);
        List<dynamic> movies = movieMap['movies'];
        setState( (){
          _movieList = movies.map( (mov) {
            Image img = new Image.network(mov['posters']['thumbnail']);
            return new MenuAdapter(listImage:img,listTitle: mov['title']);
          } );
        } ); 
      } )
      .catchError( (err) => print('error: $err') );
  }
}