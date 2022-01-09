class Restaurant {
  final int id;
  final String name;
  final String street;
  final String city;
  final double lat;
  final double long;

  Restaurant(this.id, this.name, this.street, this.city, this.lat, this.long);

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(json["id"], json["name"], json["address1"],
        json["address2"], json["latitude"], json["longitude"]);
  }
  
}
