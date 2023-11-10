import '../../models/product.dart';

// import '../../models/auth_token.dart';
import '../../models/product.dart';
// import '../../services/products_service.dart';

import 'package:flutter/foundation.dart';

class ProductsManager with ChangeNotifier {
    final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // Future<void> fetchProducts([bool filterByUser = false]) async {
  //   _items = await _productsService.fetchProducts(filterByUser);
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) async {
    // final newProduct = await _productsService.addProduct(product);
    // if (newProduct != null) {
      _items.add(product);
      notifyListeners();
    // }
  }

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }
  Product? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async{
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
  }

  // Future<void> updateProduct(Product product) async {
  //   final index = _items.indexWhere((item) => item.id == product.id);
  //   if (index >= 0) {
  //     if (await _productsService.updateProduct(product)) {
  //       _items[index] = product;
  //       notifyListeners();
  //     }
  //   }
  // }

  // Future<void> deleteProduct(String id) async {
  //   final index = _items.indexWhere((item) => item.id == id);
  //   Product? exitstingProduct = _items[index];
  //   _items.removeAt(index);
  //   notifyListeners();

  //   if (!await _productsService.deleteProduct(id)) {
  //     _items.insert(index, exitstingProduct);
  //     notifyListeners();
  //   }
  // }

  // Future<void> toggleFavoriteStatus(Product product) async {
  //   final savedStatus = product.isFavorite;
  //   product.isFavorite = !savedStatus;

  //   if (!await _productsService.saveFavoriteStatus(product)) {
  //     product.isFavorite = savedStatus;
  //   }
  // }
}
