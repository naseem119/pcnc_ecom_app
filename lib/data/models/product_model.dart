class Product {
  final int id;
  final String title;
  final int price;
  final String description;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['images'][0],
      category: json['category']['name'],
    );
  }
}
