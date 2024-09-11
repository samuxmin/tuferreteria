import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Center(
                  child: image.isNotEmpty 
                    ? Image.network(
                        image, 
                        fit: BoxFit.cover, 
                        width: double.infinity, 
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image, size: 50, color: Colors.grey[400]);
                        },
                      )
                    : Icon(Icons.image, size: 50, color: Colors.grey[400]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('\$${price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
