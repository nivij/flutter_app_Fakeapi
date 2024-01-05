
import 'package:flutter/material.dart';
import 'package:flutter_api_project1/src/data/api_fetch/controller.dart';
import 'package:get/get.dart';
import '../../../domain/models/product_model.dart';

class CartListScreen extends StatefulWidget {
  @override
  _CartListScreenState createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final controller = Get.put(HomeController());
  TextEditingController dateRangeController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2019),
                  lastDate: DateTime.now(),
                  initialDateRange: startDate != null && endDate != null
                      ? DateTimeRange(start: startDate!, end: endDate!)
                      : null,
                );
                if (picked != null) {
                  setState(()  {
                    startDate = picked.start;
                    endDate = picked.end;
                    dateRangeController.text =
                    "${picked.start.toLocal()} - ${picked.end.toLocal()}";
                    // Fetch data with the selected date range
                     fetchDataWithDateRange(); // Make sure to await the method
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: dateRangeController,
                  decoration: InputDecoration(
                    labelText: 'Select Date Range',
                    suffixIcon: Icon(Icons.date_range),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Cart>>(
              future: controller.fetchCartData(
                startdate: startDate,
                enddate: endDate,
              ),
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
                  List<Cart>? products = snapshot.data;

                  return ListView.builder(
                    itemCount: products?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: FutureBuilder<List<Product>>(
                          future: controller.fetchData(),
                          builder: (context, productSnapshot) {
                            if (productSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (productSnapshot.hasError) {
                              return Icon(Icons.error);
                            } else {
                              CartProduct cartProduct =
                              products![index].products[0];
                              Product? product = productSnapshot.data?.firstWhere(
                                    (p) => p.id == cartProduct.productId,
                              );

                              if (product != null) {
                                return Image.network(
                                  product.image,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                );
                              } else {
                                return Icon(Icons.error);
                              }
                            }
                          },
                        ),
                        title: Text('Cart ID: ${products![index].id.toString()}'),
                        subtitle: Text('Date: ${products[index].date.toString()}'),
                        // Add more information as needed
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchDataWithDateRange() async {
    try {
      final response = await controller.fetchCartData(
        startdate: startDate,
        enddate: endDate,
      );
      // Update the UI with the filtered data
      // ...
    } catch (e) {
      print('Error fetching data: $e');
      // Handle errors
    }
  }
}
