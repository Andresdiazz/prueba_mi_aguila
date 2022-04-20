import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mi_aguila/products/providers/products_provider.dart';
import 'package:prueba_mi_aguila/products/widgets/carrito.dart';
import 'package:prueba_mi_aguila/products/widgets/top_bar.dart';

import '../models/products.dart';
import 'product_detail.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
        endDrawer: const Carrito(),
        body: Column(
          children: [
            const TopBar(
              image: 'assets/images/logo.svg',
            ),
            Flexible(child: _productsList())
          ],
        ));
  }

  Widget _productsList() {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return FutureBuilder(
      future: productsProvider.getProducts(),
      builder: (_, AsyncSnapshot<List<Products>>? snapshot) {
        if (snapshot!.hasData) {
          final products = snapshot.data;
          return ListView.builder(
              itemCount: products!.length,
              itemBuilder: (_, int i) {
                return _card(products[i]);
              });
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _card(Products product) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Card(
            elevation: 3,
            child: ListTile(
              title: Text(
                product.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                product.description,
                overflow: TextOverflow.ellipsis,
              ),
              leading: Hero(
                tag: product.image,
                child: Image.network(
                  product.image,
                  height: 50,
                  width: 50,
                ),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${product.price.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      log(product.id.toString());
                      productsProvider.addToCar(product.id, product.title,
                          product.price, product.description, product.image);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              Theme.of(context).colorScheme.copyWith().primary),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ProductDetail(
                            title: product.title,
                            description: product.description,
                            image: product.image,
                            price: product.price.toString(),
                          ))),
            ),
          ),
        ),
      ],
    );
  }
}
