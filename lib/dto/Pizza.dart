import 'package:flutter/material.dart';
import 'package:luigi_pizza/dto/Toppings.dart';

class Pizza {
  final int id;
  final String category;
  final String name;
  final List<String> topping;
  final int price;
  final int rank;

  Pizza(this.id, this.category, this.name, this.topping, this.price, this.rank);

  factory Pizza.fromJson(Map<String, dynamic> json) {
    var toppingsFromJson = json['topping'];

    List<String> toppings = toppingsFromJson.cast<String>();

    return Pizza(json['id'], json['category'], json['name'], toppings,
        json['price'], json['rank']);
  }
}
