import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_project1/src/presentation/views/curd_operations/Add_product.dart';
import 'package:flutter_api_project1/src/presentation/views/curd_operations/List_of_all_products.dart';
import 'package:flutter_api_project1/src/presentation/views/curd_operations/Specific_category.dart';
import 'package:flutter_api_project1/src/presentation/views/curd_operations/filteration.dart';
import 'package:flutter_api_project1/src/presentation/views/curd_operations/update_product.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => Get.to(ProductListScreen()),
                child: Text("list of products")),

            ElevatedButton(onPressed: () => Get.to(Category_page()),
                child: Text("Category")),


            ElevatedButton(onPressed: () => Get.to(filteration()),
                child: Text("filteration")),



            ElevatedButton(onPressed: () => Get.to(AddProductForm()),
                child: Text("Add product")),


               ElevatedButton(onPressed: () => Get.to(updateProductForm()),
                child: Text("update")),


          ],
        ),
      ),
    );

  }
}
