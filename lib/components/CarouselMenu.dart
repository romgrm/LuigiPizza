import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../dto/Menu.dart';
import '../dto/Restaurant.dart';
import '../store/MenuStore.dart';

typedef IntCallback = Function(List articles);

class CarouselMenu extends StatefulWidget {
  final Restaurant restaurantInfos;
  final IntCallback articlesSelected;

  const CarouselMenu(
      {Key? key, required this.restaurantInfos, required this.articlesSelected})
      : super(key: key);

  @override
  _CarouselMenuState createState() => _CarouselMenuState();
}

class _CarouselMenuState extends State<CarouselMenu> {
  final PageController controller = PageController();
  Future<List<Menu>>? restaurantMenu;
  var articlesSelected = [];

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
      // height: Adaptive.h(85),
      decoration: const BoxDecoration(
          color: Color(0xff856CD4),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
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
                                    articlesSelected.add(menu[index].name);
                                    widget.articlesSelected(articlesSelected);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          Text(
                                            menu[index].name,
                                            style: const TextStyle(
                                                fontFamily: "SubTitle",
                                                fontSize: 30,
                                                color: Color(0xff856CD4)),
                                          ),
                                          Row(
                                            children: [
                                              for (var topping
                                                  in menu[index].topping!)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                  return const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      // color: Colors.red,
                      child: CircularProgressIndicator(
                        color: Color(0xff352b54),
                      ),
                    ),
                  );
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
                            return Card(
                                color: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 5,
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 20),
                                child: InkWell(
                                    onTap: () {
                                      articlesSelected.add(menu[index].name);
                                      widget.articlesSelected(articlesSelected);
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
                                                  'assets/images/jus.png'),
                                            ),
                                            Text(
                                              menu[index].name,
                                              style: const TextStyle(
                                                  fontFamily: "SubTitle",
                                                  fontSize: 30,
                                                  color: Color(0xff856CD4)),
                                            ),
                                            Row(
                                              children: [
                                                for (var topping
                                                    in menu[index].topping!)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                      ],
                                    )));
                          } else {
                            return const SizedBox.shrink();
                          }
                        });
                  } else if (snapshot.hasError) {
                    return const Text("error");
                  }
                  return const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(),
                  );
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
                          if (menu[index].category == "Tillbeh????r") {
                            return Card(
                                color: Colors.white,
                                shadowColor: Colors.black,
                                elevation: 5,
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 20),
                                child: InkWell(
                                    onTap: () {
                                      articlesSelected.add(menu[index].name);
                                      widget.articlesSelected(articlesSelected);
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
                                                  'assets/images/baton-de-glace.png'),
                                            ),
                                            Text(
                                              menu[index].name,
                                              style: const TextStyle(
                                                  fontFamily: "SubTitle",
                                                  fontSize: 30,
                                                  color: Color(0xff856CD4)),
                                            ),
                                            Row(
                                              children: [
                                                for (var topping
                                                    in menu[index].topping!)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                      ],
                                    )));
                          } else {
                            return const SizedBox.shrink();
                          }
                        });
                  } else if (snapshot.hasError) {
                    return const Text("error");
                  }
                  return const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
