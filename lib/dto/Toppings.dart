import 'dart:ffi';

class Toppings {
  final Array topping;

  Toppings(this.topping);

  factory Toppings.fromJson(Map<String, dynamic> json) {
    return Toppings(json["topping"]);
  }
}
