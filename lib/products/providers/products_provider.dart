import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prueba_mi_aguila/products/services/products_service.dart';

import '../models/products.dart';

class ProductsProvider extends ChangeNotifier {
  late ProductsService _productsService;

  List<Products>? products;

  late List<Products>? itemsToShop;

  late StreamSubscription streamSubscription;

  ProductsProvider() {
    _productsService = Get.find<ProductsService>();
    getProducts();
    itemsToShop = [];
  }

  Future<List<Products>>? getProducts() async {
    if (products != null) {
      return products!;
    }
    products = await _productsService.getProducts();

    notifyListeners();
    return products!;
  }

  Future<List<Products>>? refreshProducts() async {
    products = await _productsService.getProducts();

    notifyListeners();
    return products!;
  }

  Future<List<Products>>? getProductsInCar() async {
    if (itemsToShop != null) {
      return itemsToShop!;
    }

    notifyListeners();
    return itemsToShop!;
  }

  void addToCar(
      int id, String title, double price, String description, String image) {
    itemsToShop!.add(
      Products(
        id: id,
        title: title,
        price: price,
        description: description,
        image: image,
      ),
    );
    print(itemsToShop!.length);
  }

  void deleteItem(
      int id, String title, double price, String description, String image) {
    itemsToShop!.remove(Products(
        id: id,
        title: title,
        price: price,
        description: description,
        image: image));
  }

  void deleteAll() {
    itemsToShop!.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription.cancel();
    super.dispose();
  }
}
