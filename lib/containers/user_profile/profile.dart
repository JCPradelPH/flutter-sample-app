import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  final FirebaseUser authUser;

  Profile(this.authUser);
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("My Profile"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(
              child: new CircleAvatar(
                backgroundImage: new NetworkImage(authUser.photoUrl),
                radius:50.0
              ),
              margin: const EdgeInsets.only(bottom:10.0)
            ),
            new Text(authUser.displayName, style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            new Text(authUser.email)
          ],
        ),
      ),
    );
  }
}