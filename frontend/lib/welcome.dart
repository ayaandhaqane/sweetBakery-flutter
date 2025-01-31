import 'package:flutter/material.dart';
import 'package:sweets_app/singin.dart';

class WelcomePage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // *White Background*
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // *Big Image with Curved Bottom*
          ClipPath(
            clipper: BottomCurveClipper(), // *Curved Bottom*
            child: Container(
              width: double.infinity,
              height: 500, // *Big Image*
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/welcome.jpg'), // Your Image Path
                  fit: BoxFit.cover, // Ensures the image fills the space
                ),
              ),
            ),
          ),

          const SizedBox(height: 20), // Space between image and text

          // *Welcome Text with Custom Colors*
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // *Text Black*
                  ),
                ),
                TextSpan(
                  text: 'Our Sweet Bakery ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 31, 10, 56), // *Custom Color*
                  ),
                ),
                TextSpan(
                  text: 'Haven!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // *Text Black*
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20), // Space between text and description

          // *Description Text*
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54, // *Text Black*
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 40), // Space between description and button

          // *"Let's Get Started" Button*
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 31, 10, 56), // *Button Color*
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
            ),
            child: const Text(
              'Let\'s Get Started',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // *White Button Text*
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// *Custom Clipper for Curved Image Bottom*
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
