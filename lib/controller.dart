import 'dart:convert';

import 'package:get/get.dart';
import '../../product_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxList<ProductElement> highRatedProducts = <ProductElement>[].obs;
  RxList<ProductElement> smartphoneProducts = <ProductElement>[].obs;
  final Rx<Product?> productData = Rx<Product?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProductData();
  }

  Future<Product> fetchData() async {
    try {
      print('Fetching data...');
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        final product = Product.fromJson(json.decode(response.body));
        print('Raw JSON response: ${response.body}');

        print('Data fetched successfully: $product');
        return product; // Return the fetched product
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error: $e');
    }
  }

  void fetchProductData() async {
    try {
      final Product productData = await fetchData();

      highRatedProducts.assignAll(productData.products
          .where((product) => product.rating > 4.60)
          .toList());

      smartphoneProducts.assignAll(productData.products
          .where((product) => product.category.toLowerCase() == 'smartphones')
          .toList());
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching product data: $e');
    }
  }
}
