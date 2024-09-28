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
  List<Product> productos = [];

  final Dio _dio = Dio();
  static const String _baseUrl = "http://localhost:8889/api/v1/";

Future<bool> isAdmin()async{
  return false;
}
  // Productos
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('$_baseUrl/products');
      productos = (response.data as List).map((item) => Product.fromJson(item)).toList();
      return productos;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<Product?> getProduct(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/products/$id');
      return Product.fromJson(response.data);
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _dio.post('$_baseUrl/products', data: product.toJson());
      //productos.add(product);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _dio.put('$_baseUrl/products', data: product.toJson());
      //final index = productos.indexWhere((element) => element.id == product.id);
     // productos[index] = product;
      notifyListeners();
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dio.delete('$_baseUrl/products/$id');
     //productos.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
  Future<List<Order>> getUserOrders() async{
    final response = await _dio.get('$_baseUrl/order/user/2');
    return (response.data as List).map((item) => Order.fromJson(item)).toList();
  }
  // Órdenes
  Future<List<OrderItem>> getProductOrders(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/orders/product/$id');
      return (response.data as List).map((item) => OrderItem.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }

  Future<Order?> getOrderDetails(int orderId) async {
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
      notifyListeners();
    } catch (e) {
      print('Error adding item to cart: $e');
    }
  }

  Future<void> updateCartItem(CartItem item) async {
    try {
      await _dio.put('$_baseUrl/cart/${item.product.name}', data: item.toJson());
      notifyListeners();
    } catch (e) {
      print('Error updating cart item: $e');
    }
  }

  Future<void> removeFromCart(CartItem item) async {
    try {
      await _dio.post('$_baseUrl/cart/${item.product.id}/remove', data:{item.quantity});
      notifyListeners();
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  // Autenticación,
  Future<void> register(String name, String email, String password) async {
    try {
      await _dio.post('$_baseUrl/register', data: {'name':name,'email': email, 'password': password});
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post('$_baseUrl/auth', data: {'email': email, 'password': password});
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      print('Error logging in: $e');
      return LoginResponse(logged: false, token: "", isAdmin: false);
    }
  }
  Future<void> buyCart()async{
    
  }
}
