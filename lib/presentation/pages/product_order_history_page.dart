import 'package:ferreteria/models/order.dart';
import 'package:ferreteria/models/order_item.dart';
import 'package:ferreteria/models/product.dart';
import 'package:flutter/material.dart';
import 'package:ferreteria/presentation/pages/order_detail_page.dart';
import 'package:ferreteria/controller/controller.dart';
import 'package:provider/provider.dart';

class ProductOrderHistoryPage extends StatefulWidget {
  final Product product;
  const ProductOrderHistoryPage({super.key, required this.product});

  @override
  State<ProductOrderHistoryPage> createState() => _ProductOrderHistoryPageState();
}

class _ProductOrderHistoryPageState extends State<ProductOrderHistoryPage> {
  late Future<List<OrderItem>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<Controller>(context, listen: false);
    _ordersFuture = controller.getProductOrders(widget.product.id); // Obtiene las órdenes del producto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Compras'),
      ),
      body: FutureBuilder<List<OrderItem>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay órdenes disponibles.'));
          } else {
            final orderItems = snapshot.data!;

            return ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                final orderItem = orderItems[index];
                final product = widget.product;

                return ListTile(
                  title: Text('ID Orden: ${orderItem.orderId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Producto: ${product.name}'),
                      Text('Cantidad: ${orderItem.quantity} * \$${product.price.toStringAsFixed(2)}'),
                      Text('Total: \$${(orderItem.purchaseUnitPrice * orderItem.quantity).toStringAsFixed(2)}'),
                      FutureBuilder<Order?>(
                        future: Provider.of<Controller>(context, listen: false).getOrderDetails(orderItem.orderId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text('Cargando usuario...');
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return const Text('Error al cargar usuario.');
                          } else {
                            final order = snapshot.data!;
                            return Text('Cliente: ${order.clientName}'); // Mostramos el nombre del cliente
                          }
                        },
                      ),
                    ],
                  ),
                  trailing: Text('\$${(product.price * orderItem.quantity).toStringAsFixed(2)}'),
                  onTap: () async {
                    // Obtener la orden completa usando el orderId
                    final controller = Provider.of<Controller>(context, listen: false);
                    final Order? order = await controller.getOrderDetails(orderItem.orderId);

                    // Navegar a la página de detalles de la orden
                    if (order != null) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderDetailPage(order: order),
                      ));
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
