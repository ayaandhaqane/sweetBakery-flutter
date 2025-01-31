import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = "http://192.168.18.8:3000/api";
  final FlutterSecureStorage storage = FlutterSecureStorage(); // For JWT token storage

  // Fetch all products
  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/read'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Create a product
  Future<void> createProduct(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(product),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create product');
    }
  }

  // Update a product
  Future<void> updateProduct(String id, Map<String, dynamic> product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/edit/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(product),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }

  // Create a new user profile
  Future<Map<String, dynamic>> createProfile(Map<String, dynamic> profileData) async {
    final url = Uri.parse('$baseUrl/create-profile');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(profileData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body); // Return the created profile data
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Failed to create profile');
      }
    } catch (e) {
      throw Exception('Error creating profile: $e');
    }
  }

  // Fetch the profile of the logged-in user
  Future<Map<String, dynamic>> fetchProfileData() async {
    try {
      final token = await storage.read(key: "jwt_token"); // Retrieve the stored JWT token
      final response = await http.get(Uri.parse('$baseUrl/profile/me'), headers: {
        "Authorization": "Bearer $token", // Attach token to the request
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Return profile data
      } else {
        throw Exception("Failed to load profile data");
      }
    } catch (error) {
      throw Exception("Error fetching profile data: $error");
    }
  }

  // Update a user profile
  Future<Map<String, dynamic>> updateProfile(String id, Map<String, dynamic> updatedData) async {
    final url = Uri.parse('$baseUrl/profile/$id');
    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Return updated profile data
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }

  // Delete a user profile
  Future<void> deleteProfile(String id) async {
    final url = Uri.parse('$baseUrl/profile/$id');
    try {
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Failed to delete profile');
      }
    } catch (e) {
      throw Exception('Error deleting profile: $e');
    }
  }

  
}


