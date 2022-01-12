import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:luigi_pizza/router/Router.dart' as router;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: const Center(
        child: Text('Hello, oflutter.com'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.settings),
        onPressed: () => Navigator.pushNamed(context, router.mapScreen),
      ),
    );
  }
}
