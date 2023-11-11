import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../cart/cart_manager.dart';
import '../cart/cart_screen.dart';
import 'products_grid.dart';

// import '../cart/cart_manager.dart';
import 'products_manager.dart';
import 'top_right_badge.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
    // print('=========================');
    // print(_fetchProducts.toString().length);
    // print('=========================');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shop cây cảnh'),
          actions: <Widget>[
            buildShoppingCartIcon(),
          ],
        ),
        body: FutureBuilder(
          future: _fetchProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
                    return ProductsGrid();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (context, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart)),
        );
      },
    );
  }
}