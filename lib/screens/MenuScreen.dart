import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luigi_pizza/components/carouselMenu.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';

class MenuScreen extends StatefulWidget {
  final Restaurant restaurantInfos;

  const MenuScreen({Key? key, required this.restaurantInfos}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool display = false;
  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(fontFamily: "title", fontSize: 50),
            ),
          ),
          Expanded(
              child: Stack(
            children: [
              CarouselMenu(
                restaurantInfos: widget.restaurantInfos,
                numberOfArticles: (int numberOfArticles) {
                  setState(() {
                    display = true;
                  });
                },
              ),
              display
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        // color: Colors.green,
                        padding: EdgeInsets.only(bottom: 30, top: 20),
                        child: CupertinoButton(
                          // color: Color(0xff856CD4),
                          color: Colors.blue,
                          disabledColor: Colors.blue,
                          onPressed: () => print("yo"),
                          child: Text("Afficher mon panier"),
                        ),
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
