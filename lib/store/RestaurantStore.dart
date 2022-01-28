import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dto/Menu.dart';
import '../dto/Restaurant.dart';

Future<List<Restaurant>> fetchRestaurant() async {
  final response = await http.get(Uri.parse(
      "https://private-anon-06cb6fff8f-pizzaapp.apiary-mock.com/restaurants/"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(response.body);

    return jsonResponse
        .map((restaurants) => Restaurant.fromJson(restaurants))
        .toList();
  } else {
    return throw Exception('Failed to load menu');
  }
}
