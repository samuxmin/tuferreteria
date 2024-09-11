import 'package:ferreteria/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:ferreteria/controller/controller.dart';
import 'package:ferreteria/models/producto.dart';
import 'package:ferreteria/presentation/pages/edit_product_page.dart';
import 'package:ferreteria/presentation/pages/order_history_page.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  final bool isAdmin; // Para identificar si el usuario es admin

  const ProductDetailPage({
    super.key,
    required this.productId,
    required this.isAdmin,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  late Future<Producto?> _productFuture;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context); // Obtiene el controlador de Provider

    _productFuture = controller.getProduct(widget.productId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
        actions: [
          if (widget.isAdmin) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _productFuture.then((product) {
                  if (product != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProductPage(product: product),
                      ),
                    );
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryPage(),
                  ),
                );
              },
            ),
          ],
        ],
      ),
      body: FutureBuilder<Producto?>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontró el producto.'));
          } else {
            final product = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.imagen ?? 'https://placeholder.com/300',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.nombre ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.precio?.toStringAsFixed(2) ?? '0.00'}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Stock: ${product.stock}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.descripcion ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[800],
                        ),
                  ),
                  const SizedBox(height: 24),
                  if (!widget.isAdmin) ...[
                    Row(
                      children: [
                        Text(
                          'Cantidad:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          color: Colors.blue[800],
                        ),
                        Text(
                          '$quantity',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            if (quantity < product.stock!) {
                              setState(() {
                                quantity++;
                              });
                            }
                          },
                          color: Colors.blue[800],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$quantity producto(s) añadido(s) al carrito'),
                            ),
                          );
                          // Lógica para añadir al carrito
                          controller.addToCart(CartItem(product:product, quantity: quantity));
                        },
                        child: const Text('Añadir al carrito', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
