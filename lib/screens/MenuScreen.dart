import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:luigi_pizza/dto/Menu.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/router/Router.dart' as router;
import 'package:luigi_pizza/store/MenuStore.dart';

class MenuScreen extends StatefulWidget {
  final Restaurant restaurantInfos;

  const MenuScreen({Key? key, required this.restaurantInfos}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<List<Menu>>? restaurantMenu;

  var others;

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
    List<Menu> futureMenu = await fetchMenu(widget.restaurantInfos.id);

    return futureMenu;
  }

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            color: Colors.yellow,
            child: Text(
              "${widget.restaurantInfos.name}'s menu",
              style: const TextStyle(fontFamily: "title", fontSize: 50),
            ),
          ),
          Container(
            color: Colors.red,
            height: 600,
            child: PageView(
              controller: controller,
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
                              if (menu[index].category == "Pizza") {
                                return GestureDetector(
                                    onTap: () {
                                      print(menu[index].name);
                                    },
                                    child: Container(
                                      height: 75,
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(menu[index].category),
                                      ),
                                    ));
                              } else {
                                return Container();
                              }
                            });
                      } else if (snapshot.hasError) {
                        return const Text("error");
                      }
                      return const CircularProgressIndicator();
                    }),
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
                              if (menu[index].category == "Dryck") {
                                return Container(
                                  height: 75,
                                  color: Colors.green,
                                  child: Center(
                                    child: Text(menu[index].category),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else if (snapshot.hasError) {
                        return const Text("error");
                      }
                      return const CircularProgressIndicator();
                    }),
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
                              if (menu[index].category == "TillbehÃ¶r") {
                                return Container(
                                  height: 75,
                                  color: Colors.green,
                                  child: Center(
                                    child: Text(menu[index].category),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else if (snapshot.hasError) {
                        return const Text("error");
                      }
                      return const CircularProgressIndicator();
                    }),
              ],
            ),
          )
        ],
      ),
    );
    // return PageView(
    //   controller: controller,
    //   children: const [
    //     Center(
    //       child: Text("first item"),
    //     ),
    //     Center(
    //       child: Text("second item"),
    //     ),
    //     Center(
    //       child: Text("third item"),
    //     )
    //   ],
    // );
    // // return Scaffold(
    //   body: Center(
    //       child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       FutureBuilder<List<Menu>>(
    //         future: restaurantMenu,
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             List<Menu>? menu = snapshot.data;
    //             return ListView.builder(
    //                 scrollDirection: Axis.vertical,
    //                 shrinkWrap: true,
    //                 itemCount: menu!.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return Container(
    //                     height: 75,
    //                     color: Colors.blue,
    //                     child: Center(
    //                       child: Text(menu[index].category),
    //                     ),
    //                   );
    //                 });
    //           } else if (snapshot.hasError) {
    //             return Text("error");
    //           }
    //           return const CircularProgressIndicator();
    //         },
    //       ),
    //     ],
    //   )),
    // );
  }
}
/* List<Menu> pizza = [];
                        List<Menu> others = [];
                        menu?.map((item) => {
                              if (item.category.contains('pizza'))
                                {pizza = item as List<Menu>}
                              else
                                {others = item as List<Menu>}
                            }); */