import 'package:flutter/material.dart';
import 'package:luigi_pizza/providers/ArticlesStore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'router/Router.dart' as router;
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ArticlesStore(),
      child: const MyApp(),
    ),
  );
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
        home: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return const MyHomePage(title: "Luigi's Pizza");
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.controller,
      initialRoute: router.homeScreen,
    );
  }
}
