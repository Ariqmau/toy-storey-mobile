import 'package:flutter/material.dart';
import 'package:toy_storey/models/product_entry.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductEntry product; // Replace `dynamic` with the actual data type

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.fields.name), // Display the product's mood
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price: ${product.fields.price}",
            ),
            const SizedBox(height: 10),
            Text("Description: ${product.fields.description}"),
            const SizedBox(height: 10),
            Text("Stock: ${product.fields.stock}"),
          ],
        ),
      ),
    );
  }
}
