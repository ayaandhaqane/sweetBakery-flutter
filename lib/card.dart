import 'package:flutter/material.dart';
import 'package:sweets_app/details.dart';

class card extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final Map<String, dynamic> product;

  const card({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(product: product),
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
            color: Colors.white, // Set the background color to white
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
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
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "\$${price}", // Add a dollar sign before the price
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 31, 10, 56), // Highlight the price
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