import 'package:flutter/material.dart';
import 'package:ferreteria/controller/controller.dart'; // Asegúrate de importar tu controlador
import 'package:ferreteria/models/producto.dart';
import 'package:provider/provider.dart'; // Asegúrate de que la clase Producto esté importada

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  NewProductPageState createState() => NewProductPageState();
}

class NewProductPageState extends State<NewProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _description;
  double? _price;
  int? _stock;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<Controller>(context); // Obtiene el controlador de Provider
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nuevo Producto'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ingresa los detalles del nuevo producto',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descripción *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Precio *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un precio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Stock *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el stock inicial';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número entero válido';
                  }
                  return null;
                },
                onSaved: (value) => _stock = int.parse(value!),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.attach_file),
                label: const Text('Adjuntar imagen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  // Implementar lógica para adjuntar imagen
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí se llama al controlador para agregar el producto
                    controller.addProduct(Producto(
                        id: 0,
                        nombre: _name!,
                        descripcion: _description!,
                        precio: _price!,
                        stock: _stock!,
                        imagen: ""));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Producto creado exitosamente')),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Crear producto',
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
