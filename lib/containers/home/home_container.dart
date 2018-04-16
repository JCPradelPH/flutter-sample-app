import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../app_state.dart';
import 'movies/movies_stream.dart';

class HomePage extends StatefulWidget{
  
  @override
  _State createState() => new _State();
}

class _State extends State<HomePage>{

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState,Widget>(
      converter: (store) => store.state.view,
      builder: (context,view){
        return new Container(
          child: view==null?new MovieStream():view
        );
      },
    );
  }
}
