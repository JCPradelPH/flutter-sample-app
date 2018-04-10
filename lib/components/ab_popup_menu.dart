import 'package:flutter/material.dart';

import '../utils/ab_menu_adapter.dart';
import './button_icon.dart';

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

  final num _fontSize = 15.0, _iconSize = 35.0, 
    _positionIconLeft = 0;
  final Color _textColor = const Color.fromRGBO(88,88,88, 1.0);

  _menuItems(choice) => new ButtonIcon(
    choice.title, 
    choice.icon, _positionIconLeft,
    iconSize: _iconSize,
    iconColor: choice.iconColor,
    textStyle: new TextStyle(
      fontSize: _fontSize,
      color: _textColor,
      fontWeight: FontWeight.w300
    )
  );
}