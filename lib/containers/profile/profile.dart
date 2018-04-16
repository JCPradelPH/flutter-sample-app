import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/user_actions.dart';
import '../../app_state.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Profile"),
      ),
      body: new Center(
        child: new StoreConnector<AppState,User>(
          converter: (store) => store.state.user,
          builder: (context,user){
            return new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Container(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(user.photoUrl),
                    radius:50.0
                  ),
                  margin: const EdgeInsets.only(bottom:10.0)
                ),
                new Text(user.displayName, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                new Text(user.email)
              ],
            );
          }
        ),
      ),
    );
  }
}