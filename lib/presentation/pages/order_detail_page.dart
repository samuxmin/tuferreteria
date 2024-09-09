import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;

  OrderDetailPage({super.key, required this.orderId});

  // Mock data for the order
  final Map<String, dynamic> orderDetails = {
    'id': '1234',
    'date': '31/08/2024',
    'products': [
      {
        'name': 'Producto 1',
        'variant': 'Black / M',
        'quantity': 1,
        'unitPrice': 12.00,
      },
      {
        'name': 'Producto 2',
        'variant': 'Blue / 42',
        'quantity': 5,
        'unitPrice': 3.00,
      },
      {
        'name': 'Producto 3',
        'variant': 'Gold / L',
        'quantity': 1,
        'unitPrice': 20.00,
      },
      {
        'name': 'Producto 4',
        'variant': 'Blue / M',
        'quantity': 3,
        'unitPrice': 6.00,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    int totalProducts = orderDetails['products'].length;
    double totalAmount = orderDetails['products'].fold(0, (sum, product) => sum + (product['quantity'] * product['unitPrice']));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Orden #${orderDetails['id']}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '$totalProducts Productos',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Fecha: ${orderDetails['date']}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ...orderDetails['products'].map<Widget>((product) => _buildProductItem(product)).toList(),
          const SizedBox(height: 24),
          const Divider(thickness: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.image, size: 40, color: Colors.blue[200]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  product['variant'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '${product['quantity']} x \$${product['unitPrice'].toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          Text(
            '\$${(product['quantity'] * product['unitPrice']).toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}