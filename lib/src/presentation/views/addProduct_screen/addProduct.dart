import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_api_project1/src/data/api_fetch/controller.dart';
import 'package:flutter_api_project1/src/domain/models/product_model.dart';

class AddProduct extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountPercentageController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController thumbnailController = TextEditingController();
  final TextEditingController imagesController = TextEditingController();

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Product Title'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Product Description'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: discountPercentageController,
                decoration: InputDecoration(labelText: 'Discount Percentage'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: ratingController,
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: brandController,
                decoration: InputDecoration(labelText: 'Brand'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: thumbnailController,
                decoration: InputDecoration(labelText: 'Thumbnail URL'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: imagesController,
                decoration: InputDecoration(labelText: 'Images (comma-separated URLs)'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final newProduct = ProductElement(
                    id: 0, // Set the id as needed
                    title: titleController.text,
                    description: descriptionController.text,
                    price: int.parse(priceController.text),
                    discountPercentage: double.tryParse(discountPercentageController.text),
                    rating: double.tryParse(ratingController.text),
                    stock: int.tryParse(stockController.text),
                    brand: brandController.text,
                    category: categoryController.text,
                    thumbnail: thumbnailController.text,
                    images: imagesController.text.split(',').map((e) => e.trim()).toList(),
                  );
                  homeController.addProduct(newProduct);
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
