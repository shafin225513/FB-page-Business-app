
import 'package:flutter/material.dart';
import 'package:real_sun_sd_closet_app/screens/signup_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final supabase = Supabase.instance.client;

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final imageController = TextEditingController();
  final priceController = TextEditingController();
  

  

 Future<void> addProduct() async {
  try {
    // 1. Attempt the insertion
    // Adding .select() forces Supabase to return the data (and errors) immediately
    final response = await supabase.from('products').insert({
      'name': nameController.text.trim(),
      'description': descController.text.trim(),
      'image_url': imageController.text.trim(),
      'price': double.tryParse(priceController.text) ?? 0,
    }).select();

    // 2. If it reaches here, it was successful
    print("✅ INSERT SUCCESS: $response");

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product added successfully!")),
      );
    }

    // Clear fields
    nameController.clear();
    descController.clear();
    imageController.clear();
    priceController.clear();
    
    setState(() {});

  } catch (error) {
    // 3. THIS IS THE KEY PART: Print the exact error to your console
    print("❌ SUPABASE INSERT ERROR: $error");

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add product: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


  Future<void> deleteProduct(String id) async {
    await supabase.from('products').delete().eq('id', id);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Deleted")));

    setState(() {});
  }

  Future<List<dynamic>> fetchProducts() async {
    return await supabase.from('products').select();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[100], // Light grey background for a clean look
    appBar: AppBar(
      title: const Text("Inventory Management", style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0,
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
    
    // 🔹 Floating Action Button to add products
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () => _showAddProductSheet(context),
      label: const Text("Add Product"),
      icon: const Icon(Icons.add),
    ),

    body: FutureBuilder(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data as List? ?? [];

        if (products.isEmpty) {
          return const Center(child: Text("No products in inventory."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final item = products[index];

            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item['image_url'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 40),
                  ),
                ),
                title: Text(
                  item['name'], 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
                subtitle: Text(
                  "\$${item['price']}", 
                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () => _confirmDelete(item['id']),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

// 🔹 Function to show the Add Product Form in a Bottom Sheet
void _showAddProductSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Moves up with keyboard
        left: 20, right: 20, top: 20
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Add New Product", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          _buildTextField(nameController, "Product Name", Icons.shopping_bag_outlined),
          _buildTextField(descController, "Description", Icons.description_outlined),
          _buildTextField(imageController, "Image URL", Icons.link),
          _buildTextField(priceController, "Price", Icons.attach_money, isNumber: true),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                addProduct();
                Navigator.pop(context);
              },
              child: const Text("Save Product"),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

// 🔹 Reusable helper for text fields
Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}

// 🔹 Confirmation Dialog for Deleting
void _confirmDelete(String id) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Product?"),
      content: const Text("This action cannot be undone."),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            deleteProduct(id);
            Navigator.pop(context);
          }, 
          child: const Text("Delete", style: TextStyle(color: Colors.red))
        ),
      ],
    ),
  );
}
}