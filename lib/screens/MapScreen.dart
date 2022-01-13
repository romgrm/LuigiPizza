import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luigi_pizza/dto/Restaurant.dart';
import 'package:luigi_pizza/store/RestaurantStore.dart';
import 'package:luigi_pizza/router/Router.dart' as router;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  final LatLng _center = const LatLng(59.3157090, 18.0335070);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final restaurantsStore = await fetchRestaurant();
    mapController = controller;

    setState(() {
      _markers.clear();
      for (final restaurant in restaurantsStore) {
        final marker = Marker(
            markerId: MarkerId(restaurant.name),
            position: LatLng(restaurant.lat, restaurant.long),
            infoWindow: InfoWindow(
                title: restaurant.name,
                snippet: "${restaurant.street}\n${restaurant.city}",
                //TODO: send restaurantId on push()
                onTap: () => Navigator.pushNamed(context, router.menuScreen,
                    arguments: restaurant.id)));
        _markers[restaurant.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
    return MaterialApp(
        home: Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Restaurant>>(
            // future: futureRestaurants,
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
            // child: const MapBox(),
          )
        ],
      )),
    ));
  }
}
