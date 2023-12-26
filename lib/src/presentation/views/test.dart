// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_api_project1/src/data/api_fetch/controller.dart';
// import 'package:flutter_api_project1/src/domain/models/product_model.dart';
// import 'package:flutter_api_project1/src/domain/respositories/api_url.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:shimmer/shimmer.dart';
//
//
//
// class Category_page extends GetView<HomeController> {
//   Category_page({Key? key}) : super(key: key);
//   // final controller =Get.put(HomeController());
//
//   // final _numberOfPostsPerRequest = 20;
//   //
//   // List<Product> _products = [];
//   //
//   // bool _isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return controller.obx((state) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text("Cart App"),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               icon: Icon(Icons.category),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text("Choose a category"),
//                       content: Column(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               ApiUrl.setCategory('electronics');
//                               _fetchData();
//                               Navigator.pop(context);
//                             },
//                             child: Text('Electronics'),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               ApiUrl.setCategory('jewelery');
//                               _fetchData();
//                               Navigator.pop(context);
//                             },
//                             child: Text('Jewelry'),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               ApiUrl.setCategory("women's clothing");
//                               _fetchData();
//                               Navigator.pop(context);
//                             },
//                             child: Text("Women's Clothing"),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               ApiUrl.setCategory("men's clothing");
//                               _fetchData();
//                               Navigator.pop(context);
//                             },
//                             child: Text("Men's Clothing"),
//                           ),
//                           // Add more categories as needed
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//         body: _isLoading
//             ? _buildShimmerLoading()
//             : ListView.builder(
//           itemCount: _products.length,
//           itemBuilder: (context, index) {
//             final product = _products[index];
//             return Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListTile(
//                     leading: Image.network(
//                       product.image,
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     ),
//                     title: Text(product.title),
//                     subtitle: Text(product.description),
//                     trailing: Text('\$${product.price.toStringAsFixed(2)}'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//     },
//       onLoading: _buildShimmerLoading(),
//       onError: (error) => Center(child: Text(error.toString())));
//   }}
//
//   Widget _buildShimmerLoading() {
//     return ListView.builder(
//       itemCount: _numberOfPostsPerRequest,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 50.0,
//                   color: Colors.white, // Shimmer background color
//                 ),
//                 SizedBox(height: 8.0),
//                 Container(
//                   width: double.infinity,
//                   height: 16.0,
//                   color: Colors.white, // Shimmer background color
//                 ),
//                 SizedBox(height: 8.0),
//                 Container(
//                   width: double.infinity,
//                   height: 12.0,
//                   color: Colors.white, // Shimmer background color
//                 ),
//                 SizedBox(height: 8.0),
//                 Container(
//                   width: double.infinity,
//                   height: 16.0,
//                   color: Colors.white, // Shimmer background color
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
