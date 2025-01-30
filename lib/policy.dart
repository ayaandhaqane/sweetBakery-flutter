import 'package:flutter/material.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: const Color.fromARGB(255, 31, 10, 56),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your privacy is important to us. This privacy policy explains the data we collect, how we use it, and your rights to control your data.\n\n'
              '1. **Data Collection**\n'
              'We collect data to provide the best experience in our app. This includes usage data, device information, and location data.\n\n'
              '2. **Data Usage**\n'
              'Your data is used to process orders, improve our services, and send you promotional content (with your consent).\n\n'
              '3. **Data Security**\n'
              'We implement security measures to protect your data, but we cannot guarantee full protection against all potential risks.\n\n'
              '4. **Your Rights**\n'
              'You have the right to access, correct, or delete your data. You can also opt-out of marketing communications at any time.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
