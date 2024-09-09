import 'package:ferreteria/controller/controller.dart';
import 'package:ferreteria/models/producto.dart';
import 'package:ferreteria/presentation/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:ferreteria/presentation/widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final Controller _controller = Controller();
  late Future<List<Producto>> _productsFuture;
  late Future<bool> _isAdminFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _controller.getProducts();
    _isAdminFuture = _controller.isAdmin();  // Cambia según sea admin o no
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Ferretería'),
        actions: [
          FutureBuilder<bool>(
            future: _isAdminFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && !snapshot.data!) {
                return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.history),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/order_history');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/cart');
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();  // Evita retornar null
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Producto>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar los productos.'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay productos disponibles.'));
                } else if (snapshot.hasData) {
                  final products = snapshot.data!;
                  return FutureBuilder<bool>(
                    future: _isAdminFuture, // Obtener isAdmin aquí
                    builder: (context, adminSnapshot) {
                      if (adminSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (adminSnapshot.hasError) {
                        return const Center(child: Text('Error al verificar permisos de administrador.'));
                      } else if (adminSnapshot.hasData) {
                        final isAdmin = adminSnapshot.data!; // Obtener el valor de isAdmin
                        return GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              name: product.nombre ?? 'Sin nombre',
                              price: product.precio ?? 0.00,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    productId: product.id!,
                                    isAdmin: isAdmin, // Pasar isAdmin aquí
                                  ),
                                ));
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('Error al cargar la información de administrador.'));
                      }
                    },
                  );
                } else {
                  return const Center(child: Text('No hay productos disponibles.'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<bool>(
        future: _isAdminFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox.shrink();  // No muestra el botón mientras carga
          } else if (snapshot.hasData && snapshot.data!) {
            return FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/new_product');
              },
            );
          } else {
            return const SizedBox.shrink();  // No muestra el botón si no es admin
          }
        },
      ),
    );
  }
}
