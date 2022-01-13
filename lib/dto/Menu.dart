class Menu {
  final int id;
  final String category;
  final String name;
  final List<String>? topping;
  final int price;
  final int? rank;

  Menu(this.id, this.category, this.name, this.topping, this.price, this.rank);

  factory Menu.fromJson(Map<String, dynamic> json) {
    var toppingsFromJson = json['topping'] ?? [];

    List<String>? toppings = toppingsFromJson.cast<String>() ?? [];

    return Menu(json['id'], json['category'], json['name'], toppings ?? [],
        json['price'], json['rank'] ?? 0);
  }
}
