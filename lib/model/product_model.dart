import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int id;
  String name;
  String description;
  String price;
  String image;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "image": image
      };
}
