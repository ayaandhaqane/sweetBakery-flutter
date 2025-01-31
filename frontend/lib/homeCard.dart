import 'package:flutter/material.dart';
import 'package:sweets_app/details.dart';

class card extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final Map<String, dynamic> product;
  final bool isDarkMode;  // Add the isDarkMode parameter to toggle the background color

  const card({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.product,
    required this.isDarkMode,  // Pass the isDarkMode value when creating the card
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(product: product, isDarkMode: isDarkMode,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0), // Add spacing between cards
        child: Container(
          width: 140,
          height: 200, // Adjust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(15),
            ),
            color: isDarkMode ? const Color.fromARGB(255, 24, 16, 43) : Colors.white, // Set the background color to blue-dark in dark mode
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5), // Add a shadow for better aesthetics
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: -40, // Adjust the position of the image
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 53,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0), // Adjust the top padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "\$${price}", // Add a dollar sign before the price
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56), // Change price color based on dark mode
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
