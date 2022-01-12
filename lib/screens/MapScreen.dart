import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/map/Map.dart';
import 'package:luigi_pizza/store/RestaurantStore.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Future<List<Restaurant>> futureRestaurants = fetchRestaurant();
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              return const CircularProgressIndicator();
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
