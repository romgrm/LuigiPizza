import 'package:flutter/material.dart';
import 'package:luigi_pizza/screens/HomeScreen.dart';
import 'package:luigi_pizza/screens/MapScreen.dart';
import 'package:luigi_pizza/screens/MenuScreen.dart';

const homeScreen = 'home';
const mapScreen = 'map';
const menuScreen = 'menu';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homeScreen:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case mapScreen:
      return MaterialPageRoute(builder: (context) => MapScreen());
    case menuScreen:
      return MaterialPageRoute(builder: (contenxt) => MenuScreen());
    default:
      throw ('This route name does not exist');
  }
}
