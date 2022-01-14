import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/screens/HomeScreen.dart';
import 'package:luigi_pizza/screens/MapScreen.dart';
import 'package:luigi_pizza/screens/MenuScreen.dart';

const homeScreen = 'home';
const mapScreen = 'map';
const menuScreen = 'menu';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homeScreen:
      return CupertinoPageRoute(builder: (context) => HomeScreen());
    // return MaterialPageRoute(builder: (context) => HomeScreen());
    case mapScreen:
      return CupertinoPageRoute(builder: (context) => MapScreen());
    // return MaterialPageRoute(builder: (context) => MapScreen());
    case menuScreen:
      return MaterialPageRoute(
          builder: (context) => MenuScreen(
                restaurantInfos: settings.arguments as Restaurant,
              ));
    default:
      throw ('This route name does not exist');
  }
}
