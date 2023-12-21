import 'dart:convert';

import 'package:get/get.dart';
import '../../domain/models/product_model.dart';
import 'package:http/http.dart' as http;

import '../../domain/respositories/api_services.dart';


class HomeController extends GetxController {
  RxList<ProductElement> highRatedProducts = <ProductElement>[].obs;
  RxList<ProductElement> smartphoneProducts = <ProductElement>[].obs;
  final Rx<Product?> productData = Rx<Product?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchProductData();
  }

  Future<List<ProductElement>> fetchData() async {
    try {
      print('Fetching data...');
      final response = await http.get(Uri.parse('${ApiService.baseUrl}${ApiService.fetchProduct}'));
      if (response.statusCode == 200) {
        final productData = Product.fromJson(json.decode(response.body));
        print('Raw JSON response: ${response.body}');

        print('Data fetched successfully: $productData');
        return productData.products; // Return the list of products
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
      final List<ProductElement> products = await fetchData();

      highRatedProducts.assignAll(products
          .where((product) => product.rating! > 4.60)
          .toList());

      smartphoneProducts.assignAll(products
          .where((product) => product.category.toLowerCase() == 'smartphones')
          .toList());
    } catch (e) {
      // Handle errors if necessary
      print('Error fetching product data: $e');
    }
  }

  Future<void> addProduct(ProductElement product) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}${ApiService.addProductEndpoint}'),
        body: jsonEncode(product.toJson()), // Convert product to JSON
        headers: {'Content-Type': 'application/json'}, // Specify content type
      );

      if (response.statusCode == 200) {
        // Product added successfully, handle the response if needed
        print('Product added successfully');
        print('Response Body: ${response.body}');

      } else {
        // Handle error response
        print('Failed to add product: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error adding product: $error');
    }
  }

}
