class Product {
  String id;
  String name;

  Product({required this.id, required this.name});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}
