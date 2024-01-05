class ApiUrl {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String fetchProduct = '/products';
  static String category = "/category/electronics"; // Default category
  static Duration connectionTimeout = Duration(milliseconds: 1000);
  static Duration receiveTimeout = Duration(milliseconds: 1000);

  static void setCategory(String newCategory) {
    category = '/category/$newCategory';
  }

  static const String addProductEndpoint = '/products';
  static const String userEndpoint = '/users';
  static const String loginEndpoint = '/auth/login';
  static const String cartsEndpoint = '/carts';
}
