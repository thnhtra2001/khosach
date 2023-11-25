import 'package:flutter/widgets.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';

import 'package:flutter/foundation.dart';

class OrdersManager with ChangeNotifier {
  final List<OrderItem> _orders = [
  ];
  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(OrderItem order) async {
    // final newOrder = await _orderService.addOrder(order);
    // if (newOrder != null) {
      _orders.insert(0, order);
      // _orders.add(newOrder);
      notifyListeners();
    }
  // }
}
