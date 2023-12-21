import 'package:flutter/material.dart';
import 'package:flutter_api_project1/src/presentation/views/Home/widgets/price_tag.dart';

class ProductGridItem extends StatelessWidget {
  final String thumbnail;
  final double price;

  const ProductGridItem({Key? key, required this.thumbnail, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 20,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(thumbnail),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              child: SizedBox(
                height: 20,
                width: 70,
                child: CustomPaint(
                  painter: PriceTagPaint(),
                  child: Center(
                    child: Text(
                      '\$ ${price}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
