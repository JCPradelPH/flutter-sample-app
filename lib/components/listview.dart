import 'package:flutter/material.dart';

import '../utils/ab_menu_adapter.dart';
import 'card_listitem.dart';

class Listview extends StatelessWidget{
  final List<MenuAdapter> _itemList;

  Listview(this._itemList);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: _itemList.length,
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index){
        return _buildItem(context,index);
      }
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    print("_buildItem------------------------------");
    print(_itemList[index].listTitle);
    return new CardListItem(
      _itemList[index].listImage,
      _itemList[index].listTitle,
      subtitle1: _itemList[index].subTitle1,
      subtitle2: _itemList[index].subTitle2,
      subtitle3: _itemList[index].subTitle3,
      onTap: _itemList[index].tapEvent,
    );
  }
  
}