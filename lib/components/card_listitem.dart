import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget{

  final Color backColor;
  final VoidCallback onTap;
  final Image _itemImage;
  final Text _title;

  CardListItem(
    this._itemImage,
    this._title,
    {Key key,this.backColor,this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _materialWrapper(
      new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: new Card(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _itemImage,
              _title
            ],
          )
        )
      )
    );
  }

  _materialWrapper(c) => new Material(
    color: Colors.transparent,
    child: c
  );

}