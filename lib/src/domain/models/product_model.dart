import 'dart:convert';

enum Category {
  ELECTRONICS,
  JEWELRY,
  MEN_S_CLOTHING,
  WOMEN_S_CLOTHING,
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate']?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}

class Product {
  int id;
  String title;
  double price;
  String description;
  Category category;
  String image;
  Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price']?.toDouble() ?? 0.0,
      category: _parseCategory(json['category']),
      image: json['image'] ?? '',
      rating: Rating.fromJson(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating.toJson(),
      'category': _categoryToString(category),
      'image': image,
    };
  }

  static Category _parseCategory(dynamic category) {
    switch (category?.toString().toLowerCase()) {
      case 'electronics':
        return Category.ELECTRONICS;
      case 'jewelry':
        return Category.JEWELRY;
      case 'men\'s clothing':
        return Category.MEN_S_CLOTHING;
      case 'women\'s clothing':
        return Category.WOMEN_S_CLOTHING;
      default:
      // Provide a default value or handle the error as needed
        return Category.ELECTRONICS;
    }
  }

  static String _categoryToString(Category category) {
    switch (category) {
      case Category.ELECTRONICS:
        return 'electronics';
      case Category.JEWELRY:
        return 'jewelry';
      case Category.MEN_S_CLOTHING:
        return 'men\'s clothing';
      case Category.WOMEN_S_CLOTHING:
        return 'women\'s clothing';
    }
  }
}




class User {
  Address address;
  int id;
  String email;
  String username;
  String password;
  Name name;
  String phone;
  int v;

  User({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
  });

}

class Address {
  Geolocation geolocation;
  String city;
  String street;
  int number;
  String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

}

class Geolocation {
  String lat;
  String long;

  Geolocation({
    required this.lat,
    required this.long,
  });

}

class Name {
  String firstname;
  String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });

}


class Cart {
  int id;
  dynamic userId;
  DateTime date;
  List<CartProduct> products;
  int v;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as int? ?? 0,
      userId: json['userId'],
      date: DateTime.parse(json['date'] ?? ''),
      products: (json['products'] as List<dynamic>?)
          ?.map((productJson) => CartProduct.fromJson(productJson))
          .toList() ?? [],
      v: json['__v'] as int? ?? 0,
    );
  }
}


class CartProduct {
  int productId;
  int quantity;

  CartProduct({
    required this.productId,
    required this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
    );
  }
}



