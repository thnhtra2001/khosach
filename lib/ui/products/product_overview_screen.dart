import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../cart/cart_manager.dart';
import '../cart/cart_screen.dart';
import 'products_grid.dart';

// import '../cart/cart_manager.dart';
import 'products_manager.dart';
import 'search_product.dart';
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
    print('=========================');
    print(_fetchProducts.toString().length);
    print('=========================');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BOOKSTORE'),
          actions: <Widget>[
            searchProduct()
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
        ),
              floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Heloo");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.message),
      ),
        );
  }

  Widget searchProduct() {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SearchScreen.routeName);
          print("hello");
        },
        icon: const Icon(Icons.search));
  }
}