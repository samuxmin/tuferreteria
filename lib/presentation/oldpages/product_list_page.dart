import 'package:flutter/material.dart';
import 'package:ferreteria/controller/controller.dart';
import 'package:ferreteria/models/producto.dart';
import 'package:ferreteria/presentation/oldpages/product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final Controller _controller = Controller();
  late Future<List<Producto>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _controller.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: FutureBuilder<List<Producto>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay productos disponibles.'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetailPage(productId: product.id!),
                    ));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(product.imagen ?? 'https://placeholder.com/150', height: 100),
                        Text(product.nombre ?? ''),
                        Text('\$${product.precio?.toStringAsFixed(2) ?? '0.00'}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}