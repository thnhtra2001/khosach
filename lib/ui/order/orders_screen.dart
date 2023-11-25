import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import 'order_detail_screen.dart';
import 'order_item_card.dart';
import 'order_manager.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = OrdersManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ĐƠN HÀNG'),
      ),
      body: 
                Consumer<OrdersManager>(
                  builder: (ctx, ordersManager, child) {
                    return ListView.builder(
                        itemCount: ordersManager.orderCount,
                        itemBuilder: (ctx, i) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderDetailScreen(
                                          ordersManager.orders[i])),
                                );
                              },
                              child: OrderItemCard(ordersManager.orders[i]),
                            ));
                  },
                )
          );
        }
      
    
  }

