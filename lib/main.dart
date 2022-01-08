import 'package:flutter/material.dart';
import 'package:luigi_pizza/dto/Pizza.dart';
import 'package:luigi_pizza/store/menu.dart';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

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

  /* Future<Pizza> fetchMenu() async {
    final response = await http.get(Uri.parse(
        "https://private-anon-06cb6fff8f-pizzaapp.apiary-mock.com/restaurants/2/menu?category=Pizza&orderBy=rank"));

    if (response.statusCode == 200) {
      print(response);

      return Pizza.fromJson(jsonDecode(response.body));
    } else {
      return throw Exception('Failed to load menu');
    }
  } */
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  late Future<Pizza> futurePizza = fetchMenu();

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
          child: FutureBuilder<Pizza>(
            future: futurePizza,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
