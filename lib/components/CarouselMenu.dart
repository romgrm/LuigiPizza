import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:luigi_pizza/dto/Menu.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/store/MenuStore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

typedef IntCallback = Function(int numberOfArticles);

class CarouselMenu extends StatefulWidget {
  final Restaurant restaurantInfos;
  final IntCallback numberOfArticles;

  const CarouselMenu(
      {Key? key, required this.restaurantInfos, required this.numberOfArticles})
      : super(key: key);

  @override
  _CarouselMenuState createState() => _CarouselMenuState();
}

class _CarouselMenuState extends State<CarouselMenu> {
  final PageController controller = PageController();
  Future<List<Menu>>? restaurantMenu;
  var articleStore = 0;

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
    return Expanded(
        child: Container(
            // height: Adaptive.h(85),
            decoration: const BoxDecoration(
                color: Color(0xff856CD4),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
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
                                return Card(
                                    color: Colors.white,
                                    shadowColor: Colors.black,
                                    elevation: 5,
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 20),
                                    child: InkWell(
                                        onTap: () {
                                          debugPrint(menu[index].name);
                                          articleStore += 1;
                                          widget.numberOfArticles(articleStore);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 10.h,
                                                  margin: const EdgeInsets.only(
                                                      top: 20, bottom: 10),
                                                  // color: Colors.green,
                                                  child: Image.asset(
                                                      'assets/images/pizza.png'),
                                                ),
                                                Container(
                                                  child: Text(
                                                    menu[index].name,
                                                    style: const TextStyle(
                                                        fontFamily: "SubTitle",
                                                        fontSize: 30,
                                                        color:
                                                            Color(0xff856CD4)),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    for (var topping
                                                        in menu[index].topping!)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 20),
                                                        child: Text(
                                                          "${topping}, ",
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "TextItalic"),
                                                        ),
                                                      )
                                                  ],
                                                )
                                              ],
                                            ),

                                            // for (var topping
                                            //     in menu[index].topping!)
                                            //   Text(
                                            //     topping,
                                            //     style: const TextStyle(
                                            //         fontFamily: "TextItalic"),
                                            //   ),
                                          ],
                                        )));
                              } else {
                                return const SizedBox
                                    .shrink(); // best way to return an empty widget without impact perf
                              }
                            },
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
            )));
  }
}
