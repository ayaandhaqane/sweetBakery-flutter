import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: const Color.fromARGB(255, 31, 10, 56),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'How to Use the App',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              '1. Browse categories to find your favorite sweet treats.\n'
              '2. Use the search bar to search for specific items.\n'
              '3. Tap on any sweet to see more details and place an order.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'FAQ:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text(
                'Q: How do I place an order?',
                style: TextStyle(fontSize: 16),
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'A: Simply select an item and follow the prompts to complete your order.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'Q: Can I track my order?',
                style: TextStyle(fontSize: 16),
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'A: Yes, you will receive updates as your order is being prepared and shipped.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'Q: How do I change my order?',
                style: TextStyle(fontSize: 16),
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'A: Once your order is placed, changes cannot be made. Please contact customer support for assistance.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'Q: How can I make a payment?',
                style: TextStyle(fontSize: 16),
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'A: We accept payments via credit/debit cards and other supported payment methods.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                'Q: How do I contact customer support?',
                style: TextStyle(fontSize: 16),
              ),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'A: You can contact our customer support through the "Contact Us" section in the app or via email.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
