import 'package:flutter/material.dart' show IconData, Widget;
// show   Specify the classes to import, instead of all

// Model class
// In 'flutter-component' wasn't used because the approach was different
class MenuOption {

  final String route;
  final IconData icon;
  final String name;
  final Widget screen;

  MenuOption({
    required this.route,
    required this.icon,
    required this.name,
    required this.screen
  });
  // {}     Specify constructor's arguments by name instead of position

}


