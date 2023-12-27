import 'package:flutter/material.dart';
import 'package:flutter_api_project1/src/data/api_fetch/controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../domain/models/product_model.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _futureProducts;
  final controller =Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _futureProducts = controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Data fetched successfully
            List<Product>? products = snapshot.data;

            return ListView.builder(
              itemCount: products?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    products![index].image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(products![index].title),
                  subtitle: Text('Price: ${products[index].price.toString()}'),
                  // Add more information as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
