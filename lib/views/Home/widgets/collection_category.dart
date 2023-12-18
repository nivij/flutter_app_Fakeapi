// category_listview.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constant/text_font.dart';
import '../../../product_model.dart';
import '../controler/homecontroller.dart';

class CategoryListView extends StatelessWidget {
  final List<ProductElement> products;
  final ProductController productController = Get.put(ProductController());

  CategoryListView({
    Key? key,
    required this.products,
  }) : super(key: key);


  String getFirstImageForCategory(String category) {
    final productData = productController.productData.value;
    if (productData != null) {
      final productWithCategory = productData.products.firstWhere(
            (product) => product.category.toLowerCase() == category,

      );

      return productWithCategory?.thumbnail ?? 'DEFAULT_IMAGE_URL'; // Replace with a default image URL
    } else {
      return 'DEFAULT_IMAGE_URL'; // Replace with a default image URL
    }
  }

  List<String> getProductCategories() {
    final productData = productController.productData.value;
    if (productData != null) {
      return productData.products
          .map((product) => product.category.toLowerCase())
          .toSet()
          .toList();
    } else {
      return [];
    }
  }
  @override
  Widget build(BuildContext context) {
    List<String> categories = getProductCategories();

    return Container(
      height: 140,
      width: double.infinity,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          final firstImage = getFirstImageForCategory(category);

          return Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(firstImage),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  category,
                  style: AppStyles.subTitle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
