import 'package:flutter/material.dart';
import 'package:ferreteria/controller/controller.dart';
import 'package:ferreteria/models/order.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;

  const OrderDetailPage({super.key, required this.orderId});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final Controller _controller = Controller();
  late Future<Order?> _orderFuture;

  @override
  void initState() {
    super.initState();
    _orderFuture = _controller.getOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden #${widget.orderId}'),
      ),
      body: FutureBuilder<Order?>(
        future: _orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontró la orden.'));
          } else {
            final order = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Cliente: ${order.clientName}'),
                Text('Fecha: ${order.date}'),
                Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                const SizedBox(height: 16),
                const Text('Productos:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...order.products.map((product) => ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.variant),
                  trailing: Text('x${product.quantity}'),
                )),
              ],
            );
          }
        },
      ),
    );
  }
}