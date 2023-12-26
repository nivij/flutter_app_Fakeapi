import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../domain/models/product_model.dart';
import '../../domain/respositories/api_url.dart';

class HomeController extends GetxController with StateMixin<List<Product>>{
  // RxList<Product> products = <Product>[].obs;
  // RxList<Product> highRatedProducts = <Product>[].obs;
  // RxList<Product> smartphoneProducts = <Product>[].obs;
  // final Rx<List<Product>> productData = Rx<List<Product>>(<Product>[]);

  Future<List<Product>> fetchData() async {
    try {
      print('Fetching data...');
      final response = await Dio().get('${ApiUrl.baseUrl}${ApiUrl.fetchProduct}');
      if (response.statusCode == 200) {
        final List<dynamic> rawData = json.decode(response.data);
        final List<Product> products = rawData
            .map((jsonProduct) => Product.fromJson(jsonProduct))
            .toList();

        print('Raw JSON response: ${response.data}');
        print('Data fetched successfully: $products');
        return products; // Return the list of products
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error: $e');
    }
  }

  Future<List<Product>> getSpecificCategory() async {
    try {
      final response = await Dio().get(
        '${ApiUrl.baseUrl}${ApiUrl.fetchProduct}${ApiUrl.category}?limit=20',
      );

      if (response.statusCode == 200) {
        final List<dynamic> rawData = response.data;
        if (rawData is List) {
          return rawData.map((data) => Product.fromJson(data)).toList();
        } else {
          print('Invalid response format: $rawData');
          throw Exception('Failed to load data');
        }
      } else if (response.statusCode == 404) {
        print('Category not found');
        return []; // Return an empty list or handle it based on your application logic
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("error --> $e");
      throw e;
    }
  }



  Future<void> addProduct(Product product) async {
    try {
      final response = await Dio().post(
        '${ApiUrl.baseUrl}${ApiUrl.addProductEndpoint}',
        data: product.toJson(),
        options: Options(
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == 200) {
        // Notify the UI that a new product is added
        update();

        print('Product added successfully');
        print('Response Body: ${response.data}');
      } else {
        print('Failed to add product: ${response.statusCode}');
        throw Exception('Failed to add product');
      }
    } catch (error) {
      print('Error adding product: $error');
      throw Exception('Error adding product: $error');
    }
  }
}
