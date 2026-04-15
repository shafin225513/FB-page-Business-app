class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id, 
    required this.name, 
    required this.description, 
    required this.price, 
    required this.imageUrl
  });

  // This turns the JSON from Supabase into this Product object
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'] ?? 'No Name',
      description: map['description'] ?? '',
      price: (map['price'] as num).toDouble(),
      imageUrl: map['image_url'] ?? '',
    );
  }
}