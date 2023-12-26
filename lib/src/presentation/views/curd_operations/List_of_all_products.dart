import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_project1/src/domain/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/respositories/api_url.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _numberOfPostsPerRequest = 20;
  final PagingController<int, Product> _pagingController =
  PagingController(firstPageKey: 1);
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
    super.initState();
  }

  Future<void> fetchData(int pageKey) async {
    try {
      final int itemsPerPage = _numberOfPostsPerRequest;

      final response = await http.get(
        Uri.parse(
          '${ApiUrl.baseUrl}${ApiUrl.fetchProduct}?limit=$_numberOfPostsPerRequest&page=$pageKey',

        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Product> newProducts =
        responseData.map((data) => Product.fromJson(data)).toList();

        _pagingController.appendPage(newProducts, pageKey + 1);
      } else {
        print('Error: ${response.statusCode}');
        _pagingController.error = Exception('Failed to load data');
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart App"),
        centerTitle: true,

      ),

      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView<int, Product>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, product, index) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Image.network(
                        product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.title),
                      subtitle: Text(product.description),
                      trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
