import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:luigi_pizza/dto/Menu.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/store/MenuStore.dart';

class CarouselMenu extends StatefulWidget {
  final Restaurant restaurantInfos;
  const CarouselMenu({Key? key, required this.restaurantInfos})
      : super(key: key);

  @override
  _CarouselMenuState createState() => _CarouselMenuState();
}

class _CarouselMenuState extends State<CarouselMenu> {
  final PageController controller = PageController();
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
    List<Menu> futureMenu = await fetchMenu(widget.restaurantInfos.id);

    return futureMenu;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: 600,
      child: PageView(
        controller: controller,
        children: [
          FutureBuilder<List<Menu>>(
              future: restaurantMenu,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Menu>? menu = snapshot.data;

                  return ListView.separated(
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
                                height: 150,
                                // color: Colors.white,
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 80,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 50),
                                      // width: 50,
                                      child: Image.asset(
                                          'assets/images/pizza.png'),
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              menu[index].name,
                                              style: const TextStyle(
                                                  fontFamily: "SubTitle",
                                                  fontSize: 30,
                                                  color: Color(0xff856CD4)),
                                            ),
                                          ),
                                          if (menu.isNotEmpty)
                                            for (var topping
                                                in menu[index].topping!)
                                              Text(
                                                topping,
                                                style: const TextStyle(
                                                    fontFamily: "TextItalic"),
                                              )
                                        ]),
                                  ],
                                )));
                      } else {
                        return Container();
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
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
    );
  }
}