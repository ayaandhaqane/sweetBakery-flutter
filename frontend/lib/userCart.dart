import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sweets_app/cart.dart';
import 'package:sweets_app/home.dart';

class MyCartPage extends StatefulWidget {
  final bool isDarkMode; // Add isDarkMode parameter

  const MyCartPage({super.key, required this.isDarkMode}); // Receive the isDarkMode parameter

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  void _updateCart() {
    setState(() {}); // Refresh the cart page
  }

  void _removeItem(int index) {
    setState(() {
      Cart.items.removeAt(index); // Remove the selected item
    });
  }

  // Function to show a dialog for entering address and phone number
void _showCheckoutDialog(BuildContext context) {
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text(
          "Enter your Information",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email, // Icon for email
                  color: widget.isDarkMode ? Colors.grey[400] : Colors.black,
                ),
                hintText: "Enter your address",
                hintStyle: TextStyle(
                    color: widget.isDarkMode ? Colors.grey[400] : Colors.black),
                filled: true,
                fillColor:
                    widget.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone, // Icon for phone
                  color: widget.isDarkMode ? Colors.grey[400] : Colors.black,
                ),
                hintText: "Enter your phone number",
                hintStyle: TextStyle(
                    color: widget.isDarkMode ? Colors.grey[400] : Colors.black),
                filled: true,
                fillColor:
                    widget.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              final address = _addressController.text;
              final phone = _phoneController.text;

              if (address.isNotEmpty && phone.isNotEmpty) {
                Navigator.pop(context); // Close the dialog
                sendOrder(address, phone); // Send order to backend
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please fill in all fields."),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.isDarkMode
                  ? Colors.deepPurple
                  : const Color.fromARGB(255, 31, 10, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              "Proceed",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}




// Add this function to your _MyCartPageState class
Future<void> sendOrder(String address, String phone) async {
  final String apiUrl = "http://192.168.18.8:3000/api/new"; // Replace with your backend API URL

  // Prepare the order data
  final orderData = {
    "address": address,
    "phone": phone,
    "items": Cart.items.map((item) {
      return {
        "name": item["name"],
        "quantity": item["quantity"],
        "price": item["price"],
      };
    }).toList(),
    "totalPrice": Cart.getTotalPrice(),
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      // Handle success
      print("Order sent successfully: ${response.body}");
      setState(() {
        Cart.items.clear(); // Clear cart after successful order
      });
      _showSuccessSnackBar(context);
    } else {
      // Handle failure
      print("Failed to send order: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send order: ${response.body}")),
      );
    }
  } catch (e) {
    print("Error sending order: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error sending order: $e")),
    );
  }
}





void _showSuccessSnackBar(BuildContext context) {
  // Show a success message using SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text(
        "Order placed successfully!",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 31, 10, 56), // Green color for success
      duration: const Duration(seconds: 3), // Duration of the SnackBar
    ),
  );

  // Navigate to home page after a delay
  Future.delayed(const Duration(seconds: 1), () {
    setState(() {
      Cart.items.clear(); // Clear the cart after successful order
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()), // Navigate to home
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white, // Adjust background color based on dark mode
      appBar: AppBar(
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white, // Adjust AppBar color based on dark mode
        elevation: 0,
        foregroundColor: widget.isDarkMode ? Colors.white : const Color.fromARGB(255, 31, 10, 56),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: widget.isDarkMode ? Colors.white : Colors.black, // Change arrow color based on dark mode
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "My Cart",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: widget.isDarkMode ? Colors.white : const Color.fromARGB(255, 31, 10, 56),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: Cart.items.length,
                itemBuilder: (context, index) {
                  final item = Cart.items[index];
                  return Dismissible(
                    key: Key(item["name"]),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red[50],
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    onDismissed: (direction) {
                      _removeItem(index); // Remove the item when swiped
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item["name"]} removed from the cart'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              item["imageUrl"],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["name"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isDarkMode ? Colors.white : Colors.black, // Change text color based on dark mode
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item["description"],
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: widget.isDarkMode ? Colors.white : Colors.grey),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "\$${item["price"].toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (item['quantity'] > 1) {
                                      item['quantity']--;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 32,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: widget.isDarkMode ? Colors.grey[700] : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.remove, color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item['quantity'].toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    item['quantity']++;
                                  });
                                },
                                child: Container(
                                  width: 32,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 31, 10, 56),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Promo Code",
                      filled: true,
                      fillColor: widget.isDarkMode ? Colors.grey[700] : Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 31, 10, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildPriceDetails(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showCheckoutDialog(context); // Show the checkout dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 31, 10, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                "Proceed to Checkout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceDetails() {
    final totalPrice = Cart.getTotalPrice();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceRow("Sub-Total", "\$${totalPrice.toStringAsFixed(2)}"),
        _buildPriceRow("Delivery Fee", "\$00.00"),
        const Divider(color: Colors.grey),
        _buildPriceRow(
          "Total Cost",
          "\$${totalPrice.toStringAsFixed(2)}",
          isBold: true,
          fontSize: 18,
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool isBold = false, double fontSize = 14}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: widget.isDarkMode ? Colors.white : Colors.black, // Text color based on dark mode
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: widget.isDarkMode ? Colors.white : Colors.black, // Text color based on dark mode
            ),
          ),
        ],
      ),
    );
  }
}
