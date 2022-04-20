import 'package:flutter/material.dart';
import 'package:prueba_mi_aguila/products/widgets/carrito.dart';
import 'package:prueba_mi_aguila/products/widgets/top_bar.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.price})
      : super(key: key);

  final String title;
  final String description;
  final String image;
  final String price;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late double _deviceHeight;

  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      endDrawer: Carrito(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(
              title: widget.title,
            ),
            _infoProduct()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ElevatedButton(
            onPressed: () {}, child: const Text('Añadir al Carrito')),
      ),
    );
  }

  Widget _infoProduct() {
    return SizedBox(
      height: _deviceHeight,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageContainer(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.07,
                vertical: _deviceHeight * 0.03),
            child: Text(
              widget.description,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.07,
                vertical: _deviceHeight * 0.07),
            child: Text(
              '\$ ${widget.price}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
            ),
          ),
        ],
      ),
    );
  }

  _imageContainer() {
    return Hero(
      tag: widget.image,
      child: Container(
        height: _deviceHeight / 3,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.image), fit: BoxFit.contain)),
      ),
    );
  }
}
