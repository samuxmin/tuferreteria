import 'package:ferreteria/models/cart_item.dart';

class Order {
  final String id;
  final String clientName;
  final String date;
  final int quantity;
  final double totalAmount;
  final List<CartItem> products;

  Order({
    required this.id,
    required this.clientName,
    required this.date,
    required this.quantity,
    required this.totalAmount,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      clientName: json['clientName'],
      date: json['date'],
      quantity: json['quantity'],
      totalAmount: json['totalAmount'],
      products: (json['products'] as List<dynamic>?)
          ?.map((item) => CartItem.fromJson(item))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'date': date,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'products': products.map((item) => item.toJson()).toList(),
    };
  }
}