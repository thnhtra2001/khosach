import 'package:flutter/material.dart';

import 'cart_item.dart';

class OrderItem {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final int totalQuantity;
  final String name;
  final String phone;
  final String address;
  final String payResult;
  final String customerId;

  int get productCount {
    return products.length;
  }

  OrderItem({
    this.id,
    required this.amount,
    required this.products,
    required this.name,
    required this.phone,
    required this.address,
    required this.payResult,
    required this.customerId,
    required this.totalQuantity,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
    String? name,
    String? phone,
    String? address,
    String? payResult,
    String? customerId,
    int? totalQuantity,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      payResult: payResult ?? this.payResult,
      customerId: customerId ?? this.customerId,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }
}
