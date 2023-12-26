import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'home_vieww.dart';


void main() {

  runApp(myApp());
}
class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'cart api',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: DashBoard(),
    );
  }
}
