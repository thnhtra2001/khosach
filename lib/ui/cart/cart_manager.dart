import 'package:flutter/material.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';
import 'package:flutter/foundation.dart';

class CartManager with ChangeNotifier {
  Map<String, CartItem> _items = {};
  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get totalQuantity {
    var totalQuantity = 0;
    _items.forEach((key, cartItem) {
      totalQuantity += cartItem.quantity;
    });
    return totalQuantity;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      //change quantity...
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
            id: 'c${DateTime.now().toIso8601String()}',
            title: product.title,
            price: product.price,
            imageUrl: product.imageUrl,
            quantity: 1,
            category: product.category,
            author: product.author,
            language: product.language,
            coutry: product.coutry),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity as num > 1) {
      _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
