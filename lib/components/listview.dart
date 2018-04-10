import 'package:flutter/material.dart';

import '../ab_menu_adapter.dart';
import 'card_listitem.dart';

class Listview extends StatelessWidget{
  final List<MenuAdapter> _itemList;

  Listview(this._itemList);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: _buildItem
    );
  }

  _buildItem(BuildContext context, int index) {
    print("------------------------------");
    print(_itemList[index].listTitle);
    return new CardListItem(
      _itemList[index].listImage,
      _itemList[index].listTitle
    );
  }
  
}