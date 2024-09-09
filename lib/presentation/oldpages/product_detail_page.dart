import 'package:flutter/material.dart';
import 'package:ferreteria/controller/controller.dart';
import 'package:ferreteria/models/producto.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final Controller _controller = Controller();
  late Future<Producto?> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = _controller.getProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
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
                  Image.network(product.imagen ?? 'https://placeholder.com/300'),
                  const SizedBox(height: 16),
                  Text(product.nombre ?? '', style: Theme.of(context).textTheme.titleLarge),
                  Text('\$${product.precio?.toStringAsFixed(2) ?? '0.00'}', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Text(product.descripcion ?? ''),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}