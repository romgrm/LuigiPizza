import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:luigi_pizza/dto/Menu.dart';
import 'package:luigi_pizza/router/Router.dart' as router;
import 'package:luigi_pizza/store/MenuStore.dart';

class MenuScreen extends StatefulWidget {
  final dynamic restaurantId;

  const MenuScreen({Key? key, required this.restaurantId}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Menu? restaurantMenu;

  @override
  void initState() {
    super.initState();
    _onMenuCreated();
  }

  Future<Menu> _onMenuCreated() async {
    final futureMenu = await fetchMenu(widget.restaurantId);
    setState(() {
      restaurantMenu = futureMenu;
    });
    return futureMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(restaurantMenu?.name ?? ""),
      ),
    );
  }
}
