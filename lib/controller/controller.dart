import 'package:dio/dio.dart';
import 'package:ferreteria/models/login_response.dart';
import 'package:ferreteria/models/producto.dart';
import 'package:ferreteria/models/order.dart';
import 'package:ferreteria/models/cart_item.dart';

class Controller {
  bool admin = false;
/*

  final Dio _dio = Dio();
  static const String _baseUrl = "https://backend/api";

  // Productos
  Future<List<Producto>> getProducts() async {
    try {
      final response = await _dio.get('$_baseUrl/products');
      return (response.data as List).map((item) => Producto.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<Producto?> getProduct(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/products/$id');
      return Producto.fromJson(response.data);
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }

  Future<void> addProduct(Producto product) async {
    try {
      await _dio.post('$_baseUrl/products', data: product.toJson());
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Producto product) async {
    try {
      await _dio.put('$_baseUrl/products/${product.id}', data: product.toJson());
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dio.delete('$_baseUrl/products/$id');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  // Órdenes
  Future<List<Order>> getOrders() async {
    try {
      final response = await _dio.get('$_baseUrl/orders');
      return (response.data as List).map((item) => Order.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }

  Future<Order?> getOrderDetails(String orderId) async {
    try {
      final response = await _dio.get('$_baseUrl/orders/$orderId');
      return Order.fromJson(response.data);
    } catch (e) {
      print('Error fetching order details: $e');
      return null;
    }
  }

  // Carrito
  Future<List<CartItem>> getCartItems() async {
    try {
      final response = await _dio.get('$_baseUrl/cart');
      return (response.data as List).map((item) => CartItem.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching cart items: $e');
      return [];
    }
  }

  Future<void> addToCart(CartItem item) async {
    try {
      await _dio.post('$_baseUrl/cart', data: item.toJson());
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<void> updateCartItem(CartItem item) async {
    try {
      await _dio.put('$_baseUrl/cart/${item.name}', data: item.toJson());
    } catch (e) {
      print('Error updating cart item: $e');
    }
  }

  Future<void> removeFromCart(String itemName,int amount) async {
    try {
      await _dio.post('$_baseUrl/cart/$itemName/remove', data:{amount});
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  // Autenticación
  Future<void> register(String email, String password) async {
    try {
      await _dio.post('$_baseUrl/register', data: {'email': email, 'password': password});
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post('$_baseUrl/login', data: {'email': email, 'password': password});
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      print('Error logging in: $e');
      return LoginResponse(logged: false, token: "", isAdmin: false);
    }
  }*/
  //* EMPIEZA EL MOCK

  Future<bool> isAdmin() async {
    return admin;
  }

  List<Producto> productos = [
    Producto(
        id: 1,
        descripcion: "prod1",
        imagen:
            "https://cdn.discordapp.com/avatars/842525351698890752/98c10f1dc07badde3903e271e7f35131.png?size=1024",
        nombre: "prod1",
        precio: 12.5,
        stock: 10),
    Producto(
        id: 2,
        descripcion: "prod2",
        imagen:
            "https://cdn.discordapp.com/avatars/842525351698890752/98c10f1dc07badde3903e271e7f35131.png?size=1024",
        nombre: "prod2",
        precio: 12.5,
        stock: 12),
    Producto(
        id: 3,
        descripcion: "prod3",
        imagen:
            "https://cdn.discordapp.com/avatars/842525351698890752/98c10f1dc07badde3903e271e7f35131.png?size=1024",
        nombre: "prod3",
        precio: 12.5,
        stock: 13),
    Producto(
        id: 4,
        descripcion: "prod4",
        imagen:
            "https://cdn.discordapp.com/avatars/842525351698890752/98c10f1dc07badde3903e271e7f35131.png?size=1024",
        nombre: "prod4",
        precio: 12.5,
        stock: 14)
  ];

  List<CartItem> cartItemsMock = [
    CartItem(
        product: Producto(
            id: 1,
            descripcion: "prod1",
            imagen:
                "https://cdn.discordapp.com/avatars/842525351698890752/98c10f1dc07badde3903e271e7f35131.png?size=1024",
            nombre: "prod1",
            precio: 12.5,
            stock: 10),
        quantity: 1),
    CartItem(
        product: Producto(
            id: 4,
            descripcion: "prod4",
            imagen:
                "https://cdn.discordapp.com/avatars/842525351698890752/98c10f1dc07badde3903e271e7f35131.png?size=1024",
            nombre: "prod4",
            precio: 12.5,
            stock: 14),
        quantity: 5),
  ];

  List<Order> mockOrders = [
    Order(
        id: '1',
        clientName: 'Nombre de Cliente 3',
        date: '31/08/2024',
        quantity: 2,
        totalAmount: 24.00,
        products: List.empty()),
    Order(
        id: '2',
        clientName: 'Nombre de Cliente 2',
        date: '31/08/2024',
        quantity: 2,
        totalAmount: 24.00,
        products: List.empty()),
    Order(
        id: '3',
        clientName: 'Nombre de Cliente 1',
        date: '31/08/2024',
        quantity: 2,
        totalAmount: 24.00,
        products: List.empty())
  ];

  // Productos
  Future<List<Producto>> getProducts() async {
    return productos;
  }

  Future<Producto?> getProduct(int id) async {
    return productos.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Producto product) async {
    product.id = productos.length;
    print("nuevo producto: ${product.id}");

    productos.add(product);
    productos.forEach((Producto p) {
      print(p.nombre);
    });
  }

  Future<void> updateProduct(Producto product) async {
    final index = productos.indexWhere((element) => element.id == product.id);
    productos[index] = product;
  }

  Future<void> deleteProduct(int id) async {
    productos.removeWhere((element) => element.id == id);
  }

  // Órdenes
  Future<List<Order>> getOrders() async {
    return mockOrders.toList();
  }

  Future<Order?> getOrderDetails(String orderId) async {
    return mockOrders.firstWhere((element) => element.id == orderId);
  }

  // Carrito
  Future<List<CartItem>> getCartItems() async {
    return cartItemsMock;
  }

  Future<void> addToCart(CartItem item) async {
    cartItemsMock.add(item);
    print('Adding to cart: ${item.product.nombre}');
  }

  Future<void> updateCartItem(CartItem item) async {
    cartItemsMock[cartItemsMock
        .indexWhere((element) => element.product.nombre == item.product.nombre)] = item;
    print('Updating cart item: ${item.product.nombre}');
  }

  Future<void> removeFromCart(String itemName, int amount) async {
    cartItemsMock.removeWhere((element) => element.product.nombre == itemName);
    print('Removing from cart: $itemName');
  }

  // Autenticación
  Future<void> register(String email, String password) async {
    // TODO implementar
  }

  Future<LoginResponse> login(String email, String password) async {
    //! siempre retorna true
    if (email == 'admin') {
      admin = true;
      return LoginResponse(logged: true, token: ' token', isAdmin: true);
    } else {
      admin = false;
      return LoginResponse(logged: true, token: 'token', isAdmin: false);
    }
  }
}
