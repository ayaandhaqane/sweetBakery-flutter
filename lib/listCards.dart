import 'package:flutter/material.dart';
import 'package:sweets_app/apiServer.dart';
import 'package:sweets_app/bottom_nav.dart'; // Import BottomNavBar
import 'package:sweets_app/cart.dart';
import 'package:sweets_app/details.dart';
import 'package:sweets_app/home.dart';
import 'package:sweets_app/userCart.dart';

class OurCards extends StatefulWidget {
  final bool isDarkMode; // Add isDarkMode parameter

  const OurCards({super.key, required this.isDarkMode}); // Receive the isDarkMode parameter

  @override
  _OurCardsState createState() => _OurCardsState();
}

class _OurCardsState extends State<OurCards> {
  final ApiService apiService = ApiService();
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  bool isLoading = true; // Loading indicator
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

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
        filteredProducts = products; // Initially, show all products
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addToCart(Map<String, dynamic> product) {
    Cart.addItem(product, 1);
    setState(() {}); // Refresh UI to update cart count
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white, // Adjust background color based on dark mode
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white, // Adjust AppBar color based on dark mode
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            
             ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()), // Navigate to Home screen
            );
          },
        ),
        title: isSearching
            ? Container(
                height: 45,
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? Colors.grey[800] : Colors.grey[200], // Adjust search field background
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black), // Hint text color based on dark mode
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    contentPadding: const EdgeInsets.only(left: 10, top: 12),
                  ),
                  onChanged: _filterProducts,
                ),
              )
            : Text(
                "List Cards",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode ? Colors.white : Colors.black, // Text color based on dark mode
                ),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: widget.isDarkMode ? Colors.white : Colors.black, // Icon color based on dark mode
            ),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                searchController.clear();
                filteredProducts = products;
              });
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: widget.isDarkMode ? Colors.white : Colors.black, // Icon color based on dark mode
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCartPage(isDarkMode: widget.isDarkMode)),
                  );
                },
              ),
              if (Cart.items.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${Cart.items.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12, // Reduce space to make cards smaller
                        childAspectRatio: 0.85, // Adjust aspect ratio for smaller cards
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return _buildProductCard(product);
                      },
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OurCards(isDarkMode: widget.isDarkMode)),
          );
        },
        isDarkMode: widget.isDarkMode, // Pass isDarkMode value to BottomNavBar
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(product: product,isDarkMode: widget.isDarkMode),
          ),
        );
      },
      child: Card(
        color: widget.isDarkMode ? Colors.grey[800] : Colors.white, // Card color based on dark mode
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 95, // Smaller height for better UI fit
                  width: 95,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(product["imageUrl"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  product["name"] ?? "Unnamed",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: widget.isDarkMode ? Colors.white : Colors.black, // Text color based on dark mode
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product["price"] ?? "0.00"}",
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56), // Text color based on dark mode
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addToCart(product);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                      backgroundColor: widget.isDarkMode ? Colors.deepPurple : Color.fromARGB(255, 31, 10, 56),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
