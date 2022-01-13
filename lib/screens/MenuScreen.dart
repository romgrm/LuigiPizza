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
  Future<List<Menu>>? restaurantMenu;

  @override
  void initState() {
    super.initState();
    // we are not really calling setState() within initState() because _onMenuCreated is asynchronous so initState() is already called
    // TODO: find a way to call setState() and set restaurantMenu on another place
    setState(() {
      restaurantMenu = _onMenuCreated();
    });
  }

  Future<List<Menu>> _onMenuCreated() async {
    List<Menu> futureMenu = await fetchMenu(widget.restaurantId);
    // setState(() {
    //   restaurantMenu = futureMenu;
    // });
    return futureMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Menu>>(
            future: restaurantMenu,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Menu>? menu = snapshot.data;
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: menu!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 75,
                        color: Colors.blue,
                        child: Center(
                          child: Text(menu[index].category),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("error");
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      )),
    );
  }
}
