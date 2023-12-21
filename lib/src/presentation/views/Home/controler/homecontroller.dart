// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_api_project1/product_model.dart';
//
// class ProductController extends GetxController {
//   final Rx<Product?> productData = Rx<Product?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//     // print('ProductController initialized');
//     fetchData();
//
//   }
//
//   Future<void> fetchData() async {
//     try {
//       print('Fetching data...');
//       final response = await http.get(Uri.parse('https://dummyjson.com/products'));
//       if (response.statusCode == 200) {
//         productData.value = Product.fromJson(json.decode(response.body));
//         print('Raw JSON response: ${response.body}');
//
//         print('Data fetched successfully: $productData');
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//       throw Exception('Error: $e');
//     }
//   }
//
// }
