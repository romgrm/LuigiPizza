import 'package:flutter/material.dart';
import 'package:luigi_pizza/dto/Menu.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/store/MenuStore.dart';
import 'package:luigi_pizza/store/RestaurantStore.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: "Luigi's Pizza"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // late Future<Menu> futureMenu = fetchMenu();
  // late Future<Restaurant> futureRestaurant = fetchRestaurant();
  Future<List<Restaurant>> futureRestaurants = fetchRestaurant();
  // List<Restaurant> _restaurants = <Restaurant>[];
  // late Future<Pizza> futurePizza = fetchMenu();

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
            child: FutureBuilder<List<Restaurant>>(
          future: futureRestaurants,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Restaurant>? restaurants = snapshot.data;
              return ListView.builder(
                  itemCount: restaurants!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 75,
                      color: Colors.white,
                      child: Center(
                        child: Text(restaurants[index].street),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("error");
            }
            return CircularProgressIndicator();
          },
        )),
      ),
    );
  }
}
