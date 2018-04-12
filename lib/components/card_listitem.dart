import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget{

  final Color backColor;
  final VoidCallback onTap;
  final dynamic _itemImage;
  final String _title;
  final List<String> subs;
  final TextStyle _smallText = new TextStyle(fontSize: 10.0,fontWeight: FontWeight.w400);
  final TextStyle _boldText = new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold);
  CardListItem(
    this._itemImage,
    this._title,
    {
      Key key,
      this.backColor,
      this.onTap,
      this.subs
    }
  ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return _materialWrapper(
      new Card(
        child: new Container(
          padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: new ListTile(
            onTap: onTap,
            leading: _itemImage,
            title: _itemInfoColumn()
          )
        ) 
      )
    );
  }

  

  _itemInfoColumn() => new Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _titleInfoSection()
  );
  
  List<Widget> _titleInfoSection(){ 
    List<Widget> children = subs.map<Widget>( (sub) => new Text(sub, style: _smallText) ).toList(growable: true);
    children.insert( 0,new Text(_title,style: _boldText) );
    return children;
  }

  _materialWrapper(c) => new Material(
    color: Colors.transparent,
    child: c
  );

}