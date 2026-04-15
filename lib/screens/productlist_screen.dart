import 'package:flutter/material.dart';
import 'package:real_sun_sd_closet_app/screens/product_description.dart';
import 'package:real_sun_sd_closet_app/screens/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductlistScreen extends StatefulWidget {
  const ProductlistScreen({super.key});

  @override
  State<ProductlistScreen> createState() => _ProductlistScreenState();
}

class _ProductlistScreenState extends State<ProductlistScreen> {
  // 1. Function to fetch data from Supabase
  Future<List<Product>> fetchProducts() async {
    final response = await Supabase.instance.client
        .from('products')
        .select()
        .order('created_at', ascending: false);
    
    return (response as List).map((data) => Product.fromMap(data)).toList();
  }

  // 2. Function to launch WhatsApp
  void orderViaWhatsApp(Product product) async {
    final phoneNumber = "+8801936307018"; 
    final message = "Hi! I'm interested in buying: ${product.name} for \$৳{product.price}.";
    final url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Items"),
      backgroundColor: Colors.blueGrey,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                         );
          },
           icon: Icon(Icons.logout))

      ],
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return GestureDetector(
                onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: item),
                 ),
               );
               
             },
             child: Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: SizedBox(
    width: 80,  // Fixed width
    height: 80, // Fixed height
    child: Image.network(
      item.imageUrl,
      fit: BoxFit.cover,
      alignment: Alignment.center, // This crops the edges to fit the 60x60 square
    ),
  ),
),
                  title: Text(item.name),
                  subtitle: Text("\$৳{item.price}"),
                  trailing: ElevatedButton(
                    onPressed: () => orderViaWhatsApp(item),
                    child: const Text("Order"),
                  ),
                ),
              ),

              );
              
            },
          );
        },
      ),
    );
  }
}