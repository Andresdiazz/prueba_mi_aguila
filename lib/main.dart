import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_mi_aguila/products/services/navigation_service.dart';
import 'package:prueba_mi_aguila/products/services/products_service.dart';

import 'src/my_app.dart';

void main() {
  Get.put<ProductsService>(ProductsService());
  Get.put<NavigationService>(NavigationService());
  runApp(const MyApp());
}
