import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:luigi_pizza/dto/Menu.dart';

Future<Menu> fetchMenu() async {
  final response = await http.get(Uri.parse(
      "https://private-anon-06cb6fff8f-pizzaapp.apiary-mock.com/restaurants/2/menu?category=Pizza&orderBy=rank"));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(response.body);
    return Menu.fromJson(jsonResponse[0]);
    /* return Pizza.fromJson(jsonDecode(response.body)); */
  } else {
    return throw Exception('Failed to load menu');
  }
}
