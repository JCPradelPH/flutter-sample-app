import 'package:flutter/material.dart';

import '../utils/global_adapter.dart';

// generic widget to create action bar menus
class ABPopUpMenu extends StatelessWidget{

  final dynamic onSelect;
  final dynamic store;
  final List<MenuAdapter> _choices;

  ABPopUpMenu(this._choices,{this.onSelect,this.store});

  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<MenuAdapter>(
      onSelected: (menuAdapter) => onSelect(menuAdapter,store),
      itemBuilder: _menuChoices,
    );
  }

  List<PopupMenuEntry<MenuAdapter>> _menuChoices(BuildContext context) {
    return _choices
      .map( (choice) {
        return new PopupMenuItem<MenuAdapter>(
          value: choice,
          child: _menuItems(choice),
        );
      }).toList();
  }

  _menuItems(choice) => new ListTile(
    leading: new Icon(choice.icon),
    title: new Text(choice.title)
  );
}