import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dto/Menu.dart';

Future<List<Menu>> fetchMenu(restaurantId) async {
  final int id = restaurantId;

  final response = await http.get(Uri.parse(
      "https://private-anon-06cb6fff8f-pizzaapp.apiary-mock.com/restaurants/$id/menu?category=Pizza&orderBy=rank"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(response.body);
    return jsonResponse.map((menus) => Menu.fromJson(menus)).toList();
  } else {
    return throw Exception('Failed to load menu');
  }
}
