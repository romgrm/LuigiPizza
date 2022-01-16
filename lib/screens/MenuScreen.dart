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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
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
          CarouselMenu(restaurantInfos: widget.restaurantInfos),
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