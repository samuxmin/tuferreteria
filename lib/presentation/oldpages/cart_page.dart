import 'package:flutter/material.dart';
import 'package:ferreteria/models/cart_item.dart';
import 'package:ferreteria/controller/controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Controller _controller = Controller();
  late Future<List<CartItem>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _cartItemsFuture = _controller.getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: FutureBuilder<List<CartItem>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('El carrito está vacío.'));
          } else {
            final cartItems = snapshot.data!;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('${item.variant} - \$${item.price.toStringAsFixed(2)}'),
                  trailing: Text('x${item.quantity}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}