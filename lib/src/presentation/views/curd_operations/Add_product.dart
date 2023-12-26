import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api_fetch/controller.dart';
import '../../../domain/models/product_model.dart'; // Make sure to import Get package

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  Category _selectedCategory = Category.ELECTRONICS;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextFormField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Category selectedCategory = _parseCategory(categoryController.text);
            final newProduct = Product(
              id: 0,
              title: titleController.text,
              price: double.parse(priceController.text),
              description: descriptionController.text,
              image: imageController.text,
              category: selectedCategory,
              rating: Rating(rate: 0.0, count: 0),
            );

            // Call the addProduct function to add the new product
            Get.find<HomeController>().addProduct(newProduct);

            // Close the form
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
  Category _parseCategory(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return Category.ELECTRONICS;
      case 'jewelry':
        return Category.JEWELRY;
      case 'men\'s clothing':
        return Category.MEN_S_CLOTHING;
      case 'women\'s clothing':
        return Category.WOMEN_S_CLOTHING;
      default:
      // Provide a default value or handle the error as needed
        return Category.ELECTRONICS;
    }
  }
}
