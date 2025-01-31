# Sweet Bakery App 🍰

Sweet Bakery App is a modern, feature-rich mobile application designed to enhance the bakery shopping experience. Built with **Flutter** for the frontend and **Node.js** for the backend, this app offers a seamless and intuitive platform for users to browse, search, and purchase their favorite sweets with ease.

---

## Key Features ✨

### 1. **Product Catalog**
- Displays a wide variety of bakery products such as cakes, cupcakes, chocolates, and desserts.
- Includes search functionality to quickly find specific products.
- Organized into categories for easy navigation.

### 2. **Product Details**
- Provides detailed information about each product, including:
  - Product name.
  - Description.
  - Price.
  - Ratings.
  - Adjustable quantity with an "Add to Cart" option.

### 3. **Shopping Cart**
- Manage cart items effortlessly with features like:
  - Add/remove items.
  - Increase or decrease item quantities.
  - Apply promo codes.
  - View total cost and delivery fee.
- Seamless checkout process for a smooth shopping experience.

### 4. **User Authentication**
- User-friendly login and signup pages.
- Secure authentication using backend APIs.

### 5. **Dark and Light Mode**
- Supports both dark and light themes for better user experience and accessibility.

### 6. **Help & Policy Pages**
- Help section to guide users through the app's functionality.
- Policy page outlining the app's terms and conditions.

---

## Tech Stack 💻

### **Frontend**
- **Flutter**: Cross-platform mobile app development framework.
- **Dart**: Programming language for Flutter development.

### **Backend**
- **Node.js**: Backend runtime environment.
- **Express.js**: Framework for building RESTful APIs.
- **MongoDB**: Database for managing product, user, and transaction data.

---

## Project Structure 🛠

### **Frontend Directory**

#### **lib/**
- **`main.dart`**: The entry point of the Flutter app.
- **`home.dart`**: Displays the product catalog and search functionality.
- **`details.dart`**: Shows detailed product information.
- **`userCart.dart`**: Handles shopping cart operations.
- **`help.dart`**: Displays the help page.
- **`policy.dart`**: Outlines the app's policy.
- **`signUp.dart` and `signIn.dart`**: User authentication pages.
- **`chips.dart`**: Custom widget for product categories.
- **`card.dart`**: Custom widget for product cards.

#### **assets/**
- Contains images and other static assets used in the app.

---

### **Backend Directory**

#### **router/**
- **`profileRoute.js`**: User-related routes for login and registration.
- **`TBLrouter.js`**: Routes for managing products and transactions.

#### **modalSchema/**
- **`profileSchema.js`**: MongoDB schema for user profiles.
- **`TBLSchema.js`**: MongoDB schema for products and transactions.

#### **Other Backend Files**
- **`app.js`**: Entry point for the backend, initializes the server and routes.
- **`data.js`**: Contains seed or dummy data for products.
- **`.env`**: Stores environment variables for secure configuration.

---

## Team Members 👥

| Name                       | GitHub Username                        |
|----------------------------|----------------------------------------|
| Ayan Abdulahi Dhaqane      | [https://github.com/ayaandhaqane]      |
| Bahja Abdi Jama            | [https://github.com/bahjoabdi]         |
| Muzamil Tahlil Dahir       | [https://github.com/MuzamilTahliil]    |
| Abdirashid Hasan Mohamed   | [https://github.com/AbdirashiidHassan] |
| Ibrahim Farhan Abshir      | [https://github.com/ibrahimxabeeb]     |

---

## Screenshots 📸

### Welcome Page


### Sign-In Page


### Sign-up Page


### Home Page


### List All Cards Page


### Product Details Page


### User Shoping Page


### Profie Page


### Policy Page


### Help Page


---

## Installation and Setup 🛠

### **Prerequisites**
- Install [Flutter](https://flutter.dev/docs/get-started/install).
- Install [Node.js](https://nodejs.org/).
- Set up [MongoDB](https://www.mongodb.com/).

### **Steps to Run**

#### **Frontend**
1. Clone the repository:
   ```bash
   git clone https://github.com/ayaandhaqane/sweetBakery-flutter
