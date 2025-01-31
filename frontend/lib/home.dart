import 'package:flutter/material.dart';
import 'package:sweets_app/apiServer.dart';
import 'package:sweets_app/help.dart';
import 'package:sweets_app/homeCard.dart';
import 'package:sweets_app/chips.dart';
import 'package:sweets_app/bottom_nav.dart';
import 'package:sweets_app/policy.dart';
import 'package:sweets_app/singin.dart'; // Import your BottomNavBar file

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ApiService apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0; // Track active navigation index
  String activeCategory = "Chocolate"; // Default active category
  List<dynamic> products = []; // List to store data fetched from the backend
  bool isLoading = true; // Show loading indicator while data is being fetched
  bool _isDarkMode = false; // Default mode is light mode

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final fetchedProducts = await apiService.fetchProducts();
      setState(() {
        products = fetchedProducts; // Update the products list with backend data
        isLoading = false; // Stop showing the loading indicator
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        isLoading = false; // Stop showing the loading indicator even on error
      });
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? const Color.fromARGB(255, 31, 30, 30) : Color.fromARGB(255, 240, 236, 236), // Background color changes based on dark mode
      appBar: AppBar(
        
        elevation: 0,
        backgroundColor: _isDarkMode ? const Color.fromARGB(255, 34, 34, 34): const Color.fromARGB(255, 245, 239, 239),
        automaticallyImplyLeading: false, // Remove the default back arrow
        centerTitle: false,
        title: Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Sweet Bakery",
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black, // Text color changes based on dark mode
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, // Icon switches based on dark mode
              color: _isDarkMode ? Colors.white : const Color.fromARGB(255, 255, 230, 1), // Icon color changes based on dark mode
            ),
            onPressed: _toggleTheme, // Toggle theme when icon is clicked
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "Logout") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              } else if (value == "Help") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              } else if (value == "Policy") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PolicyPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Help', 'Policy'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black), // Text color in popup menu
                  ),
                );
              }).toList();
            },
            icon: Icon(
              Icons.more_vert,
              color: _isDarkMode ? Colors.white : Colors.black, // Icon color changes based on dark mode
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's find your\nfavorite food!",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: _isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56), // Text color changes based on dark mode
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(color: _isDarkMode ? Colors.white : Colors.black), // Adjust the hint text color based on dark mode
                            prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                            filled: true,
                            fillColor: _isDarkMode ? Colors.grey[800] : Colors.grey[300], // Background color changes based on dark mode
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Categories Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56), // Text color changes based on dark mode
                          ),
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => _setActiveCategory("Chocolate"),
                                child: chips(
                                  title: "Chocolate",
                                  isActive: activeCategory == "Chocolate",
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _setActiveCategory("Cake"),
                                child: chips(
                                  title: "Cake",
                                  isActive: activeCategory == "Cake",
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _setActiveCategory("Cupcake"),
                                child: chips(
                                  title: "Cupcake",
                                  isActive: activeCategory == "Cupcake",
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _setActiveCategory("Desserts"),
                                child: chips(
                                  title: "Desserts",
                                  isActive: activeCategory == "Desserts",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 65),
                  // Products Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 20, // Horizontal spacing
                        mainAxisSpacing: 40, // Vertical spacing
                        mainAxisExtent: 200, // Adjust the height of each card
                      ),
                      itemCount: products.length > 6 ? 6 : products.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return card(
                          title: product["name"],
                          price: product["price"].toString(),
                          imageUrl: product["imageUrl"],
                          product: product,
                          isDarkMode: _isDarkMode,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
            isDarkMode: _isDarkMode, // Pass dark mode state

  
      ),
    );
  }

  void _setActiveCategory(String category) {
    setState(() {
      activeCategory = category;
    });
  }
}
