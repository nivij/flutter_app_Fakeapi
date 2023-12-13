class Product {
  List<ProductElement> products;  // Change this line to use ProductElement instead of Product

  int total;
  int skip;
  int limit;

  Product( {
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsList = json['products'];
    List<ProductElement> parsedProducts = List<ProductElement>.from(
      productsList.map((product) => ProductElement.fromJson(product)),
    );

    return Product(
      products: parsedProducts,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}




class ProductElement {
  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  ProductElement({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) {
    return ProductElement(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPercentage: (json['discountPercentage'] is int)
          ? json['discountPercentage'].toDouble()
          : json['discountPercentage'],
      rating: (json['rating'] is int) ? json['rating'].toDouble() : json['rating'],
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }

}
