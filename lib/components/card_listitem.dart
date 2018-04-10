import 'package:flutter/material.dart';
import './dimension_wrapper.dart';

class CardListItem extends StatelessWidget{

  final Color backColor;
  final VoidCallback onTap;
  final Image _itemImage;
  final Text _title;
  final Text subtitle1, subtitle2, subtitle3;

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
      new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: new Card(
          child: mpWrapper(
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _itemImage,
                mpWrapper(
                  new Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mpWrapper(_title,margin:const EdgeInsets.only(bottom:5.0)),
                      subtitle1,
                      subtitle2,
                      subtitle3,
                    ]
                  ),
                  margin: const EdgeInsets.only(left:10.0)
                )
              ],
            ),
            padding:const EdgeInsets.only(left:20.0,top:10.0,bottom:10.0)
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