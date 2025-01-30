import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sweets_app/singin.dart'; // Add import for Login page

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;
  File? _selectedImage; // Holds the selected image
  final ImagePicker _picker = ImagePicker(); // Initialize the ImagePicker

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final String apiUrl = "http://192.168.171.19:3000/api/profile/me";

    try {
      final token = await FlutterSecureStorage().read(key: "jwt_token");
      if (token == null) throw Exception("Token not found. Please log in again.");

      final response = await http.get(Uri.parse(apiUrl), headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        setState(() {
          profileData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load profile data: ${response.statusCode}");
      }
    } catch (error) {
      setState(() => isLoading = false);
      print("Error fetching profile data: $error");
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      // Optionally upload the image to the server
      await _uploadImage(_selectedImage!);
    }
  }

  // Function to upload the image to the server
  Future<void> _uploadImage(File image) async {
    final String apiUrl = "http://192.168.171.19:3000/api/profile/upload-image"; // Adjust the endpoint
    final token = await FlutterSecureStorage().read(key: "jwt_token");

    if (token == null) {
      throw Exception("Token not found. Please log in again.");
    }

    try {
      final request = http.MultipartRequest("POST", Uri.parse(apiUrl));
      request.headers["Authorization"] = "Bearer $token";
      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        print("Image uploaded successfully");
        fetchProfileData(); // Refresh the profile data after uploading
      } else {
        print("Failed to upload image: ${response.statusCode}");
      }
    } catch (error) {
      print("Error uploading image: $error");
    }
  }

  // Function to log the user out and redirect to the login page
  Future<void> _logout() async {
    // Clear stored token
    await FlutterSecureStorage().delete(key: "jwt_token");

    // Navigate to login page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()), // Replace with your Login page widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileData == null
              ? const Center(child: Text("Failed to load profile data"))
              : Column(
                  children: [
                    // Custom App Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 43),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 31, 10, 56),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => Navigator.pop(context),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 13),
                                  child: Text(
                                    "Profile",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 48), // Spacer for symmetry
                            ],
                          ),
                          const SizedBox(height: 30),
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: _selectedImage != null
                                    ? FileImage(_selectedImage!)
                                    : NetworkImage(profileData?['imageUrl'] ?? 'https://via.placeholder.com/150')
                                        as ImageProvider,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: _pickImage,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[600],
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            profileData?['username'] ?? "Name not available",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${profileData?['phone'] ?? 'Not available'}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Other Profile Fields
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileField(
                                label: "Username",
                                value: profileData?["username"] ?? "",
                                icon: Icons.person,
                              ),
                              ProfileField(
                                label: "Email",
                                value: profileData?["email"] ?? "",
                                icon: Icons.email,
                              ),
                              ProfileField(
                                label: "Phone",
                                value: profileData?["phone"] ?? "",
                                icon: Icons.phone,
                              ),
                              ProfileField(
                                label: "Address",
                                value: profileData?["address"] ?? "Mogadishu",
                                icon: Icons.location_on,
                              ),
                              const SizedBox(height: 20),
                             // Logout Button with Icon Inside
                              ElevatedButton.icon(
                                onPressed: _logout,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: BorderSide(color: Colors.red, width: 1),
                                ),
                                icon: Icon(
                                  Icons.exit_to_app, // Icon for logout
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.red, // Text color
                                  ),
                                ),
                             ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const ProfileField({super.key, required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ],
    );
  }
}
