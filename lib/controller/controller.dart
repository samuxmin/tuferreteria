import 'package:dio/dio.dart';
import 'package:ferreteria/models/login_response.dart';
import 'package:ferreteria/models/order_item.dart';
import 'package:ferreteria/models/product.dart';
import 'package:ferreteria/models/order.dart';
import 'package:ferreteria/models/cart_item.dart';
import 'package:ferreteria/models/user.dart';
import 'package:flutter/material.dart';

class Controller with ChangeNotifier {
  bool admin = false;
  User loggedUser = User(id: 0, email: '', name: '' ,password: '');
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
  String randomImageApi =   "https://random.imagecdn.app/500/500";
  List<Product> productos = [
    Product(
        id: 1,
        description: "prod1",
        image:
            "https://random.imagecdn.app/500/500",
        name: "prod1",
        price: 12.5,
        stock: 10),
    Product(
        id: 2,
        description: "prod2",
        image:
            "https://random.imagecdn.app/500/500",
        name: "prod2",
        price: 12.5,
        stock: 12),
    Product(
        id: 3,
        description: "prod3",
        image:
            "https://random.imagecdn.app/500/500",
        name: "prod3",
        price: 12.5,
        stock: 13),
    Product(
        id: 4,
        description: "prod4",
        image:
            "https://random.imagecdn.app/500/500",
        name: "prod4",
        price: 12.5,
        stock: 14)
  ];

  List<CartItem> cartItemsMock = [
    CartItem(
        product: Product(
            id: 1,
            description: "prod1",
            image:
                "https://random.imagecdn.app/500/500",
            name: "prod1",
            price: 12.5,
            stock: 10),
        quantity: 1),
    CartItem(
        product: Product(
            id: 4,
            description: "prod4",
            image:
                "https://random.imagecdn.app/500/500",
            name: "prod4",
            price: 12.5,
            stock: 14),
        quantity: 5),
  ];

  List<Order> orders = [
    Order(id: 0, clientId: 0, clientName: "clientName", date: "date", quantity: 1, totalAmount: 123, products: [
      CartItem(
          product: Product(
              id: 1,
              description: "prod1",
              image:
                  "https://random.imagecdn.app/500/500",
              name: "prod1",
              price: 12.5,
              stock: 10),
          quantity: 1),
      CartItem(
          product: Product(
              id: 4,
              description: "prod4",
              image:
                  "https://random.imagecdn.app/500/500",
              name: "prod4",
              price: 12.5,
              stock: 14),
          quantity: 5),
    ]),
  ];

  // Productos
  Future<List<Product>> getProducts() async {
    return productos;
  }

  Future<Product?> getProduct(int id) async {
    return productos.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {
    product.id = productos.length + 1;
    print("nuevo producto: ${product.id}");

    productos.add(product);
    productos.forEach((Product p) {
      print(p.name);
    });
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final index = productos.indexWhere((element) => element.id == product.id);
    productos[index] = product;
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    productos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  // Órdenes
  Future<List<Order>> getUserOrders() async {
    return orders.toList();
  }

  Future <List<OrderItem>> getProductOrders(int productId) async {
    Product ? product = await getProduct(productId);
    if(product == null){
      return [];
    }

    List<OrderItem> orderItems = [OrderItem(id:0, orderId: 0 ,product: product, quantity: 1, purchaseUnitPrice: 10.5)];

    return orderItems;
  }
  
  Future<Order?> getOrderDetails(int orderId) async {
    return orders.firstWhere((element) => element.id == orderId);
  }

  // Carrito
  Future<List<CartItem>> getCartItems() async {
    return cartItemsMock;
  }

  Future<void> addToCart(CartItem item) async {
    cartItemsMock.add(item);
    print('Adding to cart: ${item.product.name}');
    notifyListeners();
  }

  Future<void> updateCartItem(CartItem item) async {
    cartItemsMock[cartItemsMock
        .indexWhere((element) => element.product.name == item.product.name)] = item;
    print('Updating cart item: ${item.product.name}');
    //notifyListeners();
  }

  Future<void> removeFromCart(CartItem item) async {
    cartItemsMock.removeWhere((element) => element.product.id == item.product.id);
    notifyListeners();
  }

  Future<void> buyCart() async{
    var insertID = orders.length;
    var nuevaOrden = Order(
        id: insertID,
        clientId: loggedUser.id,
        clientName: loggedUser.email,
        date: DateTime.now().toString(),
        quantity: 2,
        totalAmount: 24.00,
        products: cartItemsMock);
    cartItemsMock = [];
    orders.add(nuevaOrden);
    notifyListeners();
  }



  // Autenticación
  Future<void> register(String email, String password) async {
    // TODO implementar
  }

  Future<LoginResponse> login(String email, String password) async {
    loggedUser.email = email;
    if (email == 'admin') {
      admin = true;
      return LoginResponse(logged: true, token: ' token', isAdmin: true, user: loggedUser);
    } if( email =="error"){
      return LoginResponse(logged: false, token: '', isAdmin: false);
    } else {
      admin = false;
      return LoginResponse(logged: true, token: 'token', isAdmin: false, user: loggedUser);
    }
  }
}
