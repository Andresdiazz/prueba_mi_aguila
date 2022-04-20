import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';
import '../providers/products_provider.dart';

class Carrito extends StatefulWidget {
  const Carrito({Key? key}) : super(key: key);

  @override
  State<Carrito> createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  late double _deviceHeight;

  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Drawer(
      elevation: 20,
      child: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _deviceHeight * 0.06, horizontal: _deviceWidth * 0.03),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Pagar'),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: SvgPicture.asset('assets/images/logo.svg')),
                  const Divider(),
                  const Text(
                    'Tu carrito de compras',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Flexible(child: _productsList()),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: _deviceHeight * 0.07),
                      child: productsProvider.itemsToShop!.isEmpty
                          ? const SizedBox.shrink()
                          : TextButton(
                              onPressed: () {
                                productsProvider.deleteAll();
                              },
                              child: const Text(
                                'Elimina todos los items',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productsList() {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return FutureBuilder(
      future: productsProvider.getProductsInCar(),
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
              leading: Image.network(
                product.image,
                height: 20,
                width: 20,
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  productsProvider.deleteItem(
                    product.id,
                    product.title,
                    product.price,
                    product.description,
                    product.image,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
