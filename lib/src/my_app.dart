import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_mi_aguila/products/providers/products_provider.dart';
import 'package:prueba_mi_aguila/products/screens/products_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductsProvider())],
      child: MaterialApp(
        title: 'Shop App Mi Aguila',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: const Color(0xff0a0040)),
        ),
        home: const ProductsPage(),
      ),
    );
  }
}
