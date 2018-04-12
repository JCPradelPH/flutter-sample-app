import 'package:flutter/material.dart';

import '../utils/global_adapter.dart';


class ABPopUpMenu extends StatelessWidget{

  final dynamic onSelect;
  final List<MenuAdapter> _choices;

  ABPopUpMenu(this._choices,{this.onSelect});

  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<MenuAdapter>(
      onSelected: onSelect,
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