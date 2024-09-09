class CartItem {
  final String name;
  final String variant;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.variant,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'],
      variant: json['variant'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'variant': variant,
      'price': price,
      'quantity': quantity,
    };
  }
}