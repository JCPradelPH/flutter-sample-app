
import 'package:flutter/material.dart';

class MenuAdapter {
  const MenuAdapter({ 
    this.title, 
    this.icon, 
    this.iconColor, 
    this.flag, 
    this.actionId, 
    this.listImage, 
    this.listTitle });
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool flag;
  final dynamic actionId;
  final Image listImage;
  final Text listTitle;
}