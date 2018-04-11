import 'package:flutter/material.dart';
import './shared_components.dart';

class CardListItem extends StatelessWidget{

  final Color backColor;
  final VoidCallback onTap;
  final Image _itemImage;
  final String _title;
  final String subtitle1, subtitle2, subtitle3;

  CardListItem(
    this._itemImage,
    this._title,
    {
      Key key,
      this.backColor,
      this.onTap,
      this.subtitle1,
      this.subtitle2,
      this.subtitle3,
    }
  ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _materialWrapper(
      new Card(
        child: new ListTile(
          onTap: onTap,
          title: mpWrapper(
            _tileRow(),
            padding:const EdgeInsets.only(top:10.0,bottom:10.0)
          )
        ) 
      )
    );
  }

  _tileRow() => new Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children: _listItemRow()
  );

  _itemInfoColumn() => new Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _titleInfoSection()
  );

  _titleInfoSection() => [
    mpWrapper(
      new Text(
          _title, 
          style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)
        ),
      margin:const EdgeInsets.only(bottom:5.0)
    ),
    new Text(subtitle1),
    new Text(subtitle2),
    new Text(subtitle3),
  ];
  
  _listItemRow() => [
    _itemImage,
    mpWrapper(
      _itemInfoColumn(),
      margin: const EdgeInsets.only(left:10.0)
    )
  ];

  _materialWrapper(c) => new Material(
    color: Colors.transparent,
    child: c
  );

}