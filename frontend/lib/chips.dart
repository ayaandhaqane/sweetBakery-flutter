import 'package:flutter/material.dart';

class ChipsPage extends StatefulWidget {
  @override
  _ChipsPageState createState() => _ChipsPageState();
}

class _ChipsPageState extends State<ChipsPage> {
  String selectedChip = "All"; // Initial selected chip

  final Map<String, List<String>> sweets = {
    "All": ["Chocolate Cake", "Vanilla Cupcake", "Strawberry Tart"],
    "Cakes": ["Chocolate Cake", "Vanilla Cake", "Red Velvet Cake"],
    "Cupcakes": ["Vanilla Cupcake", "Chocolate Cupcake", "Lemon Cupcake"],
    "Tarts": ["Strawberry Tart", "Blueberry Tart"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chips Example"),
        backgroundColor: const Color(0xff864912),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: sweets.keys.map((category) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedChip = category; // Update selected chip
                    });
                  },
                  child: chips(
                    title: category,
                    isActive: selectedChip == category,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Display related sweets
          Expanded(
            child: ListView.builder(
              itemCount: sweets[selectedChip]?.length ?? 0,
              itemBuilder: (context, index) {
                final sweet = sweets[selectedChip]![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        sweet,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class chips extends StatelessWidget {
  const chips({
    super.key,
    required this.title,
    this.isActive = false,
  });

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        label: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xff290707),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        backgroundColor:
            isActive ? const Color.fromARGB(255, 31, 10, 56) : const Color(0xfff6f6f6),
        clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
