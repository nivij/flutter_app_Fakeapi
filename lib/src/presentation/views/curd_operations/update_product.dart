import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api_fetch/controller.dart';
import '../../../domain/models/product_model.dart'; // Make sure to import Get package

class updateProductForm extends StatefulWidget {
  @override
  _updateProductFormState createState() => _updateProductFormState();
}
class _updateProductFormState extends State<updateProductForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController idController = TextEditingController();

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
              controller: idController,
              decoration: InputDecoration(labelText: 'id'),
            ),TextFormField(
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
            DropdownButtonFormField<Category>(
              value: _selectedCategory,
              items: Category.values.map((category) {
                return DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.toString().split('.').last),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Category'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async{
            if (priceController.text.isEmpty) {
              // Handle the case where the price is not provided
              return;
            }

            final updatedProduct = Product(
              id: int.parse(idController.text),
              title: titleController.text,
              price: double.parse(priceController.text),
              description: descriptionController.text,
              image: imageController.text,
              category: _selectedCategory,
              rating: Rating(rate: 0.0, count: 0),
            );

            await Get.find<HomeController>().updateProduct(int.parse(idController.text), updatedProduct);

            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }

}