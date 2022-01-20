import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  // List articlesStore = [];

  // void _removeItemFromStore(int index) {
  //   setState(() {
  //     articlesStore.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    ArticlesStore dataStore =
        Provider.of<ArticlesStore>(context, listen: false);

    return Scaffold(
      // backgroundColor: Color(0xff856CD4),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.topCenter,
            // color: Colors.yellow,
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
                  // setState(() {
                  //   display = true;
                  //   articlesStore = articlesSelected;
                  // });
                  setState(() {
                    display = true;
                  });

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
                                      Consumer<ArticlesStore>(builder:
                                          (context, articleStore, child) {
                                        return ListView.separated(
                                          itemCount: articleStore.store.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: Image.asset(
                                                'assets/images/pizza.png',
                                              ),
                                              title: Text(
                                                  articleStore.store[index]),
                                              trailing: GestureDetector(
                                                child:
                                                    Icon(Icons.delete_outline),
                                                onTap: () {
                                                  //  _removeItemFromStore(
                                                  //     index);
                                                  // Provider.of<ArticlesStore>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .removeItem(index);
                                                  dataStore.removeItem(index);
                                                },
                                              ),
                                              contentPadding:
                                                  EdgeInsets.all(20),
                                              onTap: () {
                                                print(index);
                                              },
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return Divider();
                                          },
                                        );
                                      }));
                            },
                            child: Consumer<ArticlesStore>(
                                builder: (context, articleStore, child) {
                              return Text(
                                  "Afficher mon panier (${articleStore.store.length})");
                            })),
                      ),
                    )
                  : Container()
            ],
          ))
        ],
      ),
    );
  }
}

//  ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: 1,
//                                 itemBuilder: (context, index) {
//                                   return ListView(
//                                     shrinkWrap: true,
//                                     children: ListTile
//                                         .divideTiles(context: context, tiles: [
//                                       for (var article in articlesStore)
//                                         ListTile(
//                                           leading: Image.asset(
//                                             'assets/images/pizza.png',
//                                           ),
//                                           title: Text(article),
//                                           trailing: GestureDetector(
//                                             child: Icon(Icons.delete_outline),
//                                             onTap: () {
//                                               print(index);
//                                             },
//                                           ),
//                                           contentPadding: EdgeInsets.all(20),
//                                           onTap: () {
//                                             print(articlesStore[index]);
//                                           },
//                                         )
//                                     ]).toList(),
//                                   );
//                                 },
//                               ),