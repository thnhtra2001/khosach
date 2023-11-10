import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_grid_tile.dart';
import 'products_manager.dart';
import '../../models/product.dart';

class ProductsGrid extends StatelessWidget {

  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // doc ra list<product> se duoc hien thi tu productsmanager
    // final products = context.select<ProductsManager, List<Product>>(
    //     (productsManager) =>productsManager.items);
    final productsManager = ProductsManager();
        final products = productsManager.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGridTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
