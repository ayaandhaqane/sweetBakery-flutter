

import 'package:flutter/material.dart';
import 'package:sweets_app/home.dart';
import 'package:sweets_app/listCards.dart';
import 'package:sweets_app/profile.dart';
import 'package:sweets_app/userCart.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isDarkMode; 
   // Add isDarkMode parameter

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.isDarkMode,  // Pass the isDarkMode value
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0; // Default selected index

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex; // Initialize with the current index
  }

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index; // Update selected index
      });
      widget.onTap(index); // Notify parent widget

      // Navigate based on the index
      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OurCards(isDarkMode: widget.isDarkMode)), // Pass isDarkMode value
        );
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyCartPage(isDarkMode: widget.isDarkMode)),
        );
      } else if (index == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(isDarkMode: widget.isDarkMode)),
        );
      }
    }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white, // Change background based on dark mode
      selectedItemColor: widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56), // Selected icon color
      unselectedItemColor: widget.isDarkMode ? Colors.grey : Colors.blue, // Unselected icon color
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _selectedIndex == 0 ? (widget.isDarkMode ? Colors.white : Color.fromARGB(255, 50, 19, 87)) : (widget.isDarkMode ? Colors.grey : Colors.black),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.grid_view_rounded,
            color: _selectedIndex == 1 ? (widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56)) : (widget.isDarkMode ? Colors.grey : Colors.black),
          ),
          label: "Categories",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            color: _selectedIndex == 2 ? (widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56)) : (widget.isDarkMode ? Colors.grey : Colors.black),
          ),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: _selectedIndex == 3 ? (widget.isDarkMode ? Colors.white : Color.fromARGB(255, 31, 10, 56)) : (widget.isDarkMode ? Colors.grey : Colors.black),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
