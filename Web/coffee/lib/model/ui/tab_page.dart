import 'package:flutter/material.dart';

class TabPage {
  final String label;
  final String routeName;
  final Icon icon;
  final Icon selectedIcon;
  final Widget child;

  TabPage(
      {this.label, this.routeName, this.icon, this.selectedIcon, this.child});
}
