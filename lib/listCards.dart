import 'package:flutter/material.dart';
import 'package:sweets_app/apiServer.dart';
import 'package:sweets_app/bottom_nav.dart';
import 'package:sweets_app/details.dart'; // Import the Details screen

class OurCards extends StatefulWidget {
  const OurCards({super.key});

  @override
  _OurCardsState createState() => _OurCardsState();
}

class _OurCardsState extends State<OurCards> {
  final ApiService apiService = ApiService();
  List<dynamic> products = [];
  bool isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products on initialization
  }

  Future<void> _fetchProducts() async {
    try {
      final fetchedProducts = await apiService.fetchProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Lists",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(product);
                },
              ),
            ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation here if required
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        // Navigate to the Details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(product["imageUrl"]),
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(height: 8.0),
              // Product Name
              Text(
                product["name"] ?? "Unnamed",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4.0),
              // Product Price
              Text(
                "\$${product["price"] ?? "0.00"}",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // Add Button
              ElevatedButton(
                onPressed: () {
                  print("${product["name"]} added to cart!");
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12.0),
                  backgroundColor: Colors.red,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}