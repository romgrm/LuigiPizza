class Restaurant {
  final int id;
  final String name;
  final String? street;
  final String? city;
  final double? lat;
  final double? long;

  Restaurant(
      {required this.id,
      required this.name,
      this.street = " ",
      this.city = "",
      this.lat,
      this.long});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json["id"],
        name: json["name"],
        street: json["address1"],
        city: json["address2"],
        lat: json["latitude"],
        long: json["longitude"]);
  }
}
