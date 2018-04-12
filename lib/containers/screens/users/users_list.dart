import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../components/card_listitem.dart';
import '../../../components/shared_components.dart';


class UsersList extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<UsersList>{

  Firestore _firestore;

  @override
  void initState() {
    super.initState();
    _initFirebaseInstance();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: _firestore == null? loader() : new StreamBuilder(
          stream: Firestore.instance.collection('rooms').snapshots,
          builder: (context, snapshot){
            return snapshot.hasData ? 
              _listviewBuild(snapshot) : 
              loader();
          }
        )
    );
  }

  _initFirebaseInstance() async{
    final FirebaseApp app = await FirebaseApp.configure(
      name: 'sess-io',
      options: const FirebaseOptions(
        googleAppID: '1:145103145697:android:f40ed9d17510036d',
        apiKey: 'AIzaSyDlGL_KNedpxYgvZKM8vVR1zHv51ysScuU',
        projectID: 'sess-io',
      ),
    );
    setState((){
      _firestore = new Firestore(app: app);
    });
  }

  _listviewBuild(snapshot) => new ListView.builder(
    shrinkWrap: true,
    itemCount: snapshot.data.documents.length,
    padding: new EdgeInsets.symmetric(vertical: 8.0),
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int index){
      return _mapDataToItem(context, index, snapshot);
    }
  );

  _mapDataToItem(BuildContext context, int index, _itemList) {
    return new CardListItem(
      new CircleAvatar(
        backgroundImage: new NetworkImage(_itemList.data.documents[index]['user']['photoURL']),
        radius:20.0
      ),
      _itemList.data.documents[index]['name'],
      subs: [_itemList.data.documents[index]['user']['email']],
      onTap: () => generateSnackbar(context, new Text(_itemList.data.documents[index]['user']['email']), 2)
    );
  }

}