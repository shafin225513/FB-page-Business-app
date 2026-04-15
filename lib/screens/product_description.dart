import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product_model.dart'; // Import your model here

class ProductDetailScreen extends StatelessWidget {
  final Product product; // Change this from Map to Product

  const ProductDetailScreen({super.key, required this.product});

  void orderViaWhatsApp() async {
    final phone = "+8801936307018"; 
    // Use product.name instead of product['name']
    final message = "Hi! I'm interested in: ${product.name}\nPrice: \$৳{product.price}";
    final url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 REMOVE the 60x60 SizedBox here!
ClipRRect(
  borderRadius: BorderRadius.circular(12), // Slightly larger radius for big images
  child: Image.network(
    product.imageUrl,
    width: double.infinity, // Takes full width of screen
    height: 300,            // Fixed height of 300
    fit: BoxFit.cover,      // This will now work properly!
    alignment: Alignment.center,
    errorBuilder: (context, error, stackTrace) => Container(
      height: 300,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image, size: 50),
    ),
  ),
),
            
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\৳${product.price}",
                    style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 40),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  // Use product.description
                  Text(
                    product.description.isEmpty ? "No description provided." : product.description,
                    style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton.icon(
          onPressed: orderViaWhatsApp,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          icon: const Icon(Icons.chat, color: Colors.white),
          label: const Text("Order via WhatsApp", style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }
}