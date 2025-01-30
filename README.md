# Swet Bakery Project

Swet Bakery Project is a Node.js-based backend API designed to provide user access, profile management, and order management for a sweets shop application. It integrates seamlessly with the Flutter-based frontend app.

## Project Overview
The *Swet Bakery Project* focuses on:
- *User Authentication*: Securely manage user login and profile access.
- *Profile Management*: Provide user access to their data.
- *Order Management*: Allow users to place and manage their orders.
- *Scalable Design*: Built with Node.js and MongoDB for reliability and scalability.

This is github project Swet Bakery Project  *[Sweets App](https://github.com/ayaandhaqane/sweetBakery-flutter)*, frontend and Backend 

## Features
- *User Management*: Provide secure access and manage user profiles.
- *Order Management*: Handle user orders, including creating and retrieving order details.
- *Database Integration*: Store and retrieve user and order data with MongoDB.
- *RESTful API*: Backend API for frontend integration.

## Project Structure
- assets/modalSchema/: MongoDB schemas for managing user and order data (e.g., profileSchema.js, orderSchema.js).
- router/: API route definitions for user access and orders (e.g., profileRoute.js, orderRoute.js).
- app.js: Main server file to initialize and run the application.
- .env: Configuration for environment variables like database URL and server port.

## Installation and Setup
1. Clone the repository and navigate to the project directory:
   ```bash
   git clone <repository-url>
   cd SWET-BAKERY-PROJECT
2. Install all dependencies:
    npm install

3. Create a .env file in the root directory and configure your environment variables
MONGO_URI=<your-mongodb-uri>
PORT=5000
4. Start the server
   npm start

5. Use tools like Postman or curl to test the user access and order API endpoints.
Dependencies
Express.js: Web framework for Node.js.
Mongoose: ODM for MongoDB.
dotenv: Environment variable management.

Related Projects

Sweets App (Flutter Frontend) - The mobile application that interacts with this backend.
