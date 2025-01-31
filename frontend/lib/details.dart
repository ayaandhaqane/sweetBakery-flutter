import 'package:flutter/material.dart';
import 'package:sweets_app/cart.dart';
import 'package:sweets_app/userCart.dart';

class Details extends StatefulWidget {
  final Map<String, dynamic> product;
  final bool isDarkMode; // Add isDarkMode parameter

  const Details({super.key, required this.product, required this.isDarkMode}); // Receive the isDarkMode parameter

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white, // Set background color based on dark mode
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Image Section with Arrow on top
            Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: widget.isDarkMode ? Colors.white30 : Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.product["imageUrl"] ?? "",
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16, // Adjust the positioning of the arrow
                  left: 16, // Adjust the positioning of the arrow
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: widget.isDarkMode ? Colors.white : Colors.black, // Color for back arrow based on dark mode
                      size: 30, // Size of the back arrow
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Navigate to the previous screen
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Title and Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product["name"] ?? "Unnamed Product",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56), // Title Color based on dark mode
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: index < (widget.product["rating"]?.toInt() ?? 0)
                              ? Colors.amber // Active star color
                              : widget.isDarkMode ? Colors.grey : Colors.grey[300], // Active or inactive star color
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                // 🔹 Quantity Selector
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        size: 28,
                        color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56),
                      ),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Text(
                      "$quantity",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 28,
                        color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56),
                      ),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Description Section
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.product["description"] ?? "No description available.",
              style: TextStyle(
                fontSize: 14,
                color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[600], // Text color based on dark mode
              ),
            ),
            const Spacer(),

            // 🔹 Price and Add to Cart Section
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56),
                      ),
                    ),
                    Text(
                      "\$${((widget.product["price"] ?? 0.0) * quantity).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.isDarkMode ? Colors.deepPurple : const Color.fromARGB(255, 31, 10, 56), // Button color based on dark mode
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Cart.addItem(widget.product, quantity); // Add to cart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCartPage(isDarkMode: widget.isDarkMode)), // Pass dark mode status
                    );
                  },
                  icon: const Icon(Icons.shopping_bag, color: Colors.white),
                  label: const Text(
                    "Add To Cart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
