import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luigi_pizza/components/carouselMenu.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/providers/ArticlesStore.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final Restaurant restaurantInfos;

  MenuScreen({Key? key, required this.restaurantInfos}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool display = false;

  @override
  Widget build(BuildContext context) {
    // Use Provider.of() for access to data (getter/setter) without rebuild UI (listen: false)
    ArticlesStore dataStore =
        Provider.of<ArticlesStore>(context, listen: false);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            child: Text(
              "${widget.restaurantInfos.name}'s menu",
              style: TextStyle(fontFamily: "title", fontSize: 50),
            ),
          ),
          Expanded(
              child: Stack(
            children: [
              CarouselMenu(
                restaurantInfos: widget.restaurantInfos,
                articlesSelected: (List articlesSelected) {
                  setState(() {
                    display = true;
                  });
                  // Set store's ArticleStore with Carousel Child, without change UI's Carousel
                  dataStore.addItem(articlesSelected);
                },
              ),
              display
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: EdgeInsets.only(bottom: 30, top: 20),
                          child: CupertinoButton(
                              color: Color(0xff352B54),
                              disabledColor: Color(0xff352B54),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    builder: (BuildContext builder) =>
                                        // Listen ArticleStore's data and Rebuild UI of all elements who have Consumer
                                        Consumer<ArticlesStore>(builder:
                                            (context, articleStore, child) {
                                          return ListView.separated(
                                            itemCount:
                                                articleStore.store.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: Image.asset(
                                                  'assets/images/pizza.png',
                                                ),
                                                title: Text(
                                                    articleStore.store[index]),
                                                trailing: GestureDetector(
                                                  child: const Icon(
                                                      Icons.delete_outline),
                                                  onTap: () {
                                                    articleStore
                                                        .removeItem(index);
                                                  },
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(20),
                                                onTap: () {
                                                  print(index);
                                                },
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const Divider();
                                            },
                                          );
                                        }));
                              },
                              child:
                                  // Same SubTree like Carousel but we want to change UI's Text so we use Consumer instead of Provider.of()
                                  Consumer<ArticlesStore>(
                                      builder: (context, articleStore, child) {
                                return Text(
                                    "Afficher mon panier (${articleStore.store.length})");
                              }))),
                    )
                  : Container()
            ],
          ))
        ],
      ),
    );
  }
}
