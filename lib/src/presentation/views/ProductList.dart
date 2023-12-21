import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_project1/src/domain/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  final _numberOfPostsPerRequest=10;

  final PagingController<int, Product> _pagingController =
  PagingController(firstPageKey: 1);
  @override
  void initState() {

    _pagingController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _scrollController.dispose();
  // }

  Future<void> fetchData(int pageKey) async {
    try {
      final int itemsPerPage = _numberOfPostsPerRequest;
      final int totalItems = 100;

      int startIndex = (pageKey - 1) * itemsPerPage;

      int endIndex = startIndex + itemsPerPage;

      if (endIndex > totalItems) {
        endIndex = totalItems;
      }

      final response = await http.get(
        Uri.parse('https://dummyjson.com/products?limit=$_numberOfPostsPerRequest&page=$pageKey&skip=$startIndex&total=$totalItems'),
      );

      if (response.statusCode == 200) {
        dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic>) {
          List<Product> newProducts = [Product.fromJson(responseData)];
          final isLastPage = endIndex >= totalItems;

          if (isLastPage) {
            _pagingController.appendLastPage(newProducts);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(newProducts, nextPageKey);
          }
        } else {
          print('Unexpected response format');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  // Future<void> refreshData() async {
  //   setState(() {
  //     _pageNumber+=1;
  //     _isLastPage = false;
  //     products.clear();
  //     loading = true;
  //     _error = false;
  //   });
  //
  //   await fetchData();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("cart App"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(()=>_pagingController.refresh()),
        child: PagedListView<int,Product>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Product>
            (itemBuilder:(context, item, index) {
            final Product product = item;
           return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  for (final productElement in product.products)
                    ListTile(
                      leading: Image.network(
                        productElement.images.first,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(productElement.title),
                      subtitle: Text(productElement.description),
                      trailing: Text('\$${productElement.price.toStringAsFixed(2)}'),
                    ),
                ],
              ),
            );
            },

    ),
        )
      ),
    );
  }


}
