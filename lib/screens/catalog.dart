import 'package:flutter/material.dart';
import 'package:flutter_application_pro/models/category_model.dart';
import 'package:flutter_application_pro/widgets/navbar.dart';
import 'package:flutter_application_pro/widgets/appbar.dart';

import '../models/product_model.dart';
import '../widgets/product_card.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
        builder: (_) => CatalogScreen(category: category),
        settings: RouteSettings(name: routeName));
  }

  final Category category;

  const CatalogScreen({required this.category});
  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products
        .where((product) => product.category == category.name)
        .toList();

    return Scaffold(
        appBar: CustomAppBar(title: category.name),
        bottomNavigationBar: navbar(),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.15,
          ),
          itemCount: categoryProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: ProductCard.catalog(
                product: categoryProducts[index],
                widthFactor: 2.2,
                leftPosition: 100,
              ),
            );
          },
        ));
  }
}
