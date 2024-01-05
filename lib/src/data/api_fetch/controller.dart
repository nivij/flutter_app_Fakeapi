import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '../../domain/exceptions/api_exception.dart';
import '../../domain/models/product_model.dart';
import '../../domain/respositories/api_url.dart';

class HomeController extends GetxController with StateMixin<List<Product>>{
  // RxList<Product> products = <Product>[].obs;
  // RxList<Product> highRatedProducts = <Product>[].obs;
  // RxList<Product> smartphoneProducts = <Product>[].obs;
  // final Rx<List<Product>> productData = Rx<List<Product>>(<Product>[]);
  RxString username = ''.obs;
  RxString password = ''.obs;

  void updateUsername(String value) => username.value = value;
  void updatePassword(String value) => password.value = value;



  Future<void> loginUser() async {
    try {
      final response = await Dio().post(
        '${ApiUrl.baseUrl}${ApiUrl.loginEndpoint}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'username':  this.username.value,
          'password': this.password.value,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        final String token = jsonResponse['token'];

        Get.snackbar(
          'Success',
          'Login successful. Token: $token',
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Login successful: $jsonResponse');
      } else if (response.statusCode == 401) {
        final Map<String, dynamic> errorResponse = response.data;
        final String errorMessage = errorResponse['message'];

        Get.snackbar(
          'Authentication Error',
          errorMessage,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );

        print('Login failed with status code 401. Error message: $errorMessage');
      } else {
        // Handle other status codes
        print('Login failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Login error: $error');
      // Handle other errors, e.g., connection issues
    }
  }




  Future<List<Product>> fetchData() async {

    try {
      print('Fetching data...');
      final response = await Dio().get('${ApiUrl.baseUrl}${ApiUrl.fetchProduct}');
      if (response.statusCode == 200) {
        // Check if the response data is a List<dynamic>
        if (response.data is List<dynamic>) {
          final List<dynamic> rawData = response.data;
          final List<Product> products = rawData
              .map((jsonProduct) => Product.fromJson(jsonProduct))
              .toList();

          print('Raw JSON response: ${response.data}');
          print('Data fetched successfully: $products');
          return products; // Return the list of products
        } else {
          // Handle the case where the response data is not a list
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error: $e');
    }
  }
  Future<List<Cart>> fetchCartData({DateTime? startdate, DateTime? enddate}) async {
    try {
      print('Fetching cart data...');

      // Check if startdate and enddate are both null
      if (startdate == null && enddate == null) {
        // If both are null, make a request without the date parameters
        final response = await Dio().get('${ApiUrl.baseUrl}${ApiUrl.cartsEndpoint}');

        if (response.statusCode == 200) {
          if (response.data is List<dynamic>) {
            final List<dynamic> rawData = response.data;
            final List<Cart> cartProducts = rawData
                .map((jsonProduct) => Cart.fromJson(jsonProduct))
                .toList();

            print('Raw JSON response: ${response.data}');
            print('Cart data fetched successfully: $cartProducts');
            return cartProducts;
          } else {
            throw Exception('Invalid data format');
          }
        } else {
          throw Exception('Failed to load cart data');
        }
      } else {
        // If startdate or enddate is not null, format them and include in the request URL
        final formattedStartDate = startdate != null
            ? "${startdate.year}-${startdate.month.toString().padLeft(2, '0')}-${startdate.day.toString().padLeft(2, '0')}"
            : null;

        final formattedEndDate = enddate != null
            ? "${enddate.year}-${enddate.month.toString().padLeft(2, '0')}-${enddate.day.toString().padLeft(2, '0')}"
            : null;

        // print('-----------------------');
        // print('Request URL: ${ApiUrl.baseUrl}${ApiUrl.cartsEndpoint}?startdate=$formattedStartDate&enddate=$formattedEndDate');
        final response = await Dio().get('${ApiUrl.baseUrl}${ApiUrl.cartsEndpoint}?startdate=$formattedStartDate&enddate=$formattedEndDate');

        if (response.statusCode == 200) {
          if (response.data is List<dynamic>) {
            final List<dynamic> rawData = response.data;
            final List<Cart> cartProducts = rawData
                .map((jsonProduct) => Cart.fromJson(jsonProduct))
                .toList();

            print('Raw JSON response: ${response.data}');
            print('Cart data fetched successfully: $cartProducts');
            return cartProducts;
          } else {
            throw Exception('Invalid data format');
          }
        } else {
          throw Exception('Failed to load cart data');
        }
      }
    } catch (e) {
      print('Error fetching cart data: $e');
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle success for both 200 and 201
        // Notify the UI that a new product is added
        Get.find<HomeController>().update();

        // Show a success message
        Get.snackbar('Success', 'Product added successfully',
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM);

        print('Product added successfully');
        print('Response Body: ${response.data}');
      } else {
        // Handle other status codes
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors or other types of errors
      print('Error adding product: $error');
      Get.snackbar('Error', 'Failed to add product',
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM);
      throw Exception('Error adding product: $error');
    }
  }

  Future<void> updateProduct(int productId, Product updatedProduct) async {
    try {
      final response = await Dio().put(
        '${ApiUrl.baseUrl}${ApiUrl.addProductEndpoint}/$productId',
        data: updatedProduct.toJson(),
        options: Options(
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == 200) {
        // Notify the UI that the product is updated
        update();

        // Show a success message
        Get.snackbar(
          'Success',
          'Product updated successfully',
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );

        print('Product updated successfully');
        print('Response Body: ${response.data}');
      } else {
        // Handle other status codes
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (error) {
      // Handle Dio errors or other types of errors
      print('Error updating product: $error');
      Get.snackbar(
        'Error',
        'Failed to update product',
        duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception('Error updating product: $error');
    }
  }
}
