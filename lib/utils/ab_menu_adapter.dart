
import 'package:flutter/material.dart';

class MenuAdapter {
  const MenuAdapter({ 
    this.title, 
    this.icon, 
    this.iconColor, 
    this.flag, 
    this.actionId, 
    this.listImage, 
    this.subTitle1, 
    this.subTitle2, 
    this.subTitle3, 
    this.tapEvent, 
    this.listTitle });
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool flag;
  final dynamic actionId;
  final Image listImage;
  final Text listTitle;
  final Text subTitle1;
  final Text subTitle2;
  final Text subTitle3;
  final VoidCallback tapEvent;
}