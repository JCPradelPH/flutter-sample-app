import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../components/card_listitem.dart';
import '../../../components/shared_components.dart';


class UsersList extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<UsersList>{

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new StreamBuilder(
          stream: Firestore.instance.collection('rooms').snapshots,
          builder: (context, snapshot){
            return snapshot.hasData ? 
              _listviewBuild(snapshot) : 
              loader();
          }
        )
    );
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