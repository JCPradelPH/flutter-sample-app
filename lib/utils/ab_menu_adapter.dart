
import 'package:flutter/material.dart';

class MenuAdpater {
  const MenuAdpater({ this.title, this.icon, this.iconColor, this.flag, this.actionId });
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool flag;
  final dynamic actionId;
}