import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luigi_pizza/dto/Menu.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/map/Map.dart';
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
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<List<Restaurant>> futureRestaurants = fetchRestaurant();

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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<List<Restaurant>>(
                future: futureRestaurants,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Restaurant>? restaurants = snapshot.data;
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: restaurants!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 75,
                            color: Colors.blue,
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
              ),
              Container(
                height: 300,
                width: 300,
                color: Colors.red,
                child: const MapBox(),
              )
            ],
          )),
        ));
  }
}
