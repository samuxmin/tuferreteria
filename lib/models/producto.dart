class Producto {
  String nombre;
  double precio;
  String imagen;
  String descripcion;
  int id;
  int stock;  

  Producto({required this.id, required this.nombre, required this.precio, required this.imagen, required this.descripcion, required this.stock});  // Actualizado el constructor

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      precio: json['precio'],
      imagen: json['imagen'],
      descripcion: json['descripcion'],
      stock: json['stock'],  
    );
  }

  toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'imagen': imagen,
      'descripcion': descripcion,
      'stock': stock,  
    };
  }
}