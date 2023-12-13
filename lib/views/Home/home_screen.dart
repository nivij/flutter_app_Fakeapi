// Import necessary packages and files
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_project1/views/Home/widgets/carousel_slider.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/text_font.dart';
import '../../product_model.dart';
import 'controler/homecontroller.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          physics: PageScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
          [
            SliverAppBar(

              toolbarHeight: 80,

              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              floating: true,
              snap: true,
              pinned: true,

              title:
              Text.rich(TextSpan(text: "Reng",
                  style:  AppStyles.appBarTitle,
                  children: [
                    TextSpan(text: "vo",style: GoogleFonts.poppins(color: Colors.orange))
                  ])
              ),
              actions: [
                Icon(CupertinoIcons.qrcode_viewfinder,color: Colors.black,size: 30),
                SizedBox(width: 30,),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(CupertinoIcons.conversation_bubble,color: Colors.black,size: 30,),
                )
              ],
              bottom: PreferredSize(

                preferredSize: Size.fromHeight(60),
                child: SizedBox(
                  height: 60,
                  width: 320,
                  child: Bounceable(
                    onTap: () {
                      // Get.to(SearchScreen());
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.1)
                          ),
                          color: Colors.white24
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:
                        ListTile(
                          leading:  Icon(
                            Elusive.search_circled,
                            color: Colors.black.withOpacity(0.4),
                            size: 30,
                          ),
                          title:  Text(
                            "Search for products",
                            style: GoogleFonts.poppins(
                              color:Colors.black.withOpacity(0.4),
                              fontSize: 15,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 30,
                                child: VerticalDivider(
                                  color: Colors.black.withOpacity(0.4),
                                  thickness: 1.5,
                                  width: 20,
                                ),
                              ),

                              Bounceable(
                                onTap: () {},
                                child: Image.asset(
                                  "assets/filter.png",
                                  color:Colors.black.withOpacity(0.4),
                                  height: 30,
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),


              ),
            )
          ],
          body: Obx(
                () {
              final productData = productController.productData.value;
              if (productData != null) {
                List<ProductElement> smartphoneProducts = productData.products
                    .where((product) => product.category.toLowerCase() == 'smartphones')
                    .toList();

                List<String> imageUrls = smartphoneProducts
                    .map((product) => product.thumbnail)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      CustomCarouselSlider(
                        imageUrls: imageUrls,
                        onPageChanged: (index, reason) {
}
                      ),
                      ListTile(
                        leading: Text("Collections", style: AppStyles.subTitle),
                        trailing: Text("Show all", style: AppStyles.subTitle.copyWith(color: Colors.orange)),
                      ),


                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
