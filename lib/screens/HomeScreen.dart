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
      backgroundColor: const Color(0xff856CD4),
      body: Center(
        child: Image.asset('assets/images/chef.png'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.settings),
        onPressed: () => Navigator.pushNamed(context, router.mapScreen),
      ),
    );
  }
}
