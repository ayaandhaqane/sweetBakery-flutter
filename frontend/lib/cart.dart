class Cart {
  static final List<Map<String, dynamic>> items = [];

  static void addItem(Map<String, dynamic> product, int quantity) {
    // Check if the item already exists in the cart
    final existingItemIndex = items.indexWhere(
      (item) => item['name'] == product['name'],
    );

    if (existingItemIndex != -1) {
      // Update the quantity if the product already exists in the cart
      items[existingItemIndex]['quantity'] += quantity;
    } else {
      // Add new product to the cart
      items.add({
        "imageUrl": product["imageUrl"],
        "name": product["name"],
        "description": product["description"] ?? "No description",
        "price": product["price"],
        "quantity": quantity,
      });
    }
  }

  static double getTotalPrice() {
    return items.fold(
      0.0,
      (sum, item) => sum + (item["price"] * item["quantity"]),
    );
  }

  static void clearCart() {
    items.clear(); // Clear all items from the cart
  }
}
