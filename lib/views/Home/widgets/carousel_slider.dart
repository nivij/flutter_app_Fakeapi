import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<String> imageUrls;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  CustomCarouselSlider({required this.imageUrls, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            return Image.network(
              imageUrls[index],
              fit: BoxFit.fill,
            );
          },
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
            onPageChanged: onPageChanged != null
                ? (index, reason) => onPageChanged!(index, reason!)
                : null,
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageUrls.length,
                (index) => Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 0 ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
